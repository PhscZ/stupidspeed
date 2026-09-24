# task 14 file_read — expected output: 484442112
# build: none (interpreted)    run: nu main.nu
#
# data.bin is not in the repo; the program just opens it by name. nu reads it 1 MiB at a
# time with `chunks`, which is the closest nu has to chunked I/O. nu has no bulk "sum the
# bytes" command, so each chunk is split into single bytes with `chunks 1` and converted
# one at a time with `into int` — that per-byte pass is very slow, so expect the 300 s
# timeout. The accumulator is i64 and reaches 13369344000 before the mod.

mut total = 0

for chunk in (open --raw data.bin | chunks 1mib) {
    $total = $total + ($chunk | chunks 1 | each {|b| $b | into int } | math sum)
}

print ($total mod 4294967296)
