package Device::BeagleBone::Util::SysFS;

use strict;
use warnings;

use Exporter::Easy (
  TAGS => [
    read => [qw( read_file read_until read_word read_int read_expr )],
    write => [qw( write_file )],
    all => [qw( :read :write )],
  ]
);

################################################################################
sub write_file {
  my $file = shift;

  open(my $fh, '>', $file) or die "Could not open file for writing '$file': $!";

  print $fh @_;

  close($fh);
  return;
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
