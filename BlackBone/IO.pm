package BlackBone::IO;

use strict;
use warnings;

################################################################################
sub write_file {
  my $file = shift;

  open(my $fh, '>', $file) or die "Could not open file for writing '$file': $!";

  print $fh @_;

  close($fh);
}

################################################################################
sub read_file {
  my $file = shift;
  local $/= undef;

  open(my $fh, '<', $file) or die "Could not open file for reading '$file': $!";

  my $text = <$fh>;

  close($fh);

  return $text;
}

1;  ## EOM
