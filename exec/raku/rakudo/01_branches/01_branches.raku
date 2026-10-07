# task 01 branches — expected output: 33333334 13333333 7619048 45714285
# build: none (interpreted)
# run: raku 01_branches.raku
# note: Raku is genuinely imperative -- mutable variables, `for`/`while`/`loop`, and
#       indexable arrays -- so these are the same scalar loops every other row uses, not
#       a functional transcription. map/grep/reduce/hyper operators are deliberately not
#       used in any timed path.
# note: integer arithmetic is arbitrary-precision by default; `int`/`num` native types are
#       used only where the value is known to fit, since native ops are much faster.
my $__t0 = now;
my int $a = 0;
my int $b = 0;
my int $c = 0;
my int $d = 0;
loop (my int $i = 0; $i < 100000000; $i++) {
    if $i % 3 == 0 { $a++ }
    elsif $i % 5 == 0 { $b++ }
    elsif $i % 7 == 0 { $c++ }
    else { $d++ }
}
my $__t1 = now;
$*ERR.say('TIME_MS=' ~ (($__t1 - $__t0) * 1000).Num.fmt('%.3f'));
say "$a $b $c $d";
