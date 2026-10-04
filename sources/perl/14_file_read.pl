# task 14 file_read — expected output: 2389704704
# build: perl 14_file_read.pl    run: perl 14_file_read.pl
# note: data.bin is a fixture of 52428800 bytes, the bytes 0..255 repeating, opened in the working
#       directory and read in 1 MiB chunks, never one byte per syscall.
use strict;
use warnings;

use Time::HiRes ();
my $__t0 = Time::HiRes::time();
my $chunk_size = 1048576;
my $total = 0;

open(my $fh, '<:raw', 'data.bin') or die "cannot open data.bin: $!";
while (my $got = read($fh, my $buf, $chunk_size)) {
    $total += $_ for unpack('C*', substr($buf, 0, $got));
}
close($fh);

my $__t1 = Time::HiRes::time();
printf STDERR "TIME_MS=%.3f\n", ($__t1 - $__t0) * 1000.0;
print $total % 4294967296, "\n";
