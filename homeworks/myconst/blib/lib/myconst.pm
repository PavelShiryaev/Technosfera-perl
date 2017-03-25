package myconst;

use strict;
use warnings;
use Scalar::Util 'looks_like_number';
use 5.010;

=encoding utf8

=head1 NAME

myconst - pragma to create exportable and groupped constants

=head1 VERSION

Version 1.00

=cut

our $VERSION = '1.00';

=head1 SYNOPSIS
package aaa;

use myconst math => {
        PI => 3.14,
        E => 2.7,
    },
    ZERO => 0,
    EMPTY_STRING => '';

package bbb;

use aaa qw/:math PI ZERO/;

print ZERO;             # 0
print PI;               # 3.14
=cut

no strict 'refs';
sub import {
    shift;
    die 'error' if (ref $_[0]);
    my (%h) = @_;
    my $caller = caller;
    our @export;
    our @export_ok;
    our %export_tags;
    our @all;
    for my $key(keys %h) {
        if (ref $h{$key} eq 'HASH') {
            my %hh = %{$h{$key}};
            my @a;
            for my $key1(keys %hh) {
                die 'error' if (ref $hh{$key1});
                *{$caller . "::" . $key1} = sub(){$hh{$key1}};
                push @export, $key1;
                push @a, $key1;
                push @all, $key1;
            }
            $export_tags{$key} = \@a;
        } elsif (ref $h{$key}) {
            die 'error';
        } 
        *{$caller . "::" . $key} = sub(){$h{$key}};
        push @export, $key;
        push @export_ok, $key;
        push @all, $key;
    }
    $export_tags{'all'} = \@all;
    *{$caller . "::" . 'EXPORT'} = \@export;
    *{$caller . "::" . 'EXPORT_OK'} = \@export_ok;
    *{$caller . "::" . 'EXPORT_TAGS'} = \%export_tags;
    *{$caller . "::" . 'import'} = \&Exporter::import;
}

1;
