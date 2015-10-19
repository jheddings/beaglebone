#!/usr/bin/perl -w

use strict;
use warnings;

use Test::Simple tests => 8;

use BlackBone::GPIO;

################################################################################
sub read_direction {
  my $pin = shift;
  my $syspath = $pin->{sysroot} . '/direction';
  return BlackBone::File::read_word($syspath);
}

################################################################################
sub read_value {
  my $pin = shift;
  my $syspath = $pin->{sysroot} . '/value';
  return BlackBone::File::read_int($syspath);
}

################################################################################
my $pin = BlackBone::GPIO::export('P9.12');
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
