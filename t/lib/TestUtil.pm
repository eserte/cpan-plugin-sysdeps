package
    TestUtil;

use strict;
use warnings;
use Exporter 'import';

our @EXPORT = qw(require_CPAN_Distribution);

sub require_CPAN_Distribution () {
    if (!eval { require CPAN::Distribution; 1 }) {
	require CPAN;
    }
}

1;
