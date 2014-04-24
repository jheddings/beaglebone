package BlackBone::LEDS;

use strict;
use warnings;

use File::Spec;
use BlackBone::LEDS::LED;

my $LEDS_SYS_PATH = '/sys/class/leds';

################################################################################
sub all {
  return map { new BlackBone::LEDS::LED($_) } glob($LEDS_SYS_PATH . '/*');
}

################################################################################
sub get {
  my ($name) = @_;

  my $path = File::Spec->catfile($LEDS_SYS_PATH, $name);

  # TODO some better error handling
  -e $path or die;

  return new BlackBone::LEDS::LED($path);
}

1;
