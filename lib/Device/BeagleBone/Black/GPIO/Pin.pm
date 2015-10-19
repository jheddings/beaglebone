package Device::BeagleBone::Black::GPIO::Pin;

use strict;
use warnings;

use Device::BeagleBone::Util::SysFS;

################################################################################
sub new {
  my ($class, $sysroot) = @_;

  my $self = {
    sysroot => $sysroot,
  };

  bless $self, $class;
  return $self;
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
    Device::BeagleBone::Util::SysFS::write_file($syspath, $val);
  }

  return Device::BeagleBone::Util::SysFS::read_word($syspath);
}

1;  ## EOM
