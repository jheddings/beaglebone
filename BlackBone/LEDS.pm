package BlackBone::LEDS;

use strict;
use warnings;

use File::Spec;
use BlackBone::LEDS::LED;

my $LEDS_SYS_PATH = '/sys/class/leds';

my %_saved;

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

################################################################################
sub save_all { save(all()); }

################################################################################
sub save {
  for my $led (@_) {
    $_saved{$led->name()} = $led->save();
  }
}

################################################################################
sub restore {
  for my $name (keys %_saved) {
    my $led = get($name);
    my $state = $_saved{$name};
    $led->restore($state);
  }
}

1;
