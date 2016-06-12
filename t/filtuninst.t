use strict;
use warnings;
use FindBin;
use lib "$FindBin::RealBin/lib";
use TestUtil;

use Test::More;
use CPAN::Plugin::Sysdeps ();

plan 'no_plan';

my $p = CPAN::Plugin::Sysdeps->new('dryrun');
isa_ok $p, 'CPAN::Plugin::Sysdeps';

if ($p->{installer} =~ m{^(apt-get|pkg|homebrew|chocolatey)$}) {
    {
	my @packages = $p->_filter_uninstalled_packages(qw(libdoesnotexist1 libdoesnotexist2));
	is_deeply \@packages, [qw(libdoesnotexist1 libdoesnotexist2)];
    }
    {
	my @packages = $p->_filter_uninstalled_packages('libdoesnotexist1 | libdoesnotexist2');
	is_deeply \@packages, [qw(libdoesnotexist1)];
    }
}
