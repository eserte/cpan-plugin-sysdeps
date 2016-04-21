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
			$self->_debug("translate $match to $method");
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

sub _filter_uninstalled_packages {
    my($self, @packages) = @_;
    if ($self->{linuxdistro} eq 'debian') {
	warn "NYI: should use something like ~/devel/deb-install.pl, go on without filtering...";
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
	    @pre_cmd = ('sh', '-c', 'echo "Install package(s) @packages? (y/N) "; read yn; [ "$yn" = "y" ]');
	} else {
	    warn "batch=0 NYI for $self->{installer}";
	}
    }
    push @install_cmd, @packages;

    ((@pre_cmd ? \@pre_cmd : ()), \@install_cmd);
}

1;
