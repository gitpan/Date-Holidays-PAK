#!perl

use Test::More tests => 2;

use strict; use warnings;
use Date::Holidays::PAK;

my $holidays = Date::Holidays::PAK->new(2011);
my $expected = [
    { day => 'Wed', dd =>  9, mm => 11, yyyy => 2011, desc => 'Birthday of Mohammad Iqbal.' },
    { day => 'Wed', dd => 23, mm =>  3, yyyy => 2011, desc => 'Pakistan Day.' },
    { day => 'Sun', dd => 14, mm =>  8, yyyy => 2011, desc => 'Independence Day.' },
    { day => 'Sun', dd =>  1, mm =>  5, yyyy => 2011, desc => 'Labour Day.' },
    { day => 'Sun', dd => 25, mm => 12, yyyy => 2011, desc => 'Birthday of Quaid-e-Azam Mohammad Ali Jinnah/Christmas Day.' },
    { day => 'Wed', dd => 31, mm =>  8, yyyy => 2011, desc => 'Eid-ul-Fitr Day 1.' },
    { day => 'Mon', dd =>  5, mm => 12, yyyy => 2011, desc => 'Asehura Day 1.' },
    { day => 'Thu', dd =>  1, mm =>  9, yyyy => 2011, desc => 'Eid-ul-Fitr Day 2.' },
    { day => 'Tue', dd =>  8, mm => 11, yyyy => 2011, desc => 'Eid-ul-Azha Day 2.' },
    { day => 'Tue', dd =>  6, mm => 12, yyyy => 2011, desc => 'Ashura Day 2.' },
    { day => 'Mon', dd =>  7, mm => 11, yyyy => 2011, desc => 'Eid-ul-Azha Day 1.' },
    { day => 'Wed', dd => 16, mm =>  2, yyyy => 2011, desc => 'Milad-un-Nabi.' },
    { day => 'Wed', dd => 29, mm =>  6, yyyy => 2011, desc => 'Shab-e-Miraj.' },
];

is($holidays->get_holidays_count(), 13);

ok($holidays->get_holidays(), $expected);