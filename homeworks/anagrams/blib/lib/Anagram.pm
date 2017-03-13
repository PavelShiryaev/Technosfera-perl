package Anagram;

use 5.010;
use strict;
use warnings;
use DDP;
use Encode qw(decode encode);

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
    my $a1 = join('', sort split(//, $s1));
    my $a2 = join('', sort split(//, $s2));
    return $a1 eq $a2;
}

sub anagram {
    my $words_list = shift;
    my %result;
    my $words;
    for my $i(0..$#$words_list) {
        $words->[$i] = decode("UTF-8", $words_list->[$i]);
    }
    for my $i (0 .. $#$words) {
        $$words[$i] = lc $$words[$i];
    }

    my %use;
    for my $i (0 .. $#$words) {
        if (!$use{$words->[$i]}) {
            $use{$words->[$i]} = 1;
            my @arr;
            for my $j ($i + 1 .. $#$words) {
                if (!$use{$words->[$j]} && is_anagrams($words->[$i], $words->[$j])) {
                    push @arr, encode("UTF-8", $words->[$j]);;
                    $use{$words->[$j]} = 1;
                }
            }
            unshift @arr, encode("UTF-8", $words->[$i]);;
            $result{encode("UTF-8", $words->[$i])} = \@arr if (@arr > 1);
        }
    } 
    return \%result;
}

1;
