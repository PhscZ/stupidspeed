' task 03 func_sum -- expected output: 100000000
' build: fbc -O 2 -x 03_func_sum.bas    run: ./03_func_sum.exe
' task 03 - function call overhead, no-inline via separate module
' add_one lives in add_one.bas and is compiled separately so the call is real.
declare function add_one(byval n as longint) as longint

dim v as longint = 0
dim i as longint

for i = 0 to 99999999
    v = add_one(v)
next

print str(v)
