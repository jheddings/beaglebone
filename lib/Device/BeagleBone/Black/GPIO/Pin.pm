package Device::BeagleBone::Black::GPIO::Pin;

use strict;
use warnings;

use Device::BeagleBone::Util::SysFS qw( :all );

use overload '""' => \&to_string;

################################################################################
sub new {
  my ($class, $name, $sysroot, $muxfile) = @_;

  my $self = {
    name => $name,
    sysroot => $sysroot,
    muxfile => $muxfile,
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
sub direction {
  my ($self, $dir) = @_;
  return $self->_regwr('direction', $dir);
}

################################################################################
sub value {
  my ($self, $val) = @_;
  return $self->_regwr('value', $val);
}

################################################################################
sub high {
  my $self = shift;
  return $self->value(1);
}

################################################################################
sub low {
  my $self = shift;
  return $self->value(0);
}

################################################################################
sub _regwr {
  my ($self, $key, $val) = @_;

  my $syspath = $self->{sysroot} . '/' . $key;

  # if the user set a value, write it here
  if (defined $val and length $val) {
    write_file($syspath, $val);
  }

  return read_word($syspath);
}

################################################################################
sub to_string {
  my $self = shift;
  return $self->{name};
}

1;  ## EOM
