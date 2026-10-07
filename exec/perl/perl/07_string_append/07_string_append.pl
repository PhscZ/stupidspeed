# task 07 string_append — expected output: 250000
# build: perl 07_string_append.pl    run: perl 07_string_append.pl
# note: plain string concatenation on a Perl string, which may copy the whole string on every
#       append; no growable-buffer substitute.
use strict;
use warnings;

use Time::HiRes ();
my $__t0 = Time::HiRes::time();
my $text = '';
for (my $i = 0; $i < 250000; $i++) {
    $text .= "x";
}

my $__t1 = Time::HiRes::time();
printf STDERR "TIME_MS=%.3f\n", ($__t1 - $__t0) * 1000.0;
print length($text), "\n";
