package String::CityHash;
BEGIN {
  $String::CityHash::VERSION = '0.02';
}

use warnings;
use strict;

require Exporter;

our @ISA = qw(Exporter);

require XSLoader;
XSLoader::load('String::CityHash', $String::CityHash::VERSION);

=head1 NAME

String::CityHash - CityHash wrapper for Perl

=head1 VERSION

version 0.02

=head1 SYNOPSIS

    use String::CityHash qw(cityhash64);

    my $str = "Some string to be hashed";

    my $seed0 = 0x9ae16a3b2f90404f;
    my $seed1 = 0xc3a5c85c97cb3130;

    my $hash1 = cityhash64($str);
    my $hash2 = cityhash64($str, $seed0);
    my $hash3 = cityhash64($str, $seed0, $seed1);

    my $hash4 = cityhash128($str);

=head1 DESCRIPTION

L<CityHash|http://code.google.com/p/cityhash/> is a family of non-cryptographic hash functions for strings. It
provides hash functions designed for fast hashing of strings. The functions mix
the input bits thoroughly but are not suitable for cryptography.

CityHash is intended to be fast, under the constraint that it hash very well.

=head1 EXPORTS

This module exports the subroutines C<cityhash64> and C<cityhash128> on request.

=cut

our @EXPORT_OK = qw(
	cityhash64
	cityhash128
);

=head1 SUBROUTINES

=head2 cityhash64( $data [, $seed0 [, $seed1 ] ] )

Generate a 64-bit hash for the given data. The optional one or two 64-bit seeds
are also hashed into the result.

=head2 cityhash128( $data )

Generate a 128-bit hash for the given data.

=head1 AUTHOR

Alessandro Ghedini <alexbio@cpan.org>

=head1 SEE ALSO

L<CityHash|http://code.google.com/p/cityhash/>

=head1 LICENSE AND COPYRIGHT

Copyright 2011 Alessandro Ghedini.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1; # End of String::CityHash