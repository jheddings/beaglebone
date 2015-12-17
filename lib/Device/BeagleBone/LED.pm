package Device::BeagleBone::LED;

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
sub is_on { die('abstract method'); }

################################################################################
sub toggle {
  my $self = shift;

  if ($self->is_on) {
    $self->off();
  } else {
    $self->on();
  }
}

################################################################################
sub to_string {
  my $self = shift;
  return $self->{name};
}

1;  ## EOM
