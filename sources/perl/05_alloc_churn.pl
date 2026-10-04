# task 05 alloc_churn — expected output: 1274991808
# build: perl 05_alloc_churn.pl    run: perl 05_alloc_churn.pl
# note: a Perl scalar is a mutable byte string, so every iteration allocates a fresh 64-byte string;
#       the slots write keeps the buffer reachable and drops the buffer it replaces.
use strict;
use warnings;

use Time::HiRes ();
my $__t0 = Time::HiRes::time();
my $total = 0;
my @slots;
$#slots = 255;

for (my $i = 0; $i < 10000000; $i++) {
    my $buf = "\0" x 64;
    substr($buf, 0, 1) = chr($i & 255);
    $total += ord($buf);
    $slots[$i & 255] = $buf;
}

my $__t1 = Time::HiRes::time();
printf STDERR "TIME_MS=%.3f\n", ($__t1 - $__t0) * 1000.0;
print $total, "\n";
