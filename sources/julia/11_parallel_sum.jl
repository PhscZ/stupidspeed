# task 11 parallel_sum — expected output: 7500000075000000
# build: julia -t4 11_parallel_sum.jl    run: julia -t4 11_parallel_sum.jl
# deviation: Julia has no switch/match statement, so worker t uses the same if/elseif
# chain as task 02. Each thread owns one range and writes its own slot of `results`.

function partial(t::Int64)::Int64
    acc = Int64(0)
    lo = t * 25000000
    hi = lo + 25000000 - 1
    for i in lo:hi
        m = i % 4
        if m == 0
            acc += 1
        elseif m == 1
            acc += i
        elseif m == 2
            acc += 2 * i
        else
            acc += 3 * i
        end
    end
    return acc
end

function main()
    results = Vector{Int64}(undef, 4)
    Threads.@threads for t in 0:3
        results[t + 1] = partial(Int64(t))
    end
    println(sum(results))
end

main()
