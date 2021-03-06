#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

=encoding UTF8
=head1 SYNOPSYS
Поиск количества вхождений строки в подстроку.
=head1 run ($str, $substr)
Функция поиска количества вхождений строки $substr в строку $str.
Пачатает количество вхождений в виде "$count\n"
Если вхождений нет - печатает "0\n".
Примеры: 
run("aaaa", "aa") - печатает "2\n".
run("aaaa", "a") - печатает "4\n"
run("abcab", "ab") - печатает "2\n"
run("ab", "c") - печатает "0\n"
=cut

sub run {
    my ($str, $substr) = @_;
    my $num = 0;
    my $len1 = length($str);
    my $len2 = length($substr);
    my $f = -1;
    while (1) {
        $f = index($str, $substr, $f + 1);
        last if ($f == -1);
        $num++;
    }
    print "$num\n";
}

run('abe#abab#deab', 'ab');

1;
