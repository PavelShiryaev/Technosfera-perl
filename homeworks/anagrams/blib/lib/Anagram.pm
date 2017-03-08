package Anagram;

use 5.010;
use strict;
use warnings;
use utf8;
use DDP;

=encoding UTF8

=head1 SYNOPSIS

Поиск анаграмм

=head1 anagram($arrayref)

Функцию поиска всех множеств анаграмм по словарю.

Входные данные для функции: ссылка на массив - каждый элемент которого - слово на русском языке в кодировке utf8

Выходные данные: Ссылка на хеш множеств анаграмм.

Ключ - первое встретившееся в словаре слово из множества
Значение - ссылка на массив, каждый элемент которого слово из множества, в том порядке в котором оно встретилось в словаре в первый раз.

Множества из одного элемента не должны попасть в результат.

Все слова должны быть приведены к нижнему регистру.
В результирующем множестве каждое слово должно встречаться только один раз.
Например

anagram(['пятак', 'ЛиСток', 'пятка', 'стул', 'ПяТаК', 'слиток', 'тяпка', 'столик', 'слиток'])

должен вернуть ссылку на хеш


{
    'пятак'  => ['пятак', 'пятка', 'тяпка'],
    'листок' => ['листок', 'слиток', 'столик'],
}

=cut

sub is_anagrams{
    my $s1 = shift;
    my $s2 = shift;
    my @a1 = split(//, $s1);
    my @a2 = split(//, $s2);
    my @r1;
    my @r2;
    for my $i(0 .. 32) {
        $r1[$i] = 0;
        $r2[$i] = 0;
    }
    my $f = 1;
    my %h1;
    for my $var(@a1) {
        if (!(exists $h1{$var})) {
            $h1{$var} = 1;
        } else {
            $h1{$var}++;
        }
    }
    my %h2;
    for my $var(@a2) {
        if (!(exists $h2{$var})) {
            $h2{$var} = 1;
        } else {
            $h2{$var}++;
        }
    }
    for my $var(keys %h1) {
        $f = 0 if (!(exists $h2{$var}) || $h2{$var} != $h1{$var});
    }
    $f = 0 if (scalar @a1 != scalar @a2);
    return $f;
}

sub create_arr {
    my @a;
    return \@a;
}

sub anagram {
    my $words_list = shift;
    my %result;

    for my $i (0 .. $#$words_list) {
        @$words_list[$i] = lc @$words_list[$i];
    }
    
    my %use;
    for my $i (0 .. $#$words_list) {
        if (! exists $use{$words_list -> [$i]}) {
            $use{$words_list -> [$i]} = 1;
            my $arr = create_arr();
            for my $j ($i + 1 .. $#$words_list) {
                if ((!(exists $use{$words_list -> [$j]})) && is_anagrams($words_list -> [$i], $words_list -> [$j])) {
                    push @$arr, $words_list -> [$j];
                    $use{$words_list -> [$j]} = 1;
                }
            }
            unshift @$arr, $words_list -> [$i];
            $result{$words_list -> [$i]} = $arr if (scalar @$arr > 1);
        }
    } 
    return \%result;

}

p anagram([qw(пятка слиток пятак ЛиСток стул ПяТаК тяпка столик слиток)]);
#p anagram(['слиток', 'столик', 'столик']);
1;
