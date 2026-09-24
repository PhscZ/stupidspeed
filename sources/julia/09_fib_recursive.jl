# task 09 fib_recursive — expected output: 102334155
# build: julia 09_fib_recursive.jl    run: julia 09_fib_recursive.jl

function fib(n::Int64)::Int64
    if n < 2
        return n
    end
    return fib(n - 1) + fib(n - 2)
end

function main()
    println(fib(Int64(40)))
end

main()
