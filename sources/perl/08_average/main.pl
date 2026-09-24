# task 08 average — expected output: 0.498046875
# build: perl main.pl    run: perl main.pl
# note: every reading is a multiple of 1/256 and the total stays under 2^53, so the double sum is
#       exact and the quotient prints as 0.498046875 with Perl's default formatting (no exponent,
#       no trailing zeros, no locale commas).
use strict;
use warnings;

my $total = 0.0;

for (my $i = 0; $i < 100000000; $i++) {
    my $reading = ($i % 256) / 256.0;
    $total += $reading;
}

print $total / 100000000, "\n";
