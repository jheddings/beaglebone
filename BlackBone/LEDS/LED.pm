package BlackBone::LEDS::LED;

use strict;
use warnings;

use overload '""' => \&to_string;

################################################################################
sub new {
  my $class = shift;

  my $self = {
    name => shift,
  };

  bless $self, $class;
  return $self;
}

################################################################################
sub name {
  my $self = shift;
  return $self->{name};
}

################################################################################
sub on { }
sub off { }
sub blink { }

################################################################################
sub save { }
sub restore { }

################################################################################
sub to_string {
  my $self = shift;
  return $self->{name};
}

1;  ## EOM
