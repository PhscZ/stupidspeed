# task 04 array_sum — expected output: 499999500000
# build: none (interpreted)    run: nu main.nu
#
# A list of 1000000 integers, filled so that array[i] = i, then read back in a second
# loop. The fill is one map over the index range, which is how nu fills an array.

let n = 1000000

let array = (0..($n - 1) | each {|i| $i })

mut total = 0

for i in 0..($n - 1) {
    $total = $total + ($array | get $i)
}

print $total
