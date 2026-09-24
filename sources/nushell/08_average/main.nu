# task 08 average — expected output: 0.498046875
# build: none (interpreted)    run: nu main.nu
#
# Every reading is a multiple of 1/256 and the total stays well under 2^53, so the sum
# is exact and the printed average is the exact decimal 0.498046875 (9 decimals, no
# exponent, no grouping).

mut total = 0.0

for i in 0..99999999 {
    let reading = (($i mod 256) | into float) / 256.0
    $total = $total + $reading
}

print (($total / 100000000) | into string --decimals 9)
