package SecretSanta;

use 5.010;
use strict;
use warnings;
use DDP;

sub calculate {
	my @members = @_;
	my @res;
        my @a, my @b;
        my %pairs;
	for my $var (@members) {
	    if (ref $var) {
		for my $l (@$var) {
  		    push @a, $l;
                    push @b, $l; 
       		}
                $pairs{@$var[0]} = @$var[1];
                $pairs{@$var[1]} = @$var[0];
            } else {
                push @a, $var;     
                push @b, $var;
	    }
 	}
        while (1) {
            my @c = sort { int(rand(3))-1 } @b;
            my %p_res;
            for my $i (0..$#c) {
                $p_res{$a[$i]} = $c[$i];
            }
            my $f = 0;
            while (my ($k, $v) = each %p_res) {
                if (exists $pairs{$k} && $pairs{$k} eq $v) {
                    $f = 1;
                    last;
                } 
                if ($k eq $v || $p_res{$v} eq $k) {
                    $f = 1;
                    last;
                }
            }
            if ($f == 0) {
                while (my ($k, $v) = each %p_res) {
                    push @res, [$k, $v];
                }
                return @res;
            }  
        }
}
my @list = (['A','B'],['C','D'],'E','F');
calculate(@list);
1;
