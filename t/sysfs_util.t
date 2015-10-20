#!/usr/bin/perl -w

use strict;
use warnings;

use FindBin;
use Test::Simple tests => 9;

use Device::BeagleBone::Util::SysFS qw( :all );

my $datadir = "$FindBin::Bin/data";

my $dat = read_file("$datadir/basic_text");
ok($dat eq "basic text\n", 'basic read test');

$dat = read_file("$datadir/multiline_text");
ok($dat eq "multiline\ntext\n", 'multiline read test');

$dat = read_word("$datadir/basic_text");
ok($dat eq 'basic', 'basic read word test');

$dat = read_word("$datadir/multiline_text");
ok($dat eq 'multiline', 'multiline read word test');

$dat = read_until("$datadir/basic_text", 'x');
ok($dat eq 'basic te', 'read until x test');

$dat = read_int("$datadir/integer");
ok($dat eq 42, 'read single integer from file');

$dat = read_expr("$datadir/mixed_data", qr/"(.*)"/);
ok($dat eq 'test data', 'read expression on first line');

$dat = read_int("$datadir/mixed_data");
ok($dat eq 24, 'read single integer from mixed text');

$dat = read_expr("$datadir/mixed_data", qr/@([^ ]+)/);
ok($dat eq 'there', 'read expression from mixed text');

