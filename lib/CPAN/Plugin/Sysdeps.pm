package CPAN::Plugin::Sysdeps;

use strict;
use warnings;

our $VERSION = '0.01';

use Hash::Util 'lock_keys';
use List::Util 'first';

our $TRAVERSE_ONLY; # only for testing

sub new {
    my($class, @args) = @_;

    my $installer;
    my $batch = 0;
    my $dryrun = 0;
    my $debug = 0;
    my @additional_mappings;
    my @args_errors;
    my $options;
    for my $arg (@args) {
	if (ref $arg eq 'HASH') {
	    if ($options) {
		die "Cannot handle multiple option hashes";
	    } else {
		$options = $arg;
	    }
	} elsif ($arg =~ m{^(apt-get|aptitude|pkg|yum)$}) { # XXX are there more package installers?
	    $installer = $1;
	} elsif ($arg eq 'batch') {
	    $batch = 1;
	} elsif ($arg eq 'interactive') {
	    $batch = 0;
	} elsif ($arg eq 'dryrun') {
	    $dryrun = 1;
	} elsif ($arg =~ m{^mapping=(.*)$}) {
	    push @additional_mappings, $1;
	} elsif ($arg =~ m{^debug(?:=(\d+))?$}) {
	    $debug = defined $1 ? $1 : 1;
	    require Data::Dumper; # we'll need it
	} else {
	    push @args_errors, $arg;
	}
    }
    if (@args_errors) {
	die 'Unrecognized ' . __PACKAGE__ . ' argument' . (@args_errors != 1 ? 's' : '') . ": @args_errors\n";
    }

    if (exists $ENV{CPAN_PLUGIN_SYSDEPS_DEBUG}) {
	$debug = $ENV{CPAN_PLUGIN_SYSDEPS_DEBUG};
    }

    my $os                  = $options->{os} || $^O;
    my $linuxdistro         = '';
    my $linuxdistroversion  = 0;
    my $linuxdistrocodename = '';
    if ($os eq 'linux') {
	# XXX fallback if lsb_release is unavailable?
	if (defined $options->{linuxdistro}) {
	    $linuxdistro = $options->{linuxdistro};
	} else {
	    chomp($linuxdistro = lc `lsb_release -is`);
	}

	if (defined $options->{linuxdistroversion}) {
	    $linuxdistroversion = $options->{linuxdistroversion};
	} else {
	    chomp($linuxdistroversion = `lsb_release -rs`); # XXX make it a version object? or make sure it's just X.Y?
	}

	if (defined $options->{linuxdistrocodename}) {
	    $linuxdistrocodename = $options->{linuxdistrocodename};
	} else {
	    chomp($linuxdistrocodename = `lsb_release -cs`);
	}
    }

    if (!$installer) {
	if      ($os eq 'freebsd') {
	    $installer = 'pkg';
	} elsif ($os eq 'linux') {
	    if      (__PACKAGE__->_is_linux_debian_like($linuxdistro)) {
		$installer = 'apt-get';
	    } elsif (__PACKAGE__->_is_linux_fedora_like($linuxdistro)) {
		$installer = 'yum';
	    } else {
		die __PACKAGE__ . " has no support for linux distribution $linuxdistro $linuxdistroversion\n";
	    }
	} else {
	    die __PACKAGE__ . " has no support for operating system $os\n";
	}
    }

    my @mapping;
    for my $mapping (@additional_mappings, 'CPAN::Plugin::Sysdeps::Mapping') {
	if (-r $mapping) {
	    push @mapping, require $mapping;
	} else {
	    eval "require $mapping"; die "Can't load $mapping: $@" if $@;
	    push @mapping, $mapping->mapping;
	}
    }

    my %config =
	(
	 installer           => $installer,
	 batch               => $batch,
	 dryrun              => $dryrun,
	 debug               => $debug,
	 os                  => $os,
	 linuxdistro         => $linuxdistro,
	 linuxdistroversion  => $linuxdistroversion,
	 linuxdistrocodename => $linuxdistrocodename,
	 mapping             => \@mapping,
	);
    my $self = bless \%config, $class;
    lock_keys %$self;
    $self;
}

