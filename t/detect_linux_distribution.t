use strict;
use warnings;

use Test::More;

use CPAN::Plugin::Sysdeps ();

plan skip_all => "Only works on linux" if $^O ne 'linux';
plan 'no_plan';

SKIP: {
    my $info = CPAN::Plugin::Sysdeps::_detect_linux_distribution();
    # may happen for exotic or old linux distributions
    skip "Cannot detect linux distribution", if !$info;

    my $info_os_release;
    if (-e '/etc/os-release' || -e '/usr/lib/os-release') {
	$info_os_release = CPAN::Plugin::Sysdeps::_detect_linux_distribution_os_release();
	if (!$info_os_release) {
	    fail "Unexpected error: os-release file exists, but cannot be parsed";
	} else {
	    ok $info_os_release->{linuxdistro},         "via os-release: linuxdistro=$info_os_release->{linuxdistro}";
	    ok $info_os_release->{linuxdistroversion},  "via os-release: linuxdistroversion=$info_os_release->{linuxdistroversion}";
	    if ($info_os_release->{linuxdistrocodename}) {
		ok $info_os_release->{linuxdistrocodename}, "via os-release: linuxdistrocodename=$info_os_release->{linuxdistrocodename}";
	    } else {
		diag "linuxdistrocodename not defined";
	    }
	}
    }

    my $info_lsb_release;
    if (-x '/usr/bin/lsb_release') {
	$info_lsb_release = CPAN::Plugin::Sysdeps::_detect_linux_distribution_lsb_release();
	if (!$info_lsb_release) {
	    fail "Unexpected error: lsb_release exists, but output cannot be parsed";
	} else {
	    ok $info_lsb_release->{linuxdistro},         "via lsb_release: linuxdistro=$info_lsb_release->{linuxdistro}";
	    ok $info_lsb_release->{linuxdistroversion},  "via lsb_release: linuxdistroversion=$info_lsb_release->{linuxdistroversion}";
	    if (defined $info_lsb_release->{linuxdistrocodename}) {
		ok $info_lsb_release->{linuxdistrocodename}, "via lsb_release: linuxdistrocodename=$info_lsb_release->{linuxdistrocodename}";
	    } else {
		diag "linuxdistrocodename not defined";
	    }
	}
    }

    if ($info_os_release && $info_lsb_release) {
	is $info_lsb_release->{linuxdistro}, $info_os_release->{linuxdistro}, 'os-release vs lsb_release: compare linuxdistro';
	if ($info_os_release->{linuxdistro} =~ m{^(debian|ubuntu)$}) {
	    # inconsistent codename handling seen in CentOS + Fedora
	    is $info_lsb_release->{linuxdistrocodename}, $info_os_release->{linuxdistrocodename}, 'os-release vs lsb_release: compare linuxdistrocodename';
	} else {
	    no warnings 'uninitialized'; # codename may be unef
	    diag "linuxdistrocodename comparison: lsb_release=$info_lsb_release->{linuxdistrocodename} os-release=$info_os_release->{linuxdistrocodename}";
	}
	if ($info_os_release->{linuxdistro} eq 'debian') {
	    (my $lsb_major_version = $info_lsb_release->{linuxdistroversion}) =~ s{\..*}{};
	    is $lsb_major_version, $info_os_release->{linuxdistroversion}, 'os-release vs lsb_release: compare linuxdistroversion (debian: only major version)';
	} elsif ($info_os_release->{linuxdistro} =~ m{^(ubuntu|fedora)$}) {
	    is $info_lsb_release->{linuxdistroversion}, $info_os_release->{linuxdistroversion}, 'os-release vs lsb_release: compare linuxdistroversion (ubuntu+fedora: full version comparison)';
	} else {
	    diag "linuxdistroversion comparison: lsb_release=$info_lsb_release->{linuxdistroversion} os-release=$info_os_release->{linuxdistroversion}";
	}
    }
}




__END__
