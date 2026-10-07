# task 09 fib_recursive — expected output: 102334155
# build: none (interpreted)
# run: raku 09_fib_recursive.raku
# note: Raku is genuinely imperative -- mutable variables, `for`/`while`/`loop`, and
#       indexable arrays -- so these are the same scalar loops every other row uses, not
#       a functional transcription. map/grep/reduce/hyper operators are deliberately not
#       used in any timed path.
# note: integer arithmetic is arbitrary-precision by default; `int`/`num` native types are
#       used only where the value is known to fit, since native ops are much faster.
# Naive fib(40): about 331 million calls, so this measures the call path itself rather than
# any arithmetic.
my $__t0 = now;
sub fib(int $n --> int) {
    return $n if $n < 2;
    return fib($n - 1) + fib($n - 2);
}
my $__result = fib(40);
my $__t1 = now;
$*ERR.say('TIME_MS=' ~ (($__t1 - $__t0) * 1000).Num.fmt('%.3f'));
say $__result;
