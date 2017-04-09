#!/usr/bin/perl

use strict;
use warnings;
use Getopt::Long;
use 5.010;

my $name;
GetOptions("file=i" => \$name);
open(my $fh, '>', $name) or die $!;

my $cnt = 0;
my $sum_len = 0;

sub print_inf {
    my $str = join '', $sum_len, ' ', $cnt, ' ', $sum_len / $cnt;
    print $str;
    close $fh;
}

my $f = 0;
$SIG{INT} = sub {
    if ($f == 0) {
        $f = 1;
        print STDERR "Double Ctrl+C for exit";
    } else {
        print_inf();
        exit;
    }
};

say "Get ready";
while (my $s = <STDIN>) {
    $f = 0;
    $cnt++;
    $sum_len += length($s) - 1;
    syswrite($fh, $s, length($s));
}

print_inf();

1;
