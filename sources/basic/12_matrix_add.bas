' task 12 matrix_add -- expected output: 999000000
' build: fbc -O 2 -x prog.exe 12_matrix_add.bas    run: ./prog
const N as integer = 1000

' `shared` puts the 8 MB arrays in static storage; plain `dim` overflows the stack.
dim shared a(0 to N - 1, 0 to N - 1) as longint
dim shared b(0 to N - 1, 0 to N - 1) as longint
dim shared c(0 to N - 1, 0 to N - 1) as longint
dim i as integer
dim j as integer
dim total as longint = 0

for i = 0 to N - 1
    for j = 0 to N - 1
        a(i, j) = i + j
        b(i, j) = i - j
    next
next

for i = 0 to N - 1
    for j = 0 to N - 1
        c(i, j) = a(i, j) + b(i, j)
    next
next

for i = 0 to N - 1
    for j = 0 to N - 1
        total += c(i, j)
    next
next

print str(total)
