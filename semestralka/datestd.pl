#!/usr/bin/perl -w

use DateTime::Format::Strptime;



# (1) quit unless we have the correct number of command-line args
$num_args = $#ARGV + 1;
if ($num_args != 1) {
    print "\nUsage: name.pl stringdatefmt\n";
    exit;
}




my $trp = DateTime::Format::Strptime->new(
    pattern   => $ARGV[0],
    locale    => 'cs_CZ',
    time_zone => 'Europe/Prague',
);

while(<STDIN>){
my $dt = $trp->parse_datetime($_);
print $dt->epoch;
}
