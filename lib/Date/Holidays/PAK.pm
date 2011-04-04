package Date::Holidays::PAK;

use strict; use warnings;

use overload q("") => \&as_string, fallback => 1;

use Carp;
use Readonly;
use Data::Dumper;

=head1 NAME

Date::Holidays::PAK - Interface to Pakistan national holidays.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

Readonly my $DEFAULT_YEAR => 2011;

Readonly my $MONTHS   => [ undef, 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec' ];

Readonly my $NAME =>
{
    1 => 'Pakistan Day',
    2 => 'Labour Day',
    3 => 'Independence Day',
    4 => 'Birthday of Mohammad Iqbal',
    5 => 'Birthday of Quaid-e-Azam Mohammad Ali Jinnah/Christmas Day',    
    6 => 'Eid-ul-Fitr Day 1',
    7 => 'Eid-ul-Fitr Day 2',
    8 => 'Eid-ul-Azha Day 1',
    9 => 'Eid-ul-Azha Day 2',
   10 => 'Milad-un-Nabi',
   11 => 'Ashura Day 1',
   12 => 'Ashura Day 2',
   13 => 'Shab-e-Miraj',
};
    
Readonly my $HOLIDAYS => 
{
    2011 => { 1 => { mm =>  3, dd => 23, day => 'Wed' },
              2 => { mm =>  5, dd =>  1, day => 'Sun' },
              3 => { mm =>  8, dd => 14, day => 'Sun' },
              4 => { mm => 11, dd =>  9, day => 'Wed' },
              5 => { mm => 12, dd => 25, day => 'Sun' },
              6 => { mm =>  8, dd => 30, day => 'Tue' },
              7 => { mm =>  8, dd => 31, day => 'Wed' },
              8 => { mm => 11, dd =>  6, day => 'Sun' },
              9 => { mm => 11, dd =>  7, day => 'Mon' },
             10 => { mm =>  2, dd => 12, day => 'Tue' },
             11 => { mm => 11, dd =>  5, day => 'Sat' },
             12 => { mm => 11, dd =>  6, day => 'Sun' },
             13 => { mm =>  6, dd => 29, day => 'Wed' },
            },
};

sub new
{
    my $class = shift;
    my $yyyy  = shift || $DEFAULT_YEAR;
    croak("ERROR: Invalid years [$yyyy].\n")
        unless ($yyyy =~ /^\d{4}$/);

    my $self  = { yyyy => $yyyy };
    $self->{holidays} = _build_holidays($yyyy);
    bless $self, $class;
    
    return $self;
}

=head1 SYNOPSIS

=head2 Pakistan Day (Yom-e-Pakistan)

The Pakistan Day is a national holiday in Pakistan to commemorate the Lahore Resolution.That was passed on 
March 23, 1940 in Lahore,by the Muslim League under the leadership of the founder of Pakistan, Quaid-e Azam 
Mohammad Ali Jinnah.This was a demand for a separate independent state for the Muslims of South Asia.It is 
a public holiday therefore all the government offices including banks and educational institutions will 
remain closed. 

=head2 Labour Day (Yom-e-Mazdoor)

Like other parts of the world,Labour Day also celebrated in Pakistan on 1 May.In Urdu this day called as 
Yom-e- Karegar.Various worker's organizations, associations and federations took out worker's rallies in 
different parts of the country,demonstrating their solidarity with the workers of the world in the struggle 
for their rights. 

=head2 Independence Day (Yom-e-Istiqlal)

Pakistan's independence day also known as Yom-e-Istiqlal.celebrated on 14 August. Pakistan became an independent 
country in 1947. It is the national holiday in Pakistan. This day celebrated all over the country with flag raising 
ceremonies, tributes to the national heroes and fireworks taking place in the capital, Islamabad. The main celebrations 
takes place in Islamabad, where the President and Prime Minister raise the national flag at the Presidential and 
Parliament buildings and deliver speeches that are televised live.

=head2 Birthday of Muhammad Iqbal

Sir Muhammad Iqbal was the poet, philosopher and politician in British India.He was the first person to give 
out the idea of creation of Pakistan.Being a close associate of Muhammad Ali Jinnah and an active member of 
the All India Muslim League that later spearheaded the Pakistan Movement, Iqbal is widely regarded as a 
national hero in Pakistan.The birth anniversary of Muhammad Iqbal on November 9.So this day declared as 
national holiday and a number of educational institutions organize programmes to shed light on the life 
and achievements of Mr. Iqbal. 

=head2 Birthday of Quaid-e-Azam Muhammad Ali Jinnah 

Mohammad Ali Jinnah was a 20th century lawyer, politician, statesman and the founder of Pakistan. He is 
popularly and officially known in Pakistan as Quaid-e-Azam.Jinnah served as leader of the All-India Muslim 
League from 1913 until Pakistan's independence on August 14, 1947 and Pakistan's first Governor-General 
from August 15, 1947 until his death on September 11, 1948.His birthday is a national holiday in Pakistan. 

=head2 Eid-ul-Fitr Day

Eid ul-Fitr is a Muslim holiday that marks the end of Ramadan, the Islamic holy month of fasting. Eid is 
an Arabic word meaning "festivity", while Fitr means "to break fast"; and so the holiday symbolizes the 
breaking of the fasting period. It is celebrated after the end of the Islamic month of Ramadan, on the 
first day of Shawwal.It is the day when the Muslims thank Allah for having given them the will, the strength 
and the endurance to observe fast and obey His commandment during the holy month of Ramadan.It is celebrated 
for two days in a holiday called Eid-ul-Fitr (the Feast of Fast Breaking). 

=head2 Eid ul-Azha Day

Eid al-Adha means "Festival of Sacrifice" or "Greater Eid" is an important holiday celebrated in Pakistan, 
to commemorate the willingness of Abraham (Ibrahim) to sacrifice his son Ishmael as an act of obedience to 
God. Eid al-Adha is celebrated annually on the 10th and 11th day of the month of Dhu al-Hijjah of the lunar 
Islamic calendar. 

=head2 Milad an-Nabi (Mawlid)

The Birth Day of Prophet Muhammad celebrated as Milad-un-Nabi or Mawlid,which occurs in Rabi' al-awwal, the 
third month in the Islamic calendar.During this occasion people decorate mosques, their houses and streets 
with colourful flags, lightings. Special activities including reciting of the Holy Quran, Mehfal-e-Naat and 
Qawalis are arranged. The women also arrange Milad Mehfils to pay tributes to Holy Prophet Muhammed. Milad 
an-Nabi is celebrated with very high spirit across Pakistan.

=head2 Ashura

It is commemorated as a day of mourning for the martyrdom of Husayn ibn Ali, the grandson of the Islamic 
Prophet Muhammad at the Battle of Karbala on 9th and 10th Muharram in the year 61 AH.In Pakistan this is 
the national holiday. 

=head2 Shab-e-Miraj

Celebrated on the 27th Rajab.

=head1 Holidays Table
    
    Date    Name
    Mar 23  Pakistan Day
    May 1   Labour day (May Day)
    Aug 14  Independence Day
    Nov 9   Birthday of Muhammad Iqbal 
    Dec 25  Birthday of Muhammad Ali Jinnah

    Dates following the Lunar Islamic calendar

    Dhul Hijja 10 & 11  Eid ul-Adha
    Shawwal 1 & 2       Eid-ul-Fitr   
    Rabi`-ul-Awwal 12   Milad-un-Nabi
    Muharram 9 & 10     Ashura    
    Rajab 27            Shab-e-Miraj

=head1 METHODS

=head2 get_holidays()

Return Pakistan national holidays.

    use strict; use warnings;
    use Date::Holidays::PAK;

    my $pak      = Date::Holidays::PAK->new(2011);
    my $holidays = $pak->get_holidays();

=cut

sub get_holidays
{
    my $self = shift;
    return $self->{holidays};
}

=head2 get_holidays_count()

Return Pakistan national holidays count.

    use strict; use warnings;
    use Date::Holidays::PAK;

    my $pak   = Date::Holidays::PAK->new(2011);
    my $count = $pak->get_holidays_count();

=cut

sub get_holidays_count
{
    my $self = shift;
    return scalar((keys %{$HOLIDAYS->{$self->{yyyy}}}));
}

=head2 as_string()

Return holidays in user readable format.

    use strict; use warnings;
    use Date::Holidays::PAK;

    my $pak = Date::Holidays::PAK->new(2011);
    print $pak->as_string();
    
    # or even simply
    print $pak;

=cut

sub as_string
{
    my $self = shift;
    my ($holidays);
    foreach (@{$self->{holidays}})
    {
        $holidays .= sprintf("%s, %02d %s %04d, %s.\n", $_->{day}, $_->{dd}, $MONTHS->[$_->{mm}], $_->{yyyy}, $_->{desc});
    }
    return $holidays;
}

sub _build_holidays
{
    my $yyyy = shift;
    
    my ($holidays);
    foreach (sort keys %{$HOLIDAYS->{$yyyy}})
    {
        push @{$holidays},
            {
                dd   => $HOLIDAYS->{$yyyy}->{$_}->{dd},
                mm   => $HOLIDAYS->{$yyyy}->{$_}->{mm},
                day  => $HOLIDAYS->{$yyyy}->{$_}->{day},
                yyyy => $yyyy,
                desc => $NAME->{$_}
            };
    }
    croak("ERROR: Data for year [$yyyy] is unavailable.\n")
        unless defined $holidays;

    return $holidays;
}

=head1 AUTHOR

Mohammad S Anwar, C<< <mohammad.anwar at yahoo.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-date-holidays-pak at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Date-Holidays-PAK>.
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Date::Holidays::PAK

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Date-Holidays-PAK>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Date-Holidays-PAK>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Date-Holidays-PAK>

=item * Search CPAN

L<http://search.cpan.org/dist/Date-Holidays-PAK/>

=back

=head1 ACKNOWLEDGEMENTS

The information here is based on http://en.wikipedia.org/wiki/Public_holidays_in_Pakistan.

=head1 LICENSE AND COPYRIGHT

Copyright 2011 Mohammad S Anwar.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=head1 DISCLAIMER

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

=cut

1; # End of Date::Holidays::PAK