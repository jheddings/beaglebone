#!/usr/bin/perl -w

use strict;
use warnings;

use Test::Simple tests => 13;

use Device::BeagleBone::Black::LEDS;
use Device::BeagleBone::SystemLED;
use Device::BeagleBone::Util::SysFS qw( :read );

################################################################################
sub read_trigger {
  my $led = shift;
  my $syspath = $led->{sysroot} . '/trigger';
  return read_expr($syspath, qr/\[(.*)\]/);
}

################################################################################
sub read_bright {
  my $led = shift;
  my $syspath = $led->{sysroot} . '/brightness';
  return read_int($syspath);
}

################################################################################
sub read_delay_on {
  my $led = shift;
  my $syspath = $led->{sysroot} . '/delay_on';
  return read_int($syspath);
}

################################################################################
sub read_delay_off {
  my $led = shift;
  my $syspath = $led->{sysroot} . '/delay_off';
  return read_int($syspath);
}

################################################################################
my $usr0_led = Device::BeagleBone::SystemLED::get('beaglebone:green:usr0');

$usr0_led->trigger('none');
ok($usr0_led->trigger eq 'none', 'usr0_led trigger read back as none');
ok(read_trigger($usr0_led) eq 'none', 'usr0_led trigger sysfs entry is none');

$usr0_led->on();
ok(read_bright($usr0_led) gt 0, 'usr0_led is on');

$usr0_led->off();
ok(read_bright($usr0_led) eq 0, 'usr0_led is off');

################################################################################
my $usr1_led = Device::BeagleBone::SystemLED::get('beaglebone:green:usr1');

$usr1_led->blink(763, 384);

ok($usr1_led->trigger eq 'timer', 'usr1_led trigger set as timer');
ok(read_trigger($usr1_led) eq 'timer', 'usr1_led trigger sysfs entry is timer');

ok(read_delay_on($usr1_led) eq 763, 'usr1_led delay_on');
ok(read_delay_off($usr1_led) eq 384, 'usr1_led delay_off');

$usr1_led->blink(500, 500);

select(undef, undef, undef, 0.250);
my $usr1_is_on = $usr1_led->is_on;

select(undef, undef, undef, 0.500);
ok($usr1_is_on ne $usr1_led->is_on, 'usr1_led blinked');

################################################################################
my $usr2_led = Device::BeagleBone::SystemLED::get('beaglebone:green:usr2');
$usr2_led->trigger('none');

################################################################################
my $usr3_led = Device::BeagleBone::SystemLED::get('beaglebone:green:usr3');
$usr3_led->trigger('none');

################################################################################
## CLEANUP
Device::BeagleBone::Black::LEDS::restore_defaults();
ok($usr0_led->trigger eq 'heartbeat', 'usr0_led trigger reset to heartbeat');
ok($usr1_led->trigger eq 'mmc0', 'usr1_led trigger reset to mmc0');
ok($usr2_led->trigger eq 'cpu0', 'usr2_led trigger reset to cpu0');
ok($usr3_led->trigger eq 'mmc1', 'usr3_led trigger reset to mmc1');

