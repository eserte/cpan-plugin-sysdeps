use strict;
use warnings;

use CPAN::Distribution;
use Test::More 'no_plan';

use CPAN::Plugin::Sysdeps ();

{
    my $p = CPAN::Plugin::Sysdeps->new('apt-get', 'batch', 'dryrun');
    isa_ok $p, 'CPAN::Plugin::Sysdeps';
    my $cpandist = CPAN::Distribution->new(
					   ID => 'X/XX/XXX/Cairo-1.0.tar.gz',
					   CONTAINSMODS => { Cairo => undef },
					  );
    $p->post_get($cpandist);
}
