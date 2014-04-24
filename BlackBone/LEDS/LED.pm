package BlackBone::LEDS::LED;

use strict;
use warnings;

use File::Basename;

use overload '""' => \&to_string;

################################################################################
sub new {
  my $class = shift;

  my $self = {
    device => shift,
  };

  bless $self, $class;
  return $self;
}

################################################################################
sub to_string {
  my $self = shift;

  return basename($self->{device});
}

1;
