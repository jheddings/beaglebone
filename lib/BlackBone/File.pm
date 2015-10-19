package BlackBone::File;

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

################################################################################
sub read_expr {
  my ($file, $regex) = @_;

  $_ = read_file($file);
  m/$regex/;

  return $1;
}

################################################################################
sub read_int {
  return read_expr(shift, qr/(\d+)/);
}

1;  ## EOM
