# task 01 branches — expected output: 33333334 13333333 7619048 45714285
# build: perl main.pl    run: perl main.pl
use strict;
use warnings;

my ($a, $b, $c, $d) = (0, 0, 0, 0);

for (my $i = 0; $i < 100000000; $i++) {
    if ($i % 3 == 0) {
        $a++;
    } elsif ($i % 5 == 0) {
        $b++;
    } elsif ($i % 7 == 0) {
        $c++;
    } else {
        $d++;
    }
}

print "$a $b $c $d\n";
