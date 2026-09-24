# task 15 file_write — expected output: 104857600
# build: julia main.jl    run: julia main.jl
# deviation: Julia's standard library exposes no fsync, so the file is flushed and closed.

function main()
    buf = Vector{UInt8}(undef, 1048576)
    for i in 1:1048576
        buf[i] = UInt8((i - 1) % 256)
    end

    written = Int64(0)
    open("out.bin", "w") do f
        for _ in 1:100
            written += write(f, buf)
        end
        flush(f)
    end
    println(written)
end

main()
