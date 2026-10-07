# task 04 array_sum — expected output: 499999500000
# build: none (interpreted)
# run: raku 04_array_sum.raku
# note: Raku is genuinely imperative -- mutable variables, `for`/`while`/`loop`, and
#       indexable arrays -- so these are the same scalar loops every other row uses, not
#       a functional transcription. map/grep/reduce/hyper operators are deliberately not
#       used in any timed path.
# note: integer arithmetic is arbitrary-precision by default; `int`/`num` native types are
#       used only where the value is known to fit, since native ops are much faster.
# A million-element int array, filled in one loop and summed in another, so the fill is not
# part of the read loop. 499999500000 is past 2^31, so the sum is a plain (big) Int.
my $__t0 = now;
my int @arr;
@arr[$_] = $_ for ^1000000;
my Int $total = 0;
loop (my int $i = 0; $i < 1000000; $i++) {
    $total += @arr[$i];
}
my $__t1 = now;
$*ERR.say('TIME_MS=' ~ (($__t1 - $__t0) * 1000).Num.fmt('%.3f'));
say $total;
