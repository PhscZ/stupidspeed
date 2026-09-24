# task 11 parallel_sum — expected output: 7500000075000000
# build: none (interpreted)    run: nu 11_parallel_sum.nu
#
# Four workers, each owning a fixed 25000000-wide range of task 02's work, run on a
# dedicated thread pool with `par-each --threads 4`. The partial sums are added up, so
# the order the workers finish in cannot change the answer. Every partial is i64 and the
# total stays under 2^53, so the number is exact.

def work [t: int] {
    mut acc = 0
    for i in ($t * 25000000)..(($t + 1) * 25000000 - 1) {
        match ($i mod 4) {
            0 => { $acc = $acc + 1 },
            1 => { $acc = $acc + $i },
            2 => { $acc = $acc + 2 * $i },
            3 => { $acc = $acc + 3 * $i }
        }
    }
    $acc
}

print (0..3 | par-each --threads 4 {|t| work $t } | math sum)
