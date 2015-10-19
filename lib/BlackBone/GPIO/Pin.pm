package BlackBone::GPIO::Pin;

use strict;
use warnings;

use BlackBone::File;

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
    BlackBone::File::write_file($syspath, $val);
  }

  return BlackBone::File::read_word($syspath);
}

1;  ## EOM
