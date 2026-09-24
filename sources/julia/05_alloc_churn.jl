# task 05 alloc_churn — expected output: 1274991808
# build: julia 05_alloc_churn.jl    run: julia 05_alloc_churn.jl

function main()
    total = Int64(0)
    slots = Vector{Vector{UInt8}}(undef, 256)
    for i in Int64(0):Int64(9999999)
        buf = Vector{UInt8}(undef, 64)
        buf[1] = UInt8(i % 256)
        total += Int64(buf[1])
        slots[Int(i % 256) + 1] = buf
    end
    println(total)
end

main()
