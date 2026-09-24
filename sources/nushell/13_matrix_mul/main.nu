# task 13 matrix_mul — expected output: 599995000
# build: none (interpreted)    run: nu main.nu
#
# A, B and C are flat lists of n*n elements addressed as i*n+j. A[i][j] = (i+j) mod 7,
# B[i][j] = (i*j) mod 5, and C is filled by the plain i,j,k triple loop in that order —
# no loop reordering, no library multiply.

let n = 500
let cells = ($n * $n)

let a = (0..($cells - 1) | each {|k| ((($k // $n) + ($k mod $n)) mod 7) })
let b = (0..($cells - 1) | each {|k| ((($k // $n) * ($k mod $n)) mod 5) })

let c = (0..($cells - 1) | each {|idx|
    let i = ($idx // $n)
    let j = ($idx mod $n)
    mut sum = 0
    for k in 0..($n - 1) {
        $sum = $sum + ($a | get ($i * $n + $k)) * ($b | get ($k * $n + $j))
    }
    $sum
})

print ($c | math sum)
