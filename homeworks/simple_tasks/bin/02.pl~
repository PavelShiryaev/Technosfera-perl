#!/usr/bin/perl

use warnings;
use 5.010;
use strict;

=encoding UTF8
=head1 SYNOPSYS
Вычисление простых чисел
=head1 run ($x, $y)
Функция вычисления простых чисел в диапазоне [$x, $y].
Пачатает все положительные простые числа в формате "$value\n"
Если простых чисел в указанном диапазоне нет - ничего не печатает.
Примеры: 
run(0, 1) - ничего не печатает.
run(1, 4) - печатает "2\n" и "3\n"
=cut

sub prime {
    my $x = shift;
    if ($x == 1) {
        return 0;
    }
    for (my $i = 2; $i * $i <= $x; $i++) {
        if ($x % $i == 0) {
            return 0;
        }
    }
    return 1;
}

sub run {
    my ($x, $y) = @_;
    for (my $i = $x; $i <= $y; $i++) {
        if ($i > 0 && prime($i) == 1) {

         print "$i\n";
        }
    }
}



run(-1, 1);

1;
