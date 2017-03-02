#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

=encoding UTF8
=head1 SYNOPSYS
Поиск номера первого не нулевого бита.
=head1 run ($x)
Функция поиска первого не нулевого бита в 32-битном числе (кроме 0).
Пачатает номер первого не нулевого бита в виде "$num\n"
Примеры: 
run(1) - печатает "0\n".
run(4) - печатает "2\n"
run(6) - печатает "1\n"
=cut

sub run {
    my ($x) = @_;
    my $num = 0;

    while ($x != 0) {
        if (($x & 1) == 1) {
            last;
        }
        $num++;
        $x >>= 1;
    }

    print "$num\n";
}

run (0x80000000);
1;
