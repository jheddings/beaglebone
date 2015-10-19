#!/usr/bin/perl -w

use strict;
use warnings;

use FindBin;
use Test::Simple tests => 6;

use BlackBone::File;

my $datadir = "$FindBin::Bin/data";

my $basic_test_data = BlackBone::File::read_file("$datadir/basic_text");
ok($basic_test_data eq "basic text\n", 'basic read test');

my $multiline_test_data = BlackBone::File::read_file("$datadir/multiline_text");
ok($multiline_test_data eq "multiline\ntext\n", 'multiline read test');

my $int_test_data = BlackBone::File::read_int("$datadir/integer");
ok($int_test_data eq 42, 'read single integer from file');

my $expr_dat1 = BlackBone::File::read_expr("$datadir/mixed_data", qr/"(.*)"/);
ok($expr_dat1 eq 'test data', 'read expression on first line');

my $expr_dat2 = BlackBone::File::read_int("$datadir/mixed_data");
ok($expr_dat2 eq 24, 'read single integer from mixed text');

my $expr_dat3 = BlackBone::File::read_expr("$datadir/mixed_data", qr/@([^ ]+)/);
ok($expr_dat3 eq 'there', 'read expression from mixed text');

