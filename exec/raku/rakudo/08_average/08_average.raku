# task 08 average — expected output: 0.498046875
# build: none (interpreted)
# run: raku 08_average.raku
# note: Raku is genuinely imperative -- mutable variables, `for`/`while`/`loop`, and
#       indexable arrays -- so these are the same scalar loops every other row uses, not
#       a functional transcription. map/grep/reduce/hyper operators are deliberately not
#       used in any timed path.
# note: integer arithmetic is arbitrary-precision by default; `int`/`num` native types are
#       used only where the value is known to fit, since native ops are much faster.
# A hundred million readings, each a multiple of 1/256, accumulated in a native double. The
# total is far below 2^53, so the sum is exact and the digits do not depend on the order of
# addition.
my $__t0 = now;
my num $total = 0e0;
loop (my int $i = 0; $i < 100000000; $i++) {
    $total += ($i % 256) / 256e0;
}
my $__t1 = now;
$*ERR.say('TIME_MS=' ~ (($__t1 - $__t0) * 1000).Num.fmt('%.3f'));
say $total / 100000000e0;
