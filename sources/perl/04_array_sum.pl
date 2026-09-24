# task 04 array_sum — expected output: 499999500000
# build: perl 04_array_sum.pl    run: perl 04_array_sum.pl
use strict;
use warnings;

my $n = 1000000;
my @array;
$#array = $n - 1;

for (my $i = 0; $i < $n; $i++) {
    $array[$i] = $i;
}

my $total = 0;
for (my $i = 0; $i < $n; $i++) {
    $total += $array[$i];
}

print $total, "\n";
