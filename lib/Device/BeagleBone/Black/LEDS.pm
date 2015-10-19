package Device::BeagleBone::Black::LEDS;

use strict;
use warnings;

################################################################################
sub restore_defaults {
  my $usr0_led = Device::BeagleBone::Black::LEDS::SystemLED::get('beaglebone:green:usr0');
  $usr0_led->trigger('heartbeat');

  my $usr1_led = Device::BeagleBone::Black::LEDS::SystemLED::get('beaglebone:green:usr1');
  $usr1_led->trigger('mmc0');

  my $usr2_led = Device::BeagleBone::Black::LEDS::SystemLED::get('beaglebone:green:usr2');
  $usr2_led->trigger('cpu0');

  my $usr3_led = Device::BeagleBone::Black::LEDS::SystemLED::get('beaglebone:green:usr3');
  $usr3_led->trigger('mmc1');
}

1;  ## EOM
