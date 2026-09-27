# task 05 alloc_churn — expected output: 1274991808
# build: none (interpreted)
# run: raku 05_alloc_churn.raku
# note: Raku is genuinely imperative -- mutable variables, `for`/`while`/`loop`, and
#       indexable arrays -- so these are the same scalar loops every other row uses, not
#       a functional transcription. map/grep/reduce/hyper operators are deliberately not
#       used in any timed path.
# note: integer arithmetic is arbitrary-precision by default; `int`/`num` native types are
#       used only where the value is known to fit, since native ops are much faster.
# Ten million 64-byte buffers, each stored into one of 256 slots so the buffer it replaces
# becomes garbage -- the same reachability line the C and Java rows draw. The running total
# adds v, the value written.
my $slots = (Any xx 256).Array;
my int $total = 0;
loop (my int $i = 0; $i < 10000000; $i++) {
    my int $v = $i % 256;
    my $buf = Buf.new($v xx 64);
    $slots[$v] = $buf;
    $total += $v;
}
say $total;
