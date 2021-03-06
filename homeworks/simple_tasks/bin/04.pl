#!/usr/bin/perl

use warnings;
use 5.010;
use strict;

=encoding UTF8
=head1 SYNOPSYS
<<<<<<< HEAD
Поиск номера первого не нулевого бита.
=head1 run ($x)
Функция поиска первого не нулевого бита в 32-битном числе (кроме 0).
Пачатает номер первого не нулевого бита в виде "$num\n"
=======

Поиск номера первого ненулевого бита.

=head1 run ($x)

Функция поиска первого ненулевого бита в 32-битном числе (кроме 0).
Пачатает номер первого ненулевого бита в виде "$num\n"

>>>>>>> upstream/master
Примеры: 
run(1) - печатает "0\n".
run(4) - печатает "2\n"
run(6) - печатает "1\n"
=cut

sub run {
    my ($x) = @_;
    my $num = 0;

    while ($x != 0) {
        last if (($x & 1) == 1);
        $num++;
        $x >>= 1;
    }

    print "$num\n";
}

run (1);
1;
