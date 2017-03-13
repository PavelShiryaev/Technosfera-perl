#!/usr/bin/perl

use strict;
use warnings;
use 5.010;
use DDP;


my $filepath = $ARGV[0];
die "USAGE:\n$0 <log-file.bz2>\n"  unless $filepath;
die "File '$filepath' not found\n" unless -f $filepath;

my $parsed_data = parse_file($filepath);
report($parsed_data);
exit;

sub get_min {
    my $s = shift;
    $s =~ /([^:]*:+[^:]*:+[^:]*)/;
    return $1;
}

sub parse_file {
    my $file = shift;

    # you can put your code here

    my %res_h;
    my $result;
    my %use;
    my $total_count;
    my %h_m;
    open my $fd, "-|", "bunzip2 < $file" or die "Can't open '$file': $!";
    while (my $log_line = <$fd>) {
        $log_line =~ /(\S+)\s+\[(\N*)\]\s+\"(\N*)\"\s+(\S+)\s+(\S+)\s+\"(\N*)\"\s+\"(\N*)\"\s+\"(\N*)\"/;
        my $IP = $1; my $time = $2; my $str_get = $3; my $status = $4; my $cnt_b = $5; my $refferer = $6; my $user_agent = $7; my $coef = $8;
        $coef = 0 if ($coef eq "-");
        $total_count++;
        $h_m{get_min($time)} = 1;
        if (!$res_h{$IP}) {
            my %h;
            $h{"count"} = 1;
            if ($status eq "200") {
                $h{"data"} = $cnt_b * $coef;
            } else {
                $h{"data"} = 0;
            }
            $h{"data_" . $status} = $cnt_b;
            my %m;
            $m{get_min($time)} = 1;
            $h{"min"} = \%m;
            $res_h{$IP} = \%h;
        } else {
            $res_h{$IP}->{"count"}++;
            $res_h{$IP}->{"data"} += $cnt_b * $coef if ($status eq "200");
            if (!$res_h{$IP}->{"data_" . $status}) {
                $res_h{$IP}->{"data_" . $status} = $cnt_b;
            } else {
                $res_h{$IP}->{"data_" . $status} += $cnt_b;
            }
            if (!$res_h{$IP}->{"min"}->{get_min($time)}) {
                $res_h{$IP}->{"min"}->{get_min($time)} = 1;
            } else {
                $res_h{$IP}->{"min"}->{get_min($time)}++;
            }
        }
        $use{"data_" . $status} = 1;
        
        # you can put your code here
        # $log_line contains line from log file

    }
    close $fd;
    my @arr_data;
    for my $key(keys %use) {
        push @arr_data, $key;
    }
    @arr_data = sort @arr_data;
    my @head = ("IP", "count", "avg", "data", @arr_data);
    
    my @table;
    for my $key (keys %res_h) {
        my @a;
        push @a, $key, $res_h{$key}->{"count"}, $res_h{$key}->{"count"} / (scalar keys $res_h{$key}->{"min"}), $res_h{$key}->{"data"} / 1024;
        for my $var(@arr_data) {
            if (!$res_h{$key}->{$var}) {
                push @a, 0;
            } else {
                push @a, $res_h{$key}->{$var} / 1024;
            }
         }
         push @table, \@a;
    }
    @table = sort {$b->[1] <=> $a->[1]} @table;
    p $table[5];    



    my @total = ("total", $total_count, $total_count / (scalar keys %h_m));
    for my $i(0..($#arr_data + 1)) {
        push @total, 0;
    }
    for my $var(@table) {
        for my $i(3..$#$var) {
            $total[$i] += $var->[$i];
        }
    }
    say join " ", @total;    
   # p %res_h;
    # you can put your code here

    return $result;
}

sub report {
    my $result = shift;

    # you can put your code here

}
