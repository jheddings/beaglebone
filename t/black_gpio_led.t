#!/usr/bin/perl -w

use strict;
use warnings;

use Test::Simple tests => 5;

use Device::BeagleBone::Black::GPIO;
use Device::BeagleBone::Black::LEDS::PinLED;
use Device::BeagleBone::Util::SysFS qw( :read );

################################################################################

# XXX be sure to use a safe debug pin...
my $pin = Device::BeagleBone::Black::GPIO::export('P9.12');
my $led = Device::BeagleBone::Black::LED::PinLED($pin);

# wrapping as an LED should force the pic dorection 'out'
ok($pin->direction eq 'out', 'pin direction read back as out');

$led->on();
ok($pin->value, 'pin value is 1');
ok($led->is_on, 'led is on');

$led->off();
ok(! $pin->value, 'pin value is 0');
ok(! $led->is_on, 'led is off');

