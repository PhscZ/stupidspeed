# task 04 array_sum — expected output: 499999500000
# build: julia main.jl    run: julia main.jl

function main()
    n = 1000000
    array = Vector{Int64}(undef, n)
    for i in 1:n
        array[i] = i - 1
    end

    total = Int64(0)
    for i in 1:n
        total += array[i]
    end
    println(total)
end

main()
