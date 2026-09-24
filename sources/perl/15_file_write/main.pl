# task 15 file_write — expected output: 104857600
# build: perl main.pl    run: perl main.pl
# note: the 1 MiB buffer is the bytes 0..255 repeated 4096 times. It is written to out.bin 100 times
#       with syswrite, which goes straight to the kernel with no user-space buffering, so nothing
#       has to be flushed or fsynced afterwards; the bytes actually written are counted and printed.
use strict;
use warnings;

my $pattern = pack('C*', 0 .. 255);
my $buf = $pattern x 4096;
my $written = 0;

open(my $out, '>:raw', 'out.bin') or die "cannot open out.bin: $!";
for (my $i = 0; $i < 100; $i++) {
    $written += syswrite($out, $buf);
}
close($out);

print $written, "\n";
