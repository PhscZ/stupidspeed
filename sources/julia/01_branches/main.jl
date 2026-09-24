# task 01 branches — expected output: 33333334 13333333 7619048 45714285
# build: julia main.jl    run: julia main.jl

function main()
    a = Int64(0)
    b = Int64(0)
    c = Int64(0)
    d = Int64(0)
    for i in Int64(0):Int64(99999999)
        if i % 3 == 0
            a += 1
        elseif i % 5 == 0
            b += 1
        elseif i % 7 == 0
            c += 1
        else
            d += 1
        end
    end
    println(a, " ", b, " ", c, " ", d)
end

main()
