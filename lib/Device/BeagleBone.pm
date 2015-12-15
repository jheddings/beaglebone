package Device::BeagleBone;

use 5.014;
use strict;
use warnings;

our $VERSION = '0.01';

use Sys::Hostname;
use Device::BeagleBone::Util::SysFS qw( :read );

################################################################################
sub temperature {
  # FIXME this may not be consistent across all 'bones
  my $path = '/sys/class/hwmon/hwmon0/device/temp1_input';
  read_int($path) / 1000.0;
}

################################################################################
sub uptime {
  read_word('/proc/uptime');
}

################################################################################
*name = \&hostname;

1;  ## EOM
__END__

=head1 NAME

Device::BeagleBone - Perl library for working with the BeagleBone family.

=head1 SYNOPSIS

  use Device::BeagleBone::GPIO;
  use Device::BeagleBone::LEDS;

=head1 DESCRIPTION

TODO

=head1 AUTHOR

Jason Heddings, E<lt>jason@heddings.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2015 by Jason Heddings

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.18.2 or,
at your option, any later version of Perl 5 you may have available.

=cut
