# task 05 alloc_churn — expected output: 1274991808
# build: perl main.pl    run: perl main.pl
# note: a Perl scalar is a mutable byte string, so every iteration allocates a fresh 64-byte string;
#       the slots write keeps the buffer reachable and drops the buffer it replaces.
use strict;
use warnings;

my $total = 0;
my @slots;
$#slots = 255;

for (my $i = 0; $i < 10000000; $i++) {
    my $buf = "\0" x 64;
    substr($buf, 0, 1) = chr($i & 255);
    $total += ord($buf);
    $slots[$i & 255] = $buf;
}

print $total, "\n";
