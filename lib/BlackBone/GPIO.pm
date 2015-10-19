package BlackBone::GPIO;

use strict;
use warnings;

use BlackBone::File;
use BlackBone::GPIO::Pin;

my $pinmap = require BlackBone::GPIO::PinMap;

my $GPIO_SYS_PATH = '/sys/class/gpio';

################################################################################
sub export {
  my $name = shift;

  # TODO better error checking
  my $pindef = $pinmap->{$name};
  my $gpio = $pindef->{gpio};

  # enable the GPIO entries in sysfs
  BlackBone::File::write_file("$GPIO_SYS_PATH/export", $gpio);

  my $syspath = "$GPIO_SYS_PATH/gpio$gpio";
  return new BlackBone::GPIO::Pin($syspath);
}

1;  ## EOM