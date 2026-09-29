# task 13 matrix_mul — expected output: 599995000
# build: none (interpreted)    run: ring 13_matrix_mul.ring
# note: plain i, j, k triple loop, in that order, like the C row. The matrices are flat Ring
#       lists of n*n items indexed (i-1)*n + j, which is the C row's A[i*n+k] and B[k*n+j]
#       shape. A list of lists was measured and gives the same answer and the same cost
#       (42.6 s of user CPU against 40.6 s), because this cell is dominated by the 125
#       million inner iterations rather than by allocation; the flat form is used to match
#       task 12 and the C row.
# note: the cost of a flat index is one multiply and one add per element access, which the
#       C row pays too. It is not free here: Ring evaluates it in the interpreter.
# note: every value is a small whole number and the total 599995000 is exact in a double.

n = 500
m = n * n

a = list(m)
b = list(m)
c = list(m)

for i = 1 to n
    for j = 1 to n
        idx = (i - 1) * n + j
        a[idx] = ((i - 1) + (j - 1)) % 7
        b[idx] = ((i - 1) * (j - 1)) % 5
    next
next

for i = 1 to n
    for j = 1 to n
        s = 0
        for k = 1 to n
            s = s + a[(i - 1) * n + k] * b[(k - 1) * n + j]
        next
        c[(i - 1) * n + j] = s
    next
next

total = 0

for k = 1 to m
    total = total + c[k]
next

? total
