#!perl -T

use Test::More;

use String::CityHash qw(:cityhash128);

my $str1 = 'test';

is join(',', cityhash128($str1)), '1241249899504012196,18153994964897029896';
is unpack('H*', cityhash128_bits($str1)), '1139ce35096d0ba4fbeff23c90eadf08';

my $str2 = 'Some string to be hashed';

is join(',', cityhash128($str2)), '7158100772055388118,11374470963207854096';
is unpack('H*', cityhash128_bits($str2)), '6356aeba18cf8fd69dda3d1395ffd810';

done_testing;
