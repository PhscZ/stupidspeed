-- task 09 fib_recursive — expected output: 102334155
-- build: none (interpreted)    run: C:\stupidspeed\tools\luau\luau.exe 09_fib_recursive.luau
-- note: also runs unchanged on Lute, the Luau team's runtime: C:\stupidspeed\tools\lute\lute.exe run 09_fib_recursive.luau
-- Naive recursion, about 331 million calls. fib(40) is 102334155, exact in a double.

local function fib(n)
    if n < 2 then
        return n
    end
    return fib(n - 1) + fib(n - 2)
end

print(fib(40))
