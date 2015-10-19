#!/usr/bin/perl -w

use strict;
use warnings;

use FindBin;
use Test::Simple tests => 8;

use BlackBone::File;

my $datadir = "$FindBin::Bin/data";

my $basic_dat = BlackBone::File::read_file("$datadir/basic_text");
ok($basic_dat eq "basic text\n", 'basic read test');

my $multiline_dat = BlackBone::File::read_file("$datadir/multiline_text");
ok($multiline_dat eq "multiline\ntext\n", 'multiline read test');

my $word_dat = BlackBone::File::read_word("$datadir/basic_text");
ok($word_dat eq 'basic', 'basic read word test');

my $runtil_dat = BlackBone::File::read_until("$datadir/basic_text", 'x');
ok($runtil_dat eq 'basic te', 'read until x test');

my $int_dat = BlackBone::File::read_int("$datadir/integer");
ok($int_dat eq 42, 'read single integer from file');

my $expr_dat1 = BlackBone::File::read_expr("$datadir/mixed_data", qr/"(.*)"/);
ok($expr_dat1 eq 'test data', 'read expression on first line');

my $expr_dat2 = BlackBone::File::read_int("$datadir/mixed_data");
ok($expr_dat2 eq 24, 'read single integer from mixed text');

my $expr_dat3 = BlackBone::File::read_expr("$datadir/mixed_data", qr/@([^ ]+)/);
ok($expr_dat3 eq 'there', 'read expression from mixed text');

