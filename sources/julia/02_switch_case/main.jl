# task 02 switch_case — expected output: 7500000075000000
# build: julia main.jl    run: julia main.jl
# deviation: Julia has no switch/match statement, so the four-way branch is the closest
# idiomatic equivalent: an if/elseif chain on i % 4.

function main()
    acc = Int64(0)
    for i in Int64(0):Int64(99999999)
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
    println(acc)
end

main()
