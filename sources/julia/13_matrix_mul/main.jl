# task 13 matrix_mul — expected output: 599995000
# build: julia main.jl    run: julia main.jl

function main()
    n = 500
    a = Vector{Int64}(undef, n * n)
    b = Vector{Int64}(undef, n * n)
    c = Vector{Int64}(undef, n * n)

    for i in 0:(n - 1)
        for j in 0:(n - 1)
            idx = i * n + j + 1
            a[idx] = (i + j) % 7
            b[idx] = (i * j) % 5
        end
    end

    for i in 0:(n - 1)
        for j in 0:(n - 1)
            s = Int64(0)
            for k in 0:(n - 1)
                s += a[i * n + k + 1] * b[k * n + j + 1]
            end
            c[i * n + j + 1] = s
        end
    end

    total = Int64(0)
    for idx in 1:(n * n)
        total += c[idx]
    end
    println(total)
end

main()
