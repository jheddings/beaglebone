#!/usr/bin/perl -w

use strict;
use warnings;

use Test::More;

use Device::BeagleBone::SystemLED;

################################################################################
# make sure we can turn each of the system LED's on and off

my $ntests = 0;

foreach my $led (Device::BeagleBone::SystemLED::all()) {
  $led->on();
  ok($led->is_on, "$led is on");

  $led->off();
  ok(! $led->is_on, "$led is off");

  $ntests += 2;
}

done_testing($ntests);
