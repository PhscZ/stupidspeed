# task 12 matrix_add — expected output: 999000000
# build: perl main.pl    run: perl main.pl
# note: flat arrays indexed i*n+j. A Perl array costs about 64 bytes an element, so the three
#       1,000,000-element arrays are roughly 64 MB each and nothing else is allocated.
use strict;
use warnings;

my $n = 1000;
my $size = $n * $n;

my (@a, @b, @c);
$#a = $size - 1;
$#b = $size - 1;
$#c = $size - 1;

for (my $i = 0; $i < $n; $i++) {
    for (my $j = 0; $j < $n; $j++) {
        my $idx = $i * $n + $j;
        $a[$idx] = $i + $j;
        $b[$idx] = $i - $j;
    }
}

for (my $i = 0; $i < $n; $i++) {
    for (my $j = 0; $j < $n; $j++) {
        my $idx = $i * $n + $j;
        $c[$idx] = $a[$idx] + $b[$idx];
    }
}

my $total = 0;
for (my $i = 0; $i < $n; $i++) {
    for (my $j = 0; $j < $n; $j++) {
        $total += $c[$i * $n + $j];
    }
}

print $total, "\n";
