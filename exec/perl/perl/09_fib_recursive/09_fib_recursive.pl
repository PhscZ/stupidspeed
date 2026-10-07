# task 09 fib_recursive — expected output: 102334155
# build: perl 09_fib_recursive.pl    run: perl 09_fib_recursive.pl
# note: naive double recursion, no memoization; fib(40) is about 331 million calls and perl is slow
#       enough that this takes a long time. That is a result, not a bug.
use strict;
use warnings;

use Time::HiRes ();
my $__t0 = Time::HiRes::time();
sub fib {
    my ($n) = @_;
    return $n if $n < 2;
    return fib($n - 1) + fib($n - 2);
}

my $__result = fib(40);
my $__t1 = Time::HiRes::time();
printf STDERR "TIME_MS=%.3f\n", ($__t1 - $__t0) * 1000.0;
print $__result, "\n";
