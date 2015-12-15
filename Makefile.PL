#!/usr/bin/perl -w

use 5.014;
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME => 'Device::BeagleBone',
    VERSION_FROM => 'lib/Device/BeagleBone.pm',

    PREREQ_PM => {
      'Exporter::Easy' => 0.17
    },
);

sub MY::postamble {
    return <<'MAKE_FRAG';
%.dtbo : %.dts
	dtc -O dtb -o $@ -b 0 -@ $<
MAKE_FRAG
}
