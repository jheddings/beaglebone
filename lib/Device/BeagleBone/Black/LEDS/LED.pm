package Device::BeagleBone::Black::LEDS::LED;

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
sub on { die('abstract method'); }
sub off { die('abstract method'); }
sub blink { die('abstract method'); }

################################################################################
sub to_string {
  my $self = shift;
  return $self->{name};
}

1;  ## EOM
