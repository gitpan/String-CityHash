#!perl -T

use Test::More tests => 4;

use String::CityHash qw(cityhash128 cityhash128_bits);

my $str1 = 'test';
is(join(',', cityhash128($str1)), '18000716877616051849,10580728449884026697');
is(unpack('H*', cityhash128_bits($str1)),
	unpack('H*', pack('Q>2', 18000716877616051849, 10580728449884026697)));

my $str2 = 'Some string to be hashed';
is(join(',', cityhash128($str2)), '4657865041031839294,15131635604191095235');
is(unpack('H*', cityhash128_bits($str2)),
	unpack('H*', pack 'Q>2', 4657865041031839294, 15131635604191095235));
