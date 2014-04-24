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
sub _write_device {
  my ($device, $text) = @_;

  open(my $fh, '>', $device) or die "Could not device for writing '$device': $!";
  print $fh $text;
  close($fh);
}

################################################################################
sub _read_device {
  my ($device) = @_;

  open(my $fh, '<', $device) or die "Could not device for reading '$device': $!";
  my $text = <$fh>;
  chomp($text);
  close($fh);

  return $text;
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

  my $max = _read_device($sys_max);
  _write_device($sys_bri, $max);
}

################################################################################
sub off {
  my $self = shift;

  _write_device($self->{device} . '/brightness', "0\n");
}

################################################################################
sub brightness {
  my ($self, $bri) = @_;

  my $sysname = $self->{device} . '/brightness';

  # if the user set the brightness, write it here
  if ($bri) { _write_device($sysname, $bri); }

  return _read_device($sysname);
}

################################################################################
sub trigger {
  my ($self, $trigger) = @_;

  my $sysname = $self->{device} . '/trigger';

  # if the user set the trigger, write it here
  if ($trigger) { _write_device($sysname, $trigger); }

  # parse the trigger entry (brackets around the current value)
  $trigger = _read_device($sysname);
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

1;
