# task 09 fib_recursive — expected output: 102334155
# build: perl main.pl    run: perl main.pl
# note: naive double recursion, no memoization; fib(40) is about 1.6 billion calls and perl is slow
#       enough that this may hit the 300 s benchmark timeout. That is a result, not a bug.
use strict;
use warnings;

sub fib {
    my ($n) = @_;
    return $n if $n < 2;
    return fib($n - 1) + fib($n - 2);
}

print fib(40), "\n";
