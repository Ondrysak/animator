#!/usr/bin/perl -w

use DateTime::Format::Strptime;



# (1) quit unless we have the correct number of command-line args
$num_args = $#ARGV + 1;
if ($num_args != 2) {
    print "\nUsage: dates.pl stringdatefmt date\n";
    exit;
}




my $trp = DateTime::Format::Strptime->new(
    pattern   => $ARGV[0],
    locale    => 'en-GB',
    time_zone => 'Europe/Prague',
    on_error  => 'croak',
    strict    => '1'
);


my $dt = $trp->parse_datetime($ARGV[1]);

print $dt->epoch;
