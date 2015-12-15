#!/usr/bin/perl -w

use strict;
use warnings;

use Test::Simple tests => 2;
use Device::BeagleBone;

################################################################################

ok(Device::BeagleBone::temperature gt 0.0, 'cpu temperature is greater than 0.0');
ok(Device::BeagleBone::uptime gt 0, 'uptime is greater than 0');

