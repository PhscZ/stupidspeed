# task 13 matrix_mul — expected output: 599995000
# build: perl 13_matrix_mul.pl    run: perl 13_matrix_mul.pl
# note: flat arrays indexed i*n+j, and the plain i, j, k triple loop in that order: no reordering
#       and no library multiply.
use strict;
use warnings;

my $n = 500;
my $size = $n * $n;

my (@a, @b, @c);
$#a = $size - 1;
$#b = $size - 1;
$#c = $size - 1;

for (my $i = 0; $i < $n; $i++) {
    for (my $j = 0; $j < $n; $j++) {
        my $idx = $i * $n + $j;
        $a[$idx] = ($i + $j) % 7;
        $b[$idx] = ($i * $j) % 5;
    }
}

for (my $i = 0; $i < $n; $i++) {
    for (my $j = 0; $j < $n; $j++) {
        my $sum = 0;
        for (my $k = 0; $k < $n; $k++) {
            $sum += $a[$i * $n + $k] * $b[$k * $n + $j];
        }
        $c[$i * $n + $j] = $sum;
    }
}

my $total = 0;
for (my $i = 0; $i < $n; $i++) {
    for (my $j = 0; $j < $n; $j++) {
        $total += $c[$i * $n + $j];
    }
}

print $total, "\n";
