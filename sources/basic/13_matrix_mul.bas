' task 13 matrix_mul -- expected output: 599995000
' build: fbc -O 2 -x prog.exe 13_matrix_mul.bas    run: ./prog
const N as integer = 500

' `shared` puts the 2 MB arrays in static storage; plain `dim` overflows the stack.
dim shared a(0 to N - 1, 0 to N - 1) as longint
dim shared b(0 to N - 1, 0 to N - 1) as longint
dim shared c(0 to N - 1, 0 to N - 1) as longint
dim i as integer
dim j as integer
dim k as integer
dim acc as longint
dim total as longint = 0

for i = 0 to N - 1
    for j = 0 to N - 1
        a(i, j) = (i + j) mod 7
        b(i, j) = (i * j) mod 5
    next
next

for i = 0 to N - 1
    for j = 0 to N - 1
        acc = 0
        for k = 0 to N - 1
            acc += a(i, k) * b(k, j)
        next
        c(i, j) = acc
    next
next

for i = 0 to N - 1
    for j = 0 to N - 1
        total += c(i, j)
    next
next

print str(total)
