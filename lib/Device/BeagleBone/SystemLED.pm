package Device::BeagleBone::SystemLED;
use base qw(Device::BeagleBone::LED);

use strict;
use warnings;

use File::Basename;
use Device::BeagleBone::Util::SysFS qw( :all );

use constant LEDS_SYS_PATH => '/sys/class/leds';

################################################################################
sub all {
  return map { new Device::BeagleBone::SystemLED($_) } glob(LEDS_SYS_PATH . '/*');
}

################################################################################
sub get {
  my ($name) = @_;

  my $sysroot = LEDS_SYS_PATH . "/$name";

  # TODO better error handling
  -e $sysroot or die;

  return new Device::BeagleBone::SystemLED($sysroot);
}

################################################################################
sub new {
  my ($class, $sysroot) = @_;

  my $name = basename($sysroot);

  my $self = $class->SUPER::new($name);
  $self->{sysroot} = $sysroot;

  return $self;
}

################################################################################
sub on {
  my $self = shift;
  $self->brightness($self->max_bright);

  return;
}

################################################################################
sub off {
  my $self = shift;
  $self->brightness("0");

  return;
}

################################################################################
sub is_on {
  my $self = shift;
  return ($self->brightness gt 0);
}

################################################################################
sub blink {
  my ($self, $on_ms, $off_ms) = @_;

  # we need to set the trigger to ensure the delay_X entries appear
  $self->trigger('timer');

  write_file($self->{sysroot} . '/delay_on', $on_ms);
  write_file($self->{sysroot} . '/delay_off', $off_ms);

  return;
}

################################################################################
sub max_bright {
  my $self = shift;

  my $syspath = $self->{sysroot} . '/max_brightness';

  return read_int($syspath);
}

################################################################################
sub brightness {
  my ($self, $bright) = @_;

  my $syspath = $self->{sysroot} . '/brightness';

  # if the user set the brightness, write it here
  if (defined $bright and length $bright) {
    write_file($syspath, $bright);
  }

  return read_int($syspath);
}

################################################################################
sub trigger {
  my ($self, $trigger) = @_;

  my $syspath = $self->{sysroot} . '/trigger';

  # if the user set the trigger, write it here
  if ($trigger) {
    write_file($syspath, $trigger);
  }

  # the trigger entry has brackets around the current value
  return read_expr($syspath, qr/\[(.*)\]/);
}

1;  ## EOM
