# task 14 file_read — expected output: 2389704704
# build: julia 14_file_read.jl    run: julia 14_file_read.jl

using Printf

function main()
    t0 = time_ns()
    total = Int64(0)
    open("data.bin", "r") do f
        while true
            chunk = read(f, 1048576)
            isempty(chunk) && break
            s = Int64(0)
            for b in chunk
                s += b
            end
            total += s
        end
    end
    @printf(stderr, "TIME_MS=%.3f\n", (time_ns() - t0) / 1e6)
    println(total % 4294967296)
end

main()
