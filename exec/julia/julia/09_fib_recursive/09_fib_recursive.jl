# task 09 fib_recursive — expected output: 102334155
# build: julia 09_fib_recursive.jl    run: julia 09_fib_recursive.jl

using Printf

function fib(n::Int64)::Int64
    if n < 2
        return n
    end
    return fib(n - 1) + fib(n - 2)
end

function main()
    t0 = time_ns()
    v = fib(Int64(40))
    @printf(stderr, "TIME_MS=%.3f\n", (time_ns() - t0) / 1e6)
    println(v)
end

main()
