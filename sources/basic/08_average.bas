' task 08 average -- expected output: 0.498046875
' build: fbc -O 2 -x prog.exe 08_average.bas    run: ./prog
dim total as double = 0.0
dim reading as double
dim i as longint

for i = 0 to 99999999
    reading = (i mod 256) / 256.0
    total += reading
next

print str(total / 100000000)
