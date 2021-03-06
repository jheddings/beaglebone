package Device::BeagleBone::PinLED;
use base qw(Device::BeagleBone::LED);

use strict;
use warnings;

################################################################################
sub new {
  my ($class, $pin) = @_;

  my $name = $pin->name;

  my $self = $class->SUPER::new($name);
  $self->{pin} = $pin;

  if ($pin->direction ne 'out') {
    $pin->direction('out');
  }

  return $self;
}

################################################################################
sub is_on {
  my $self = shift;
  return ($self->{pin}->value gt 0);
}

################################################################################
sub on {
  my $self = shift;
  $self->{pin}->high();
}

################################################################################
sub off {
  my $self = shift;
  $self->{pin}->low();
}

1;  ## EOM
