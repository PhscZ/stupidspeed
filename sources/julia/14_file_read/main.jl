# task 14 file_read — expected output: 484442112
# build: julia main.jl    run: julia main.jl

function main()
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
    println(total % 4294967296)
end

main()
