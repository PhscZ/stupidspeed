# task 15 file_write — expected output: 52428800
# build: perl 15_file_write.pl    run: perl 15_file_write.pl
# note: the 1 MiB buffer is the bytes 0..255 repeated 4096 times. It is written to out.bin 50 times
#       with syswrite, which goes straight to the kernel with no user-space buffering, so nothing
#       has to be flushed or fsynced afterwards; the bytes actually written are counted and printed.
use strict;
use warnings;

my $pattern = pack('C*', 0 .. 255);
my $buf = $pattern x 4096;
my $written = 0;

open(my $out, '>:raw', 'out.bin') or die "cannot open out.bin: $!";
for (my $i = 0; $i < 50; $i++) {
    $written += syswrite($out, $buf);
}
close($out);

print $written, "\n";
