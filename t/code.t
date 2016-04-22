use strict;
use warnings;
use FindBin;
use lib "$FindBin::RealBin/lib";
use TestUtil;

use Test::More 'no_plan';
use CPAN::Plugin::Sysdeps ();
require_CPAN_Distribution;

my $cpandist = CPAN::Distribution->new(
				       ID => 'X/XX/XXX/Cairo-1.0.tar.gz',
				       CONTAINSMODS => { Cairo => undef },
				      );

{
    my $p = CPAN::Plugin::Sysdeps->new('apt-get', 'batch', 'dryrun', "mapping=$FindBin::RealBin/mapping/code.pl");
    $p->post_get($cpandist);
    pass 'traverse only did not fail';
}
