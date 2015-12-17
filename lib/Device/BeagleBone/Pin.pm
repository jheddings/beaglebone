package Device::BeagleBone::Pin;

use strict;
use warnings;

use Device::BeagleBone::Util::SysFS qw( :all );

use overload '""' => \&to_string;

# for information controlling GPIO's in linux:
# https://www.kernel.org/doc/Documentation/gpio/sysfs.txt

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
# values: in, out, low, high
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
sub edge {
  my ($self, $edge) = @_;
  return $self->_regwr('edge', $edge);
}

################################################################################
sub active_low {
  my ($self, $val) = @_;
  return $self->_regwr('active_low', $val);
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
sub reset {
  my $self = shift;

  $self->edge('none');
  $self->active_low(0);
  $self->value(0);
  $self->direction('in');

  return;
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
