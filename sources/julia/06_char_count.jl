# task 06 char_count — expected output: 10000000
# build: julia 06_char_count.jl    run: julia 06_char_count.jl

using Printf

function main()
    t0 = time_ns()
    text = repeat("abcdefghij", 10000000)
    h = UInt8('h')
    count = Int64(0)
    n = ncodeunits(text)
    for i in 1:n
        if codeunit(text, i) == h
            count += 1
        end
    end
    @printf(stderr, "TIME_MS=%.3f\n", (time_ns() - t0) / 1e6)
    println(count)
end

main()
