package Device::BeagleBone::Black::GPIO;

use strict;
use warnings;

use Device::BeagleBone::Util::SysFS qw( :write );
use Device::BeagleBone::Black::GPIO::Pin;

my $pinmap = require Device::BeagleBone::Black::GPIO::PinMap;

use constant GPIO_SYS_PATH => '/sys/class/gpio';

################################################################################
sub export {
  my $pinref = shift;

  my $pindef = $pinmap->{$pinref};
  my $gpio = $pindef->{gpio};
  my $name = $pindef->{name};
  my $syspath = GPIO_SYS_PATH . "/gpio$gpio";

  # TODO better error checking
  $gpio or die "Invalid pin reference: $pinref\n";

  # enable the GPIO entries in sysfs if needed
  -d $syspath or write_file(GPIO_SYS_PATH . '/export', $gpio);

  my $pin = new Device::BeagleBone::Black::GPIO::Pin($name, $syspath);

  # attach the pindef reference
  $pin->{pindef} = $pindef;

  return $pin;
}

################################################################################
sub unexport {
  my $pinref = shift;

  my $pindef = $pinmap->{$pinref};
  my $gpio = $pindef->{gpio};

  # TODO better error checking
  $gpio or die "Invalid pin reference: $pinref\n";

  # disable the GPIO entries in sysfs
  write_file(GPIO_SYS_PATH . '/unexport', $gpio);
}

################################################################################
sub P8 {
  my $pin = shift;
  return export("P8.$pin");
}

################################################################################
sub P9 {
  my $pin = shift;
  return export("P9.$pin");
}

1;  ## EOM
