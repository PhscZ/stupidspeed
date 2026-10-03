// task 12 matrix_add — expected output: 999000000
// build: none (interpreted)    run: lobster 12_matrix_add.lobster

let n = 1000
let elems = n * n

let A = []::int
let B = []::int
vector_capacity(A, elems)
vector_capacity(B, elems)
for(elems):
    push(A, 0)
    push(B, 0)

for(n) i:
    for(n) j:
        let idx = i * n + j
        A[idx] = i + j
        B[idx] = i - j

var total = 0
for(elems) k:
    total += A[k] + B[k]

print total
