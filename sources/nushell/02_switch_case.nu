# task 02 switch_case — expected output: 7500000075000000
# build: none (interpreted)    run: nu 02_switch_case.nu
#
# The same four-way decision as task 01, written with nu's real `match` keyword instead
# of an if-chain. `match` arms are blocks, so they can update the surrounding mutable
# variable. acc is i64 and the total stays under 2^53, so the answer is exact.

mut acc = 0

for i in 0..99999999 {
    match ($i mod 4) {
        0 => { $acc = $acc + 1 },
        1 => { $acc = $acc + $i },
        2 => { $acc = $acc + 2 * $i },
        3 => { $acc = $acc + 3 * $i }
    }
}

print $acc
