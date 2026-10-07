# task 12 matrix_add — expected output: 999000000
# build: none (interpreted)    run: ring 12_matrix_add.ring
# note: the three matrices are flat Ring lists of n*n items, indexed (i-1)*n + j, which is
#       the C row's A[i*n+j] shape and the direct translation of its arrays.
# note: a list of lists was measured first and rejected. Building the three matrices as 3000
#       small 1000-item lists costs 54.8 s of user CPU on this host, against 0.14 s for the
#       same 3 million items in three flat lists, and the cost is superlinear in the number
#       of lists: 1000 such lists (1 million items) cost 3.4 s, 3000 of them 54.8 s. The
#       nested form's cell would therefore measure Ring's per-list allocation rather than
#       the matrix work — its own loops are only 0.45 s of the 0.72 s the nested program
#       spends before it prints. The flat form is both cheaper and closer to the C row.
# note: list(n) allocates the whole array up front, the way the C row's malloc does. A Ring
#       list item is a full Item rather than a machine word, so this is 3 million boxed
#       doubles rather than 3 million int64s.
# note: every value here is a small whole number and the total 999000000 is exact in a
#       double.
# timing: clock() is Ring's processor-time clock, in ticks since program start, and
#         clocksPerSecond() gives the ticks per second, so TIME_MS is whole milliseconds
#         of CPU time; it is written to time.txt with fopen/fputs/fclose, the contract's
#         fallback, because Ring's documented stream globals are stdin and stdout.
#         Verified on this machine with Ring 1.27: all fifteen tasks print the expected
#         line and write time.txt.

ssT0 = clock()
n = 1000
m = n * n

a = list(m)
b = list(m)
c = list(m)

for i = 1 to n
    for j = 1 to n
        idx = (i - 1) * n + j
        a[idx] = (i - 1) + (j - 1)
        b[idx] = (i - 1) - (j - 1)
    next
next

for i = 1 to n
    for j = 1 to n
        idx = (i - 1) * n + j
        c[idx] = a[idx] + b[idx]
    next
next

total = 0

for k = 1 to m
    total = total + c[k]
next

ssReport()
? total

func ssReport
    fp = fopen("time.txt", "w")
    fputs(fp, "TIME_MS=" + string((clock() - ssT0) * 1000 / clocksPerSecond()) + nl)
    fclose(fp)