# CPAN.pm plugin hook method
sub post_get {
    my($self, $dist) = @_;

    my @packages = $self->_map_cpandist($dist);
    if (@packages) {
	my @uninstalled_packages = $self->_filter_uninstalled_packages(@packages);
	if (@uninstalled_packages) {
	    my @cmds = $self->_install_packages_commands(@uninstalled_packages);
	    for my $cmd (@cmds) {
		if ($self->{dryrun}) {
		    warn "DRYRUN: @$cmd\n";
		} else {
		    warn "INFO: run @$cmd...\n";
		    system @$cmd;
		    if ($? != 0) {
			die "@$cmd failed, stop installation";
		    }
		}
	    }
	}
    }
}

# Helpers/Internal functions/methods
sub _is_linux_debian_like {
    my(undef, $linuxdistro) = @_;
    $linuxdistro =~ m{^(debian|ubuntu|linuxmint)$};
}

sub _is_linux_fedora_like {
    my(undef, $linuxdistro) = @_;
    $linuxdistro =~ m{^(fedora|redhat|centos)$};
}

sub _debug {
    my $self = shift;
    if ($self->{debug}) {
	print STDERR 'DEBUG: ';
	print STDERR join('', map {
	    if (ref $_) {
		Data::Dumper->new([$_])->Terse(1)->Indent(0)->Dump;
	    } else {
		$_;
	    }
	} @_);
	print STDERR "\n";
    }
}

sub _map_cpandist {
    my($self, $dist) = @_;

    # smartmatch for regexp/string/array without ~~, 5.8.x compat!
    my $smartmatch = sub ($$) {
	my($left, $right) = @_;
	if (ref $right eq 'Regexp') {
	    return 1 if $left =~ $right;
	} elsif (ref $right eq 'ARRAY') {
	    return 1 if first { $_ eq $left } @$right;
	} else {
	    return 1 if $left eq $right;
	}
    };

    my $handle_mapping_entry; $handle_mapping_entry = sub {
	my($entry, $level) = @_;
	for(my $map_i=0; $map_i <= $#$entry; $map_i++) {
	    my $key_or_subentry = $entry->[$map_i];
	    if (ref $key_or_subentry eq 'ARRAY') {
		$self->_debug(' ' x $level . ' traverse another tree level');
		my $res = $handle_mapping_entry->($key_or_subentry, $level+1);
		return $res if $res && !$TRAVERSE_ONLY;
	    } elsif (ref $key_or_subentry eq 'CODE') {
		my $res = $key_or_subentry->($self, $dist);
		return $res if $res && !$TRAVERSE_ONLY;
	    } else {
		my $key = $key_or_subentry;
		my $match = $entry->[++$map_i];
		$self->_debug(' ' x $level . " match '$key' against '", $match, "'");
		if ($key eq 'cpandist') {
		    return 0 if !$smartmatch->($dist->base_id, $match) && !$TRAVERSE_ONLY;
		} elsif ($key eq 'cpanmod') {
		    my $found = 0;
		    for my $mod ($dist->containsmods) {
			$self->_debug(' ' x $level . "  found module '$mod' in dist, check now against '", $match, "'");
			if ($smartmatch->($mod, $match)) {
			    $found = 1;
			    last;
			}
		    }
		    return 0 if !$found && !$TRAVERSE_ONLY;
		} elsif ($key eq 'os') {
		    return 0 if !$smartmatch->($self->{os}, $match) && !$TRAVERSE_ONLY;
		} elsif ($key eq 'linuxdistro') {
		    if ($match =~ m{^~(debian|fedora)}) {
			my $method = "_is_linux_$1_like";
			$self->_debug(' ' x $level . " translate $match to $method");
			return 0 if !$self->$method($self->{linuxdistro}) && !$TRAVERSE_ONLY;
		    } elsif ($match =~ m{^~}) {
			die "'like' matches only for debian and fedora";
		    } else {
			return 0 if !$smartmatch->($self->{linuxdistro}, $match) && !$TRAVERSE_ONLY;
		    }
		} elsif ($key eq 'linuxdistroversion') {
		    return 0 if !$smartmatch->($self->{linuxdistroversion}, $match) && !$TRAVERSE_ONLY; # XXX should do a numerical comparison instead!
		} elsif ($key eq 'linuxdistrocodename') {
		    return 0 if !$smartmatch->($self->{linuxdistrocodename}, $match) && !$TRAVERSE_ONLY; # XXX should also do a smart codename comparison additionally!
		} elsif ($key eq 'package') {
		    $self->_debug(' ' x $level . " found $match"); # XXX array?
		    return { package => $match };
		} else {
		    die "Invalid key '$key'"; # XXX context/position?
		}
	    }
	}
    };

    for my $entry (@{ $self->{mapping} || [] }) {
	my $res = $handle_mapping_entry->($entry, 0);
	if ($res && !$TRAVERSE_ONLY) {
	    return ref $res->{package} eq 'ARRAY' ? @{ $res->{package} } : $res->{package};
	}
    }

    ();
}

