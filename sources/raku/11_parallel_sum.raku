# task 11 parallel_sum — expected output: 7500000075000000
# build: none (interpreted)
# run: raku 11_parallel_sum.raku
# note: Raku is genuinely imperative -- mutable variables, `for`/`while`/`loop`, and
#       indexable arrays -- so these are the same scalar loops every other row uses, not
#       a functional transcription. map/grep/reduce/hyper operators are deliberately not
#       used in any timed path.
# note: integer arithmetic is arbitrary-precision by default; `int`/`num` native types are
#       used only where the value is known to fit, since native ops are much faster.
# note: four real OS threads. `start` schedules a block on MoarVM's ThreadPoolScheduler, which
#       runs each thread through uv_thread_create -- a genuine OS thread, with no GIL -- and
#       `await` is the join. Each worker owns a fixed quarter, so the answer cannot depend on
#       which finishes first.

my $__t0 = now;
sub work(int $t --> Int) {
    my Int $acc = 0;
    my int $start = $t * 25000000;
    my int $end   = ($t + 1) * 25000000;
    loop (my int $i = $start; $i < $end; $i++) {
        given $i % 4 {
            when 0  { $acc += 1 }
            when 1  { $acc += $i }
            when 2  { $acc += 2 * $i }
            default { $acc += 3 * $i }
        }
    }
    return $acc;
}

my @promises;
for ^4 -> int $t {
    @promises.push: start { work($t) };
}

my Int $total = 0;
for @promises -> $p {
    $total += await $p;
}
my $__t1 = now;
$*ERR.say('TIME_MS=' ~ (($__t1 - $__t0) * 1000).Num.fmt('%.3f'));
say $total;
