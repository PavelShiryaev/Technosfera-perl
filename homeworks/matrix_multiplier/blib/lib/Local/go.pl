use strict;
use warnings;
use 5.010;
use MatrixMultiplier;
use DDP;

my $mat_a = [
    [1, 2, 2, 2, 2, 2, 2, 2, 2, 2],
    [3, 4, 2, 2, 2, 2, 2, 2, 2, 2],
    [3, 4, 2, 2, 2, 2, 2, 2, 2, 2],
    [3, 4, 2, 2, 2, 2, 2, 2, 2, 2],
    [3, 4, 2, 2, 2, 2, 2, 2, 2, 2],
    [3, 4, 2, 2, 2, 2, 2, 2, 2, 2],
    [3, 4, 2, 2, 2, 2, 2, 2, 2, 2],
    [3, 4, 2, 2, 2, 2, 2, 2, 2, 2],
    [3, 4, 2, 2, 2, 2, 2, 2, 2, 2],
    [3, 4, 2, 2, 2, 2, 2, 2, 2, 2],
];

my $mat_b = [
    [3, 4, 2, 2, 2, 2, 2, 2, 2, 2],
    [3, 4, 2, 2, 2, 2, 2, 2, 2, 2],
    [3, 4, 2, 2, 2, 2, 2, 2, 2, 2],
    [3, 4, 2, 2, 2, 2, 2, 2, 2, 2],
    [3, 4, 2, 2, 2, 2, 2, 2, 2, 2],
    [3, 4, 2, 2, 2, 2, 2, 2, 2, 2],
    [3, 4, 2, 2, 2, 2, 2, 2, 2, 2],
    [3, 4, 2, 2, 2, 2, 2, 2, 2, 2],
    [3, 4, 2, 2, 2, 2, 2, 2, 2, 2],
    [3, 4, 2, 2, 2, 2, 2, 2, 2, 2],
];

p Local::MatrixMultiplier::mult($mat_a, $mat_b, 100);
1;
