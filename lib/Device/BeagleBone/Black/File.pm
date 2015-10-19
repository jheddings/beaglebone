package Device::BeagleBone::Black::File;

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
sub read_until {
  my ($file, $eof) = @_;
  local $/ = $eof;

  open(my $fh, '<', $file) or die "Could not open file for reading '$file': $!";

  my $text = <$fh>;

  close($fh);

  chomp $text;
  return $text;
}

################################################################################
sub read_file {
  my $file = shift;
  return read_until($file, undef);
}

################################################################################
sub read_word {
  my $file = shift;
  my $raw = read_until($file, ' ');
  my ($word) = split /\s/, $raw;
  return $word;
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