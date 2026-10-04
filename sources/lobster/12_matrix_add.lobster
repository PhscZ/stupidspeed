// task 12 matrix_add — expected output: 999000000
// build: none (interpreted)    run: lobster 12_matrix_add.lobster

// timing: seconds_elapsed() is the VM's monotonic clock (QueryPerformanceCounter on Windows).
// Lobster has no stderr, so the contract's fallback applies: TIME_MS is written to time.txt.
let t_start = seconds_elapsed()

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

write_file("time.txt", "TIME_MS=" + string((seconds_elapsed() - t_start) * 1000.0) + "\n")
print total
