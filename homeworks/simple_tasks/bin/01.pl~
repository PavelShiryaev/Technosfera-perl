use warnings;
use 5.010;
use strict;
use warnings;

sub run {
    my ($a_value, $b_value, $c_value) = @_;
    my $x1 = undef;
    my $x2 = undef;
    my $d = $b_value * $b_value - 4 * $a_value * $c_value;
    if ($d < 0 || $a_value == 0) {
        print "No solution!\n";
        return;
    }
    $x1 = (-$b_value + sqrt($d)) / (2 * $a_value);
    $x2 = (-$b_value - sqrt($d)) / (2 * $a_value);
    print "$x1, $x2\n";
}

run(5, 6, 7);
1;
