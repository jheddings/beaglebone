package Device::BeagleBone::Black::GPIO;

use strict;
use warnings;

use Device::BeagleBone::Black::File;
use Device::BeagleBone::Black::GPIO::Pin;

my $pinmap = require Device::BeagleBone::Black::GPIO::PinMap;

my $GPIO_SYS_PATH = '/sys/class/gpio';

################################################################################
sub export {
  my $name = shift;

  # TODO better error checking
  my $pindef = $pinmap->{$name};
  my $gpio = $pindef->{gpio};

  # enable the GPIO entries in sysfs
  Device::BeagleBone::Black::File::write_file("$GPIO_SYS_PATH/export", $gpio);

  my $syspath = "$GPIO_SYS_PATH/gpio$gpio";
  my $pin = new Device::BeagleBone::Black::GPIO::Pin($syspath);

  # attach the pindef reference
  $pin->{pindef} = $pindef;

  return $pin;
}

################################################################################
sub unexport {
  my $name = shift;

  # TODO better error checking
  my $pindef = $pinmap->{$name};
  my $gpio = $pindef->{gpio};

  # enable the GPIO entries in sysfs
  Device::BeagleBone::Black::File::write_file("$GPIO_SYS_PATH/unexport", $gpio);
}

1;  ## EOM