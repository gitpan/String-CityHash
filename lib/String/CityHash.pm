package String::CityHash;
{
  $String::CityHash::VERSION = '0.10';
}

use v5.10;

use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

require XSLoader;
XSLoader::load('String::CityHash', $String::CityHash::VERSION);

=head1 NAME

String::CityHash - Perl bindings to the CityHash hash functions

=head1 VERSION

version 0.10

=head1 SYNOPSIS

    use String::CityHash qw(:all);

    my $str = "Some string to be hashed";

    my $seed0 = 0x9ae16a3b2f90404f;
    my $seed1 = 0xc3a5c85c97cb3130;

    my $hash1 = cityhash64($str);                 # as integer
    my $hash2 = cityhash64($str, $seed0);
    my $hash3 = cityhash64($str, $seed0, $seed1);

    my $hash4 = cityhash64_bits($str);            # 8-byte string holding int
    my $hash5 = cityhash64_bits($str, $seed0);
    my $hash6 = cityhash64_bits($str, $seed0, $seed1);

    my ($l,$h) = cityhash128($str);               # low and high 64-bit parts,
                                                  # as integers

    my $hash7  = cityhash128_bits($str);          # 16-byte string holding low
                                                  # then high 64-bit integers

=head1 DESCRIPTION

L<CityHash|http://code.google.com/p/cityhash/> is a family of non-cryptographic
hash functions for strings. It provides hash functions designed for fast hashing
of strings. The functions mix the input bits thoroughly but are not suitable for
cryptography. CityHash is intended to be fast, under the constraint that it
hashes very well.

=head1 EXPORTS

This module exports the subroutines C<cityhash64>, C<cityhash64_bits>,
C<cityhash128> and C<cityhash128_bits> on request.

=cut

our @EXPORT_OK = qw(
	cityhash64
	cityhash64_bits
	cityhash128
	cityhash128_bits
);

our %EXPORT_TAGS = (
	all         => [@EXPORT_OK],
	cityhash64  => [qw(cityhash64 cityhash64_bits)],
	cityhash128 => [qw(cityhash128 cityhash128_bits)]
);

=head1 SUBROUTINES

=head2 cityhash64( $data [, $seed0 [, $seed1 ] ] )

Generate a 64-bit hash for the given data. The optional one or two 64-bit seeds
are also hashed into the result.

=head2 cityhash64_bits( $data [, $seed0 [, $seed1 ] ] )

Likewise, but returns a packed 8-byte binary string of hash in network byte order.

=head2 cityhash128( $data )

Generate a 128-bit hash for the given data. Returns a list of the low and high
64-bit portions of the hash. In scalar context returns only the low portion.

=head2 cityhash128_bits( $data )

Generate a 128-bit hash for the given data. Returns a packed 16-byte binary string
containing the low 64 bits then high 64 bits; each 8-byte portion is in network
byte order. Extract with e.g. C<unpack 'QE<gt>2'>.

=head1 ACKNOWLEDGMENTS

Since version 0.06 C<cityhash128> returns either a list of the high and low
portions of the 128-bit hash (in list context), or only the 64-bit low portion
of the hash (in scalar context).

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
