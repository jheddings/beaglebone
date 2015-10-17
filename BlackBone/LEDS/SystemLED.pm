package BlackBone::LEDS::SystemLED;
use base qw(BlackBone::LEDS::LED);

use strict;
use warnings;

use File::Spec;
use File::Basename;
use BlackBone::IO;

my $LEDS_SYS_PATH = '/sys/class/leds';

use overload '""' => \&to_string;

################################################################################
sub all {
  return map { new BlackBone::LEDS::SystemLED($_) } glob($LEDS_SYS_PATH . '/*');
}

################################################################################
sub get {
  my ($name) = @_;

  my $path = File::Spec->catfile($LEDS_SYS_PATH, $name);

  # TODO some better error handling
  -e $path or die;

  return new BlackBone::LEDS::SystemLED($path);
}

################################################################################
sub new {
  my ($class, $device) = @_;

  my $name = basename($device);

  my $self = $class->SUPER::new($name);
  $self->{device} = $device;

  return $self;
}

################################################################################
sub on {
  my $self = shift;

  my $sys_bri = $self->{device} . '/brightness';
  my $sys_max = $self->{device} . '/max_brightness';

  my $max = BlackBone::IO::read_file($sys_max);
  BlackBone::IO::write_file($sys_bri, $max);
}

################################################################################
sub off {
  my $self = shift;

  BlackBone::IO::write_file($self->{device} . '/brightness', "0");
}

################################################################################
sub brightness {
  my ($self, $bright) = @_;

  my $sysname = $self->{device} . '/brightness';

  # if the user set the brightness, write it here
  if ($bright) {
    BlackBone::IO::write_file($sysname, $bright);
  }

  $bright = BlackBone::IO::read_file($sysname);
  $bright =~ m/(\d+)/;

  return $1;
}

################################################################################
sub trigger {
  my ($self, $trigger) = @_;

  my $sysname = $self->{device} . '/trigger';

  # if the user set the trigger, write it here
  if ($trigger) {
    BlackBone::IO::write_file($sysname, $trigger);
  }

  # parse the trigger entry (brackets around the current value)
  $trigger = BlackBone::IO::read_file($sysname);
  $trigger =~ m/\[(.*)\]/;

  return $1;
}

################################################################################
# return an object representing the LED's current state, suitable for restoring
sub save {
  my $self = shift;

  return {
    trigger => $self->trigger(),
    bright => $self->brightness()
  };
}

################################################################################
# restore this LED to the given state, previously returned by save()
sub restore {
  my ($self, $state) = @_;

  $self->trigger($state->{trigger});
  $self->brightness($state->{bright});
}

################################################################################
sub to_string {
  my $self = shift;
  return $self->name();
}

1;  ## EOM
