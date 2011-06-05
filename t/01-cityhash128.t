#!perl -T

use Test::More tests => 2;

use String::CityHash qw(cityhash128);

my $str1 = "test";
is(cityhash128($str1), "1800071687761605184910580728449884026697");

my $str2 = "Some string to be hashed";
is(cityhash128($str2), "465786504103183929415131635604191095235");

