# task 02 switch_case — expected output: 7500000075000000
# build: perl 02_switch_case.pl    run: perl 02_switch_case.pl
# note: Perl has no switch statement. given/when (smartmatch) is deprecated and has been removed
#       from recent releases, so the four cases are an if/elsif chain on $i % 4, the closest thing
#       to a switch the language has. A dispatch table of code references would add one function
#       call per iteration and measure task 03 instead.
use strict;
use warnings;

my $acc = 0;

for (my $i = 0; $i < 100000000; $i++) {
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

print $acc, "\n";
