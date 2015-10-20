use 5.014002;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME => 'Device::BeagleBone',
    VERSION_FROM => 'lib/Device/BeagleBone.pm',

    PREREQ_PM => {
      'Exporter::Easy' => 0.17
    },
);
