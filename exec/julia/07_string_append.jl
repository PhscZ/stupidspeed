# task 07 string_append — expected output: 250000
# build: julia 07_string_append.jl    run: julia 07_string_append.jl

using Printf

function main()
    t0 = time_ns()
    text = ""
    for _ in 1:250000
        text = text * "x"
    end
    @printf(stderr, "TIME_MS=%.3f\n", (time_ns() - t0) / 1e6)
    println(length(text))
end

main()
