package Local::MatrixMultiplier;

use strict;
use warnings;
use 5.010;
use DDP;
use POSIX ":sys_wait_h";

sub check_matrix {
    my ($mat, $n) = @_;
    die if (scalar @$mat != $n);
    for my $var(@$mat) {
        die if (scalar @$var != $n);
    }
}

sub calc {
    my ($mat_a, $mat_b, $i, $j, $n, $res) = @_;
    for my $k(0..$n - 1){
        $res->[$i]->[$j] += $mat_a->[$i]->[$k] * $mat_b->[$k]->[$j];
    }
}

sub mult {
    my ($mat_a, $mat_b, $max_child) = @_;
    my $res = [];
    my $n = scalar @$mat_a;
    check_matrix($mat_a, $n);
    check_matrix($mat_b, $n);
    
    my %h;
    my $i = 0;
    $max_child--;
    while ($i < $n) {
        my $j = 0;
        while ($j < $n) {
            if ($max_child > 0) {
                $max_child--;
                my ($r, $w);
                pipe($r, $w);
                if (my $ch = fork()) {
                    $h{$ch} = $r;
                    close($w);
                } else {
                    close($r);
                    calc($mat_a, $mat_b, $i, $j, $n, $res);
                    print {$w} $res->[$i]->[$j].' '.$i.' '.$j.' ';
                    close($w);
                    exit;
                }
                $j++;
            } else {
                wait();
                $max_child++;
            }
        }
        $i++;
    }

    for my $key (keys %h) {
        my $b = $h{$key};
        my @a = split(' ', <$b>);
        $res->[$a[1]]->[$a[2]] = $a[0];
        close $b;
    }
    return $res;
}

1;
