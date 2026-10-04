# task 13 matrix_mul — expected output: 599995000
# build: none (interpreted)
# run: raku 13_matrix_mul.raku
# note: Raku is genuinely imperative -- mutable variables, `for`/`while`/`loop`, and
#       indexable arrays -- so these are the same scalar loops every other row uses, not
#       a functional transcription. map/grep/reduce/hyper operators are deliberately not
#       used in any timed path.
# note: integer arithmetic is arbitrary-precision by default; `int`/`num` native types are
#       used only where the value is known to fit, since native ops are much faster.
# The plain i, j, k triple loop in that order on flat row-major arrays, so the k loop walks a
# column of B. Reordering would be faster, which is the point.
my $__t0 = now;
my int $n = 500;
my int @a; my int @b; my int @c;
loop (my int $i = 0; $i < $n; $i++) {
    loop (my int $j = 0; $j < $n; $j++) {
        my int $idx = $i * $n + $j;
        @a[$idx] = ($i + $j) % 7;
        @b[$idx] = ($i * $j) % 5;
    }
}
loop (my int $r = 0; $r < $n; $r++) {
    loop (my int $col = 0; $col < $n; $col++) {
        my int $sum = 0;
        loop (my int $k = 0; $k < $n; $k++) {
            $sum += @a[$r * $n + $k] * @b[$k * $n + $col];
        }
        @c[$r * $n + $col] = $sum;
    }
}
my int $total = 0;
loop (my int $e = 0; $e < $n * $n; $e++) { $total += @c[$e] }
my $__t1 = now;
$*ERR.say('TIME_MS=' ~ (($__t1 - $__t0) * 1000).Num.fmt('%.3f'));
say $total;
