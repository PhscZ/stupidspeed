' task 03 func_sum -- expected output: 100000000
' build: fbc -O 2 -x 03_func_sum_add_one.bas    run: ./03_func_sum_add_one.exe
function add_one(byval n as longint) as longint
    return n + 1
end function
