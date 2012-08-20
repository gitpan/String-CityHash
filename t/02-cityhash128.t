#!perl -T

use Test::More tests => 4;

use String::CityHash qw(:cityhash128);

my $str1 = 'test';
is(join(',', cityhash128($str1)), '18000716877616051849,10580728449884026697');
is(unpack('H*', cityhash128_bits($str1)), 'f9cf64a0d8aef68992d64c775034f749');

my $str2 = 'Some string to be hashed';
is(join(',', cityhash128($str2)), '4657865041031839294,15131635604191095235');
is(unpack('H*', cityhash128_bits($str2)), '40a40f938e69be3ed1fe5e694276a9c3');
