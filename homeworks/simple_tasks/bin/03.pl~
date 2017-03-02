#!/usr/bin/perl

use warnings;
use 5.010;
use strict;
use warnings;

=encoding UTF8
=head1 SYNOPSYS
Поиск наименьшего и наибольшего из 3-х чисел
=head1 run ($x, $y, $z)
Функция поиска минимального и максимального из 3-х чисел $x, $y, $z.
Пачатает минимальное и максимальное числа, в виде "$value1, $value2\n"
Примеры: 
run(1, 2, 3) - печатает "1, 3\n".
run(1, 1, 1) - печатает "1, 1\n"
run(1, 2, 2) - печатает "1, 2\n"
=cut

sub mn {
    my ($x, $y) = @_;
    if ($x < $y) {
        return $x;
    } else {
        return $y;
    }
}

sub mx {
    my ($x, $y) = @_;
    if ($x > $y) {
        return $x;
    } else {
        return $y;
    }
}

sub run {
    my ($x, $y, $z) = @_;
    my $min = undef;
    my $max = undef;
    
    $min = mn($x, mn($y, $z));
    $max = mx($x, mx($y, $z));

    print "$min, $max\n";
}

run (-3, -5, -2);
1;
