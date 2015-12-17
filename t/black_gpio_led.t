#!/usr/bin/perl -w

use strict;
use warnings;

use Test::Simple tests => 9;

use Device::BeagleBone::Black::GPIO;
use Device::BeagleBone::PinLED;
use Device::BeagleBone::Util::SysFS qw( :read );

################################################################################

# XXX be sure to use a safe debug pin...
my $pin = Device::BeagleBone::Black::GPIO::export('P9.12');
my $led = new Device::BeagleBone::PinLED($pin);

# wrapping as an LED should force the pic dorection 'out'
ok($pin->direction eq 'out', 'pin direction read back as out');

$led->on();
ok($pin->value, 'pin value is 1');
ok($led->is_on, 'led is on');

$led->off();
ok(! $pin->value, 'pin value is 0');
ok(! $led->is_on, 'led is off');

my $on = $led->toggle();
ok($pin->value, 'pin toggled to 1');
ok($on, 'pin toggled on');

$on = $led->toggle();
ok(! $pin->value, 'pin toggled to 0');
ok(! $on, 'pin toggled off');

