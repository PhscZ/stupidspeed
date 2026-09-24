# task 11 parallel_sum — expected output: 7500000075000000
# build: perl 11_parallel_sum.pl    run: perl 11_parallel_sum.pl
# note: uses threads, so it needs a Perl built with ithreads (standard on Linux and on Strawberry
#       Perl). Each thread runs in its own interpreter, so the partial sums come back via join().
use strict;
use warnings;
use threads;

sub work {
    my ($t) = @_;

    my $acc = 0;
    my $start = $t * 25000000;
    my $limit = ($t + 1) * 25000000;

    for (my $i = $start; $i < $limit; $i++) {
        my $c = $i % 4;
        if ($c == 0) {
            $acc += 1;
        } elsif ($c == 1) {
            $acc += $i;
        } elsif ($c == 2) {
            $acc += 2 * $i;
        } else {
            $acc += 3 * $i;
        }
    }

    return $acc;
}

my @threads = map { threads->create(\&work, $_) } 0 .. 3;

my $total = 0;
$total += $_->join() for @threads;

print $total, "\n";
