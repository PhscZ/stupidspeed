# task 03 func_sum — expected output: 100000000
# build: perl 03_func_sum.pl    run: perl 03_func_sum.pl
# note: the perl interpreter has no inliner and no JIT, so add_one is really called 100000000 times.
use strict;
use warnings;

sub add_one {
    return $_[0] + 1;
}

my $value = 0;
for (my $i = 0; $i < 100000000; $i++) {
    $value = add_one($value);
}

print $value, "\n";
