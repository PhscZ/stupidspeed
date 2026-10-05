# task 08 average — expected output: 0.498046875
# build: julia 08_average.jl    run: julia 08_average.jl

using Printf

function main()
    t0 = time_ns()
    total = 0.0
    for i in Int64(0):Int64(99999999)
        reading = Float64(i % 256) / 256.0
        total += reading
    end
    @printf(stderr, "TIME_MS=%.3f\n", (time_ns() - t0) / 1e6)
    println(total / 100000000)
end

main()