sub _find_missing_deb_packages {
    my($self, @packages) = @_;
    # taken from ~/devel/deb-install.pl
    my %seen_packages;
    my @missing_packages;

    my @cmd = ('dpkg-query', '-W', '-f=${Package} ${Status}\n', @packages);
    require IPC::Open3;
    require Symbol;
    my $err = Symbol::gensym();
    my $fh;
    my $pid = IPC::Open3::open3(undef, $fh, $err, @cmd)
	or die "Error running '@cmd': $!";
    while(<$fh>) {
	chomp;
	if (m{^(\S+) (.*)}) {
	    if ($2 ne 'install ok installed') {
		push @missing_packages, $1;
	    } else {
		$seen_packages{$1} = 1;
	    }
	} else {
	    warn "ERROR: cannot parse $_, ignore line...\n";
	}
    }
    waitpid $pid, 0;

    for my $package (@packages) {
	if (!$seen_packages{$package}) {
	    push @missing_packages, $package;
	}
    }
    @missing_packages;
}

sub _filter_uninstalled_packages {
    my($self, @packages) = @_;
    if ($self->{linuxdistro} eq 'debian') {
	my @plain_packages;
	my @missing_packages;
	for my $package_spec (@packages) {
	    if ($package_spec =~ m{\|}) { # has alternatives
		my @single_packages = split /\s*\|\s*/, $package_spec;
		my @missing_in_packages_spec = $self->_find_missing_deb_packages(@single_packages);
		if (@missing_in_packages_spec == @single_packages) {
		    push @missing_packages, $single_packages[0];
		}
	    } else {
		push @plain_packages, $package_spec;
	    }
	}
	push @missing_packages, $self->_find_missing_deb_packages(@plain_packages);
	@packages = @missing_packages;
    } elsif ($self->{os} eq 'freebsd') {
	my @missing_packages;
	for my $package (@packages) {
	    my @cmd = ('pkg', 'info', '--exists', $package);
	    system @cmd;
	    if ($? != 0) {
		push @missing_packages, $package;
	    }
	}
	@packages = @missing_packages;
    } else {
	warn "check for installed packages is NYI for $self->{os}/$self->{linuxdistro}";
    }
    @packages;
}

sub _install_packages_commands {
    my($self, @packages) = @_;
    my @pre_cmd;
    my @install_cmd;
    if ($< != 0) {
	push @install_cmd, 'sudo';
    }
    push @install_cmd, $self->{installer};
    if ($self->{batch}) {
	if ($self->{installer} =~ m{^(apt-get|aptitude)$}) {
	    push @install_cmd, '-y';
	} else {
	    warn "batch=1 NYI for $self->{installer}";
	}
    } else {
	if ($self->{installer} =~ m{^(apt-get|aptitude)$}) {
	    @pre_cmd = ('sh', '-c', 'echo -n "Install package(s) '."@packages".'? (y/N) "; read yn; [ "$yn" = "y" ]');
	} else {
	    warn "batch=0 NYI for $self->{installer}";
	}
    }
    push @install_cmd, 'install'; # XXX is this universal?
    push @install_cmd, @packages;

    ((@pre_cmd ? \@pre_cmd : ()), \@install_cmd);
}

