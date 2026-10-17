# task 14 file_read — expected output: 1937768448
# build: julia 14_file_read.jl    run: julia 14_file_read.jl
# note: data.bin is opened and read 8 times over, each pass starting at the beginning of the
#       file, and the total accumulates across all 8 passes.

using Printf

function main()
    t0 = time_ns()
    total = Int64(0)
    for _pass in 1:8
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
    end
    @printf(stderr, "TIME_MS=%.3f\n", (time_ns() - t0) / 1e6)
    println(total % 4294967296)
end

main()
