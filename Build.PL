use strict;use warnings;
use Module::Build;

my $builder = Module::Build->new(
    sign              => 1,
    module_name       => 'Date::Holidays::PAK',
    license           => 'perl',
    dist_author       => q{Mohammad S Anwar <mohammad.anwar@yahoo.com>},
    dist_version_from => 'lib/Date/Holidays/PAK.pm',
    add_to_cleanup    => [ 'Date-Holidays-PAK-*' ],
    build_requires    => {
        'Test::More'      => 0,
        'Readonly'        => '1.03',
        'Time::localtime' => '1.02',
        'Calendar::Hijri' => '0.05',
        'Date::Calc'      => '5.7',
    },
);

$builder->create_build_script();