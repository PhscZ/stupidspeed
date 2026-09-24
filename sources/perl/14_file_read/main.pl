# task 14 file_read — expected output: 484442112
# build: perl main.pl    run: perl main.pl
# note: data.bin is a fixture of 104857600 bytes, the bytes 0..255 repeating, opened in the working
#       directory and read in 1 MiB chunks, never one byte per syscall.
use strict;
use warnings;

my $chunk_size = 1048576;
my $total = 0;

open(my $fh, '<:raw', 'data.bin') or die "cannot open data.bin: $!";
while (my $got = read($fh, my $buf, $chunk_size)) {
    $total += $_ for unpack('C*', substr($buf, 0, $got));
}
close($fh);

print $total % 4294967296, "\n";
