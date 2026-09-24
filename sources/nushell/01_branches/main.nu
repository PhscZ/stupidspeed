# task 01 branches — expected output: 33333334 13333333 7619048 45714285
# build: none (interpreted)    run: nu main.nu
#
# Four counters and one if/else chain. Nushell's int is i64, so the counters are exact.

mut a = 0
mut b = 0
mut c = 0
mut d = 0

for i in 0..99999999 {
    if ($i mod 3) == 0 {
        $a = $a + 1
    } else if ($i mod 5) == 0 {
        $b = $b + 1
    } else if ($i mod 7) == 0 {
        $c = $c + 1
    } else {
        $d = $d + 1
    }
}

print $"($a) ($b) ($c) ($d)"
