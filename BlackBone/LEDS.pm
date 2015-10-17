package BlackBone::LEDS;

use strict;
use warnings;

my @_saved = ( );

################################################################################
sub save {
  foreach my $led (@_) {
    my @state = ( $led, $led->save() );
    push @_saved, \@state;
  }
}

################################################################################
sub restore {
  foreach my $save (@_saved) {
    $save->[0]->restore($save->[1]);
  }
}

1;  ## EOM
