' task 03 func_sum -- expected output: 100000000
' build: compiled with 03_func_sum.bas: fbc -O 2 -x prog.exe 03_func_sum.bas 03_func_sum_add_one.bas
function add_one(byval n as longint) as longint
    return n + 1
end function
