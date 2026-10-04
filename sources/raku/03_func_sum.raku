# task 03 func_sum — expected output: 100000000
# build: none (interpreted)
# run: raku 03_func_sum.raku
# note: Raku is genuinely imperative -- mutable variables, `for`/`while`/`loop`, and
#       indexable arrays -- so these are the same scalar loops every other row uses, not
#       a functional transcription. map/grep/reduce/hyper operators are deliberately not
#       used in any timed path.
# note: integer arithmetic is arbitrary-precision by default; `int`/`num` native types are
#       used only where the value is known to fit, since native ops are much faster.
# The helper lives in its own file, the same two-file shape the Fortran, Tcl, Vala and Common
# Lisp rows use, so the call crosses a module boundary rather than sitting next to its caller.
# Raku has no no-inline trait, so this is the only lever available.
use lib '.';
use AddOne;

my $__t0 = now;
my int $value = 0;
loop (my int $i = 0; $i < 100000000; $i++) {
    $value = add-one($value);
}
my $__t1 = now;
$*ERR.say('TIME_MS=' ~ (($__t1 - $__t0) * 1000).Num.fmt('%.3f'));
say $value;
