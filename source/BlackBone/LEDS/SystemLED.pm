package BlackBone::LEDS::SystemLED;
use base qw(BlackBone::LEDS::LED);

use strict;
use warnings;

use File::Spec;
use File::Basename;
use BlackBone::File;

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

  # TODO better error handling
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

  $self->trigger('none');
  $self->brightness($self->max_bright);
}

################################################################################
sub off {
  my $self = shift;

  $self->trigger('none');
  $self->brightness("0");
}

################################################################################
sub blink {
  my ($self, $on_ms, $off_ms) = @_;

  $self->trigger('timer');

  BlackBone::File::write_file($self->syspath('delay_on'), $on_ms);
  BlackBone::File::write_file($self->syspath('delay_off'), $off_ms);
}

################################################################################
sub max_bright {
  my $self = shift;

  my $sysname = $self->syspath('max_brightness');

  my $max_bright = BlackBone::File::read_file($sysname);
  $max_bright =~ m/(\d+)/;

  return $1;
}

################################################################################
sub brightness {
  my ($self, $bright) = @_;

  my $sysname = $self->syspath('brightness');

  # if the user set the brightness, write it here
  if (defined $bright and length $bright) {
    BlackBone::File::write_file($sysname, $bright);
  }

  $bright = BlackBone::File::read_file($sysname);
  $bright =~ m/(\d+)/;

  return $1;
}

################################################################################
sub trigger {
  my ($self, $trigger) = @_;

  my $sysname = $self->syspath('trigger');

  # if the user set the trigger, write it here
  if ($trigger) {
    BlackBone::File::write_file($sysname, $trigger);
  }

  # parse the trigger entry (brackets around the current value)
  $trigger = BlackBone::File::read_file($sysname);
  $trigger =~ m/\[(.*)\]/;

  return $1;
}

################################################################################
sub syspath {
  my ($self, $name) = @_;

  return File::Spec->catfile($self->{device}, $name);
}

################################################################################
sub to_string {
  my $self = shift;
  return $self->name;
}

1;  ## EOM