1;

__END__

=head1 NAME

CPAN::Plugin::Sysdeps - a CPAN.pm plugin for installing system dependencies

=head1 SYNOPSIS

In the CPAN.pm shell:

    o conf plugin_list push CPAN::Plugin::Sysdeps
    o conf commit

=head1 DESCRIPTION

B<CPAN::Plugin::Sysdeps> is a plugin for L<CPAN.pm|CPAN> to install
non-CPAN dependencies automatically. Currently, the list of required
system dependencies is maintained in a static data structure in
L<CPAN::Plugin::Sysdeps::Mapping>. Supported operations systems and
distributions are FreeBSD and Debian-like Linux distributions.

The plugin may be configured like this:

    o conf plugin_list CPAN::Plugin::Sysdeps,arg1,arg2,...

Possible arguments are:

=over

=item C<apt-get>, C<aptitude>, <pkg>, <yum>

Force a particular installer for system packages. If not set, then the
plugin find a default for the current operating system or linux
distributions:

=over

=item Debian-like distributions: C<apt-get>

=item Fedora-like distributions: C<yum>

=item FreeBSD: C<pkg>

=back

Additionally, L<sudo(1)> is prepended before the installer programm if
the current user is not a privileged one.

=item C<batch>

Don't ask any questions.

=item C<interactive>

Be interactive, especially ask for confirmation before installing a
system package.

=item C<dryrun>

Only log installation actions.

=item C<mapping=I<perlmod|file>>

Prepend another static mapping from cpan modules or distributions to
system packages. This should be specified as a perl module
(I<Foo::Bar>) or an absolute file name. The mapping file is supposed
to just return the mapping data structure as described below.

=back

=head2 MAPPING

!This description is subject to change!

A mapping is tree-like data structure expressed as nested arrays. The
top-level nodes usually specify a cpan module or distribution to
match, and a leaf should specify the dependent system packages.

A sample mapping may look like this:

    (
     [cpanmod => ['BerkeleyDB', 'DB_File'],
      [os => 'freebsd',
       [package => 'db48']],
      [linuxdistro => '~debian',
       [linuxdistrocodename => 'squeeze',
	[package => 'libdb4.8-dev']],
       [linuxdistrocodename => 'wheezy',
	[package => 'libdb5.1-dev']],
       [package => 'libdb5.3-dev']]],
    );

The nodes are key-value pairs. The values may be strings, arrays of
strings (meaning that any of the strings may match), or compiled
regular expressions.

Supported keywords are:

=over

=item cpanmod => I<$value>

Match a CPAN module name (e.g. C<Foo::Bar>).

=item cpandist => I<$value>

Match a CPAN distribution name (e.g. C<Foo-Bar-1.23>). Note that
currently only the base_id is matched; this may change!

=item os => I<$value>

Match a operating system (perl's C<$^O> value).

=item linuxdistro => I<$value>

Match a linux distribution name, as returned by C<lsb_release -is>.
The distribution name is lowercased.

There are special values C<~debian> to match Debian-like distributions
(Ubuntu and LinuxMint) and C<~fedora> to match Fedora-like
distributions (RedHat and CentOS).

=item linuxdistrocodename => I<$value>

Match a linux distribution version using its code name (e.g.
C<jessie>).

TODO: it should be possible to express comparisons with code names,
e.g. '>=squeeze'.

=item linuxdistroversion => I<$value>

Match a linux distribution versions. Comparisons like '>=8.0' are
possible.

=item package => I<$value>

Specify the dependent system packages.

=back

=head1 AUTHOR

Slaven Rezic

=head1 SEE ALSO

L<cpan-sysdeps>, L<CPAN>, L<apt-get(1)>, L<aptitude(1)>, L<pkg(8)>, L<yum(1)>.

=cut
