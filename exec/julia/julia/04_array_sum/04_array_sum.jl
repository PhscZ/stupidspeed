# task 04 array_sum — expected output: 599999940000000
# build: julia 04_array_sum.jl    run: julia 04_array_sum.jl

using Printf

function main()
    t0 = time_ns()
    n = 10000000
    array = Vector{Int64}(undef, n)
    for i in 1:n
        array[i] = i - 1
    end

    total = Int64(0)
    for _pass in 1:12
        for i in 1:n
            total += array[i]
        end
    end
    @printf(stderr, "TIME_MS=%.3f\n", (time_ns() - t0) / 1e6)
    println(total)
end

main()
