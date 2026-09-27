# task 15 file_write — expected output: 94371840
# build: none (interpreted)
# run: raku 15_file_write.raku
# note: Raku is genuinely imperative -- mutable variables, `for`/`while`/`loop`, and
#       indexable arrays -- so these are the same scalar loops every other row uses, not
#       a functional transcription. map/grep/reduce/hyper operators are deliberately not
#       used in any timed path.
# note: integer arithmetic is arbitrary-precision by default; `int`/`num` native types are
#       used only where the value is known to fit, since native ops are much faster.
# note: the 1 MiB buffer is written 90 times, then flushed and closed. Raku exposes no fsync on
#       an IO::Handle, so the deviation is flush plus close -- the same one the Tcl, D, Julia, Nim,
#       Dart, Pascal, COBOL, Dolphin and Common Lisp rows note.

# `flat` is load-bearing: (0..255) xx 4096 is a list of 4096 Ranges, not a flat run of integers,
# and Buf.new rejects a Range element.
my $buf = Buf.new( flat (0..255) xx 4096 );

my $fh = open 'out.bin', :bin, :w;
loop (my int $i = 0; $i < 90; $i++) {
    $fh.write($buf);
}
$fh.flush;
$fh.close;

say 90 * 1048576;
