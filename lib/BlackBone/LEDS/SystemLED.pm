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
}

################################################################################
sub off {
  my $self = shift;
  $self->brightness("0");
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

  BlackBone::File::write_file($self->syspath('delay_on'), $on_ms);
  BlackBone::File::write_file($self->syspath('delay_off'), $off_ms);
}

################################################################################
sub max_bright {
  my $self = shift;

  my $syspath = $self->syspath('max_brightness');

  return BlackBone::File::read_int($syspath);
}

################################################################################
sub brightness {
  my ($self, $bright) = @_;

  my $syspath = $self->syspath('brightness');

  # if the user set the brightness, write it here
  if (defined $bright and length $bright) {
    BlackBone::File::write_file($syspath, $bright);
  }

  return BlackBone::File::read_int($syspath);
}

################################################################################
sub trigger {
  my ($self, $trigger) = @_;

  my $syspath = $self->syspath('trigger');

  # if the user set the trigger, write it here
  if ($trigger) {
    BlackBone::File::write_file($syspath, $trigger);
  }

  # the trigger entry has brackets around the current value
  return BlackBone::File::read_expr($syspath, qr/\[(.*)\]/);
}

################################################################################
sub syspath {
  my ($self, $name) = @_;

  return File::Spec->catfile($self->{sysroot}, $name);
}

################################################################################
sub to_string {
  my $self = shift;
  return $self->name;
}

1;  ## EOM
