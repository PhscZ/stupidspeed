// task 13 matrix_mul — expected output: 599995000
// build: none (interpreted)    run: lobster 13_matrix_mul.lobster

let n = 500
let elems = n * n

let A = []::int
let B = []::int
let C = []::int
vector_capacity(A, elems)
vector_capacity(B, elems)
vector_capacity(C, elems)
for(elems):
    push(A, 0)
    push(B, 0)
    push(C, 0)

for(n) i:
    for(n) j:
        let idx = i * n + j
        A[idx] = (i + j) % 7
        B[idx] = (i * j) % 5

// plain i, j, k triple loop, in that order
for(n) i:
    for(n) j:
        var sum = 0
        for(n) k:
            sum += A[i * n + k] * B[k * n + j]
        C[i * n + j] = sum

var total = 0
for(elems) k:
    total += C[k]

print total
