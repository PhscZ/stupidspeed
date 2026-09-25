' task 04 array_sum -- expected output: 499999500000
' build: fbc -O 2 -x prog.exe 04_array_sum.bas    run: ./prog
' `shared` puts the array in static storage: a plain `dim` of 8 MB would overflow
' the default 1 MB thread stack and the process would die with no output.
dim shared arr(0 to 999999) as longint
dim i as longint
dim total as longint = 0

for i = 0 to 999999
    arr(i) = i
next

for i = 0 to 999999
    total += arr(i)
next

print str(total)
