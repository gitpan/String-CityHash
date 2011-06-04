#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'String::CityHash' ) || print "Bail out!
";
}

diag( "Testing String::CityHash $String::CityHash::VERSION, Perl $], $^X" );
