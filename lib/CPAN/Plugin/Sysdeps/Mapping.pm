package CPAN::Plugin::Sysdeps::Mapping;

use strict;
use warnings;

sub mapping {
    (
     [cpandist => qr{^(Cairo-\d|Prima-Cairo-\d)}, # XXX base id or full dist name with author?
      [os => 'freebsd',
       [package => 'cairo']],
      [linuxdistro => '~debian',
       [package => 'libcairo2-dev']]],

     [cpandist => qr{^(Cairo-\d|Prima-Cairo-\d)}, # XXX base id or full dist name with author?
      sub {
	  my($self, $dist) = @_;
	  if ($dist->base_id =~ m{^(Cairo-\d|Prima-Cairo-\d)}) {
	      if ($^O eq 'freebsd') {
		  return { package => 'cairo' };
	      } elsif ($^O eq 'linux' && $self->{linuxdistro} =~ m{^(debian|ubuntu|linuxmint)$}) {
		  return { package => 'libcairo2-dev' };
	      }
	  }
      }],
    );
}

1;
