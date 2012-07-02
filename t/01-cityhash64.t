#!perl -T

use Test::More tests => 12;

use String::CityHash qw(cityhash64 cityhash64_bits);

my $seed0 = 12345;
my $seed1 = 54321;

my $str1 = 'test';
is(cityhash64($str1), '17703940110308125106');
is(cityhash64($str1, $seed0), '14900027982776226655');
is(cityhash64($str1, $seed0, $seed1), '11136353178704814373');

is(unpack('H*', cityhash64_bits($str1)),
	unpack('H*', pack('Q>', 17703940110308125106)));
is(unpack('H*', cityhash64_bits($str1, $seed0)),
	unpack('H*', pack('Q>', 14900027982776226655)));
is(unpack('H*', cityhash64_bits($str1, $seed0, $seed1)),
	unpack('H*', pack('Q>', 11136353178704814373)));

my $str2 = 'Some string to be hashed';
is(cityhash64($str2), '3122603809047816403');
is(cityhash64($str2, $seed0), '16308842577497931009');
is(cityhash64($str2, $seed0, $seed1), '11835502851687917937');

is(unpack('H*', cityhash64_bits($str2)),
	unpack('H*', pack('Q>', 3122603809047816403)));
is(unpack('H*', cityhash64_bits($str2, $seed0)),
	unpack('H*', pack('Q>', 16308842577497931009)));
is(unpack('H*', cityhash64_bits($str2, $seed0, $seed1)),
	unpack('H*', pack('Q>', 11835502851687917937)));
