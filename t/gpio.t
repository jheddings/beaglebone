#!/usr/bin/perl -w

use strict;
use warnings;

use Test::Simple tests => 10;

use Device::BeagleBone::Black::GPIO;
use Device::BeagleBone::Util::SysFS qw( :read );

################################################################################
sub read_direction {
  my $pin = shift;
  my $syspath = $pin->{sysroot} . '/direction';
  return read_word($syspath);
}

################################################################################
sub read_value {
  my $pin = shift;
  my $syspath = $pin->{sysroot} . '/value';
  return read_int($syspath);
}

################################################################################

# XXX this is a 'safe' pin to mess with on a stock BeagleBone
my $pinref = 'P9.12';

my $pin = Device::BeagleBone::Black::GPIO::export($pinref);

my $gpio = $pin->{pindef}->{gpio};
ok(-e "/sys/class/gpio/gpio$gpio", "gpio $gpio is visible");

$pin->direction('out');
ok($pin->direction eq 'out', 'pin direction read back as out');
ok(read_direction($pin) eq 'out', 'pin sysfs direction is out');

$pin->value(1);
ok($pin->value eq 1, 'pin value is 1');
ok(read_value($pin) eq 1, 'pin sysfs value is 1');

$pin->high();
ok($pin->value, 'pin is high');
ok(read_value($pin), 'pin sysfs value is high');

$pin->low();
ok(! $pin->value, 'pin is low');
ok(! read_value($pin), 'pin sysfs value is low');

Device::BeagleBone::Black::GPIO::unexport($pinref);
ok(! -e "/sys/class/gpio/gpio$gpio", "gpio $gpio is invisible");

