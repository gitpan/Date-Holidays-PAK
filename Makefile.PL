use strict;use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Date::Holidays::PAK',
    AUTHOR        => q{Mohammad S Anwar <mohammad.anwar@yahoo.com>},
    VERSION_FROM  => 'lib/Date/Holidays/PAK.pm',
    ABSTRACT_FROM => 'lib/Date/Holidays/PAK.pm',
    dist          => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean         => { FILES => 'Date-Holidays-PAK-*' },
    PREREQ_PM     => {
        'Test::More'      => 0,
        'Readonly'        => 0,
        'Time::localtime' => 1.02,
        'Date::Hijri'     => '0.02',
        'Date::Calc'      => 5.7,
    },
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
);