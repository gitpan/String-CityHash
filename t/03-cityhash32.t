#!perl -T

use Test::More;

use String::CityHash qw(:cityhash32);

my $str1 = 'test';
is cityhash32($str1), '1633095781';

my $str2 = 'Some string to be hashed';
is cityhash32($str2), '514909308';

done_testing;
