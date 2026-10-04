# task 10 pi — expected output: 4470
# build: none (interpreted)
# run: raku 10_pi.raku
# note: Raku is genuinely imperative -- mutable variables, `for`/`while`/`loop`, and
#       indexable arrays -- so these are the same scalar loops every other row uses, not
#       a functional transcription. map/grep/reduce/hyper operators are deliberately not
#       used in any timed path.
# note: integer arithmetic is arbitrary-precision by default; `int`/`num` native types are
#       used only where the value is known to fit, since native ops are much faster.
# note: Raku has arbitrary-precision integers built in, so this row does NOT hand-roll base-1e9
#       limbs. `div` is a real bignum division and `*`/`+` are exact at any size, which is the
#       fast route the Python, Ruby, Java and Common Lisp rows take.

# Gibbons' unbounded spigot over Raku's built-in exact integers. n stays a native int because it
# is always a single digit; q, r and t grow to a few hundred digits at 1000 and are plain Int.
my $__t0 = now;
my Int $q = 1; my Int $r = 0; my Int $t = 1;
my int $k = 1; my int $l = 3; my int $n = 3;
my int $sum = 0; my int $produced = 0;

while $produced < 1000 {
    my Int $u = 4 * $q + $r;
    my Int $v = ($n + 1) * $t;
    if $u < $v {
        # n is settled: emit it and advance
        $sum += $n;
        $produced++;
        my Int $u2 = 10 * (3 * $q + $r);
        my int $next = ($u2 div $t) - 10 * $n;
        $r = 10 * ($r - $n * $t);
        $q = 10 * $q;
        $n = $next;
    }
    else {
        # not settled: widen the state by one more term
        my Int $u3 = $q * (7 * $k + 2) + $r * $l;
        my int $next = $u3 div ($t * $l);
        $r = (2 * $q + $r) * $l;
        $q = $q * $k;
        $t = $t * $l;
        $k++;
        $l += 2;
        $n = $next;
    }
}
my $__t1 = now;
$*ERR.say('TIME_MS=' ~ (($__t1 - $__t0) * 1000).Num.fmt('%.3f'));
say $sum;
