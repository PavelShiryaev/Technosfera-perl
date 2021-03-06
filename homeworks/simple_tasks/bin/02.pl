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
    my $f = 1;
    $f = 0 if ($x == 1);
    for (my $i = 2; $i ** 2 <= $x; $i++) {
        $f = 0 if ($x % $i == 0);
    }
    return $f;
}

sub run {
    my ($x, $y) = @_;
    for (my $i = $x; $i <= $y; $i++) {
        print "$i\n" if ($i > 0 && prime($i) == 1); 
    }
}



run(-10, 10);

1;
