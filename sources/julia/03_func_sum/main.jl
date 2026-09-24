# task 03 func_sum — expected output: 100000000
# build: julia main.jl    run: julia main.jl

@noinline function add_one(n::Int64)::Int64
    return n + 1
end

function main()
    value = Int64(0)
    for _ in 1:100000000
        value = add_one(value)
    end
    println(value)
end

main()
