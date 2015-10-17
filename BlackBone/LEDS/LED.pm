package BlackBone::LEDS::LED;

use strict;
use warnings;

use File::Basename;
use BlackBone::IO;

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
sub name {
  my $self = shift;

  return basename($self->{device});
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

  BlackBone::IO::write_file($self->{device} . '/brightness', "0\n");
}

################################################################################
sub brightness {
  my ($self, $bri) = @_;

  my $sysname = $self->{device} . '/brightness';

  # if the user set the brightness, write it here
  if ($bri) { BlackBone::IO::write_file($sysname, $bri); }

  return BlackBone::IO::read_file($sysname);
}

################################################################################
sub trigger {
  my ($self, $trigger) = @_;

  my $sysname = $self->{device} . '/trigger';

  # if the user set the trigger, write it here
  if ($trigger) { BlackBone::IO::write_file($sysname, $trigger); }

  # parse the trigger entry (brackets around the current value)
  $trigger = BlackBone::IO::read_file($sysname);
  $trigger =~ s/.*\[(.*)\].*/$1/gm;

  return $trigger;
}

################################################################################
# return an object representing the LED's current state, suitable for restoring
sub save {
  my $self = shift;

  return {
    trigger => $self->trigger(),
    brightness => $self->brightness()
  };
}

################################################################################
# restore this LED to the given state, previously returned by save()
sub restore {
  my ($self, $state) = @_;

  $self->trigger($state->{trigger});
  $self->brightness($state->{brightness});
}

################################################################################
sub to_string {
  my $self = shift;
  return $self->name();
}

1;  ## EOM
