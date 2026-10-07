# task 12 matrix_add — expected output: 999000000
# build: none (interpreted)
# run: raku 12_matrix_add.raku
# note: Raku is genuinely imperative -- mutable variables, `for`/`while`/`loop`, and
#       indexable arrays -- so these are the same scalar loops every other row uses, not
#       a functional transcription. map/grep/reduce/hyper operators are deliberately not
#       used in any timed path.
# note: integer arithmetic is arbitrary-precision by default; `int`/`num` native types are
#       used only where the value is known to fit, since native ops are much faster.
# Three flat 1000x1000 native int arrays, row-major, filled and added with plain index
# arithmetic. The total fits an int.
my $__t0 = now;
my int $n = 1000;
my int @a; my int @b; my int @c;
loop (my int $i = 0; $i < $n; $i++) {
    loop (my int $j = 0; $j < $n; $j++) {
        my int $idx = $i * $n + $j;
        @a[$idx] = $i + $j;
        @b[$idx] = $i - $j;
    }
}
loop (my int $p = 0; $p < $n; $p++) {
    loop (my int $q = 0; $q < $n; $q++) {
        my int $idx = $p * $n + $q;
        @c[$idx] = @a[$idx] + @b[$idx];
    }
}
my int $total = 0;
loop (my int $k = 0; $k < $n * $n; $k++) { $total += @c[$k] }
my $__t1 = now;
$*ERR.say('TIME_MS=' ~ (($__t1 - $__t0) * 1000).Num.fmt('%.3f'));
say $total;
