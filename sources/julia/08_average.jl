# task 08 average — expected output: 0.498046875
# build: julia 08_average.jl    run: julia 08_average.jl

function main()
    total = 0.0
    for i in Int64(0):Int64(99999999)
        reading = Float64(i % 256) / 256.0
        total += reading
    end
    println(total / 100000000)
end

main()
