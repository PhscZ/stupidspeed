# task 14 file_read — expected output: 2389704704
# build: none (interpreted)
# run: raku 14_file_read.raku
# note: Raku is genuinely imperative -- mutable variables, `for`/`while`/`loop`, and
#       indexable arrays -- so these are the same scalar loops every other row uses, not
#       a functional transcription. map/grep/reduce/hyper operators are deliberately not
#       used in any timed path.
# note: integer arithmetic is arbitrary-precision by default; `int`/`num` native types are
#       used only where the value is known to fit, since native ops are much faster.
# note: data.bin is read from the working directory in 1 MiB chunks and every byte is added up;
#       the running total is reduced mod 2^32 after each chunk so it stays inside the 2^53 range
#       where a native num is exact. Buf elements are already 0..255, so no sign masking is needed.

my $__t0 = now;
my $fh = open 'data.bin', :bin, :r;

my Int $total = 0;
loop {
    my $chunk = $fh.read(1048576);
    last unless $chunk.elems;
    my int $n = $chunk.elems;
    loop (my int $i = 0; $i < $n; $i++) {
        $total += $chunk[$i];
    }
    $total %= 4294967296;
}
$fh.close;

my $__t1 = now;
$*ERR.say('TIME_MS=' ~ (($__t1 - $__t0) * 1000).Num.fmt('%.3f'));
say $total;
