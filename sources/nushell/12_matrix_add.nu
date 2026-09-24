# task 12 matrix_add — expected output: 999000000
# build: none (interpreted)    run: nu 12_matrix_add.nu
#
# A, B and C are flat lists of n*n elements addressed as i*n+j, materialized as real
# arrays: A[i][j] = i+j, B[i][j] = i-j, C[i][j] = A[i][j] + B[i][j], then C is summed.

let n = 1000
let cells = ($n * $n)

let a = (0..($cells - 1) | each {|k| (($k // $n) + ($k mod $n)) })
let b = (0..($cells - 1) | each {|k| (($k // $n) - ($k mod $n)) })
let c = (0..($cells - 1) | each {|k| ($a | get $k) + ($b | get $k) })

print ($c | math sum)
