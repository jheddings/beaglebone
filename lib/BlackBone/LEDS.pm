package BlackBone::LEDS;

use strict;
use warnings;

################################################################################
sub restore_defaults {
  my $usr0_led = BlackBone::LEDS::SystemLED::get('beaglebone:green:usr0');
  $usr0_led->trigger('heartbeat');

  my $usr1_led = BlackBone::LEDS::SystemLED::get('beaglebone:green:usr1');
  $usr1_led->trigger('mmc0');

  my $usr2_led = BlackBone::LEDS::SystemLED::get('beaglebone:green:usr2');
  $usr2_led->trigger('cpu0');

  my $usr3_led = BlackBone::LEDS::SystemLED::get('beaglebone:green:usr3');
  $usr3_led->trigger('mmc1');
}

1;  ## EOM
