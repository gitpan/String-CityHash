#!perl -T

use Test::More;

use String::CityHash qw(:cityhash64);

my $seed0 = 12345;
my $seed1 = 54321;

my $str1 = 'test';

is cityhash64($str1), '8581389452482819506';
is cityhash64($str1, $seed0), '9154302171269876511';
is cityhash64($str1, $seed0, $seed1), '4854399283587686019';

is unpack('H*', cityhash64_bits($str1)), '7717383daa85b5b2';
is unpack('H*', cityhash64_bits($str1, $seed0)), '7f0a9d52bd20cb1f';
is unpack('H*', cityhash64_bits($str1, $seed0, $seed1)), '435e4a6dc0279e83';

my $str2 = 'Some string to be hashed';

is cityhash64($str2), '1913933300403985036';
is cityhash64($str2, $seed0), '6244958432173816888';
is cityhash64($str2, $seed0, $seed1), '10043790076975170456';

is unpack('H*', cityhash64_bits($str2)), '1a8fa8323e5eda8c';
is unpack('H*', cityhash64_bits($str2, $seed0)), '56aa8c9b5accfc38';
is unpack('H*', cityhash64_bits($str2, $seed0, $seed1)), '8b62b5dc58b2c398';

done_testing;
