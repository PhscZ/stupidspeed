# task 04 array_sum — expected output: 499999500000
# build: perl 04_array_sum.pl    run: perl 04_array_sum.pl
use strict;
use warnings;

use Time::HiRes ();
my $__t0 = Time::HiRes::time();
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

my $__t1 = Time::HiRes::time();
printf STDERR "TIME_MS=%.3f\n", ($__t1 - $__t0) * 1000.0;
print $total, "\n";
