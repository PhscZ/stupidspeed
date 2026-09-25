' task 09 fib_recursive -- expected output: 102334155
' build: fbc -O 2 -x prog.exe 09_fib_recursive.bas    run: ./prog
function fib(byval n as longint) as longint
    if n < 2 then return n
    return fib(n - 1) + fib(n - 2)
end function

print str(fib(40))
