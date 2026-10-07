# task 15 file_write — expected output: 52428800
# build: perl 15_file_write.pl    run: perl 15_file_write.pl
# note: the 1 MiB buffer is the bytes 0..255 repeated 4096 times. It is written to out.bin 50 times
#       with syswrite, which goes straight to the kernel with no user-space buffering, so there is
#       nothing left to flush; IO::Handle::sync then fsyncs the descriptor, which is the commit the
#       task asks for. The bytes actually written are counted and printed.
use strict;
use warnings;
use IO::Handle;

use Time::HiRes ();
my $__t0 = Time::HiRes::time();
my $pattern = pack('C*', 0 .. 255);
my $buf = $pattern x 4096;
my $written = 0;

open(my $out, '>:raw', 'out.bin') or die "cannot open out.bin: $!";
for (my $i = 0; $i < 50; $i++) {
    $written += syswrite($out, $buf);
}
$out->sync;
close($out);

my $__t1 = Time::HiRes::time();
printf STDERR "TIME_MS=%.3f\n", ($__t1 - $__t0) * 1000.0;
print $written, "\n";
