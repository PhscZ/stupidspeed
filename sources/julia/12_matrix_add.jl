# task 12 matrix_add — expected output: 999000000
# build: julia 12_matrix_add.jl    run: julia 12_matrix_add.jl

function main()
    n = 1000
    a = Vector{Int64}(undef, n * n)
    b = Vector{Int64}(undef, n * n)
    c = Vector{Int64}(undef, n * n)

    for i in 0:(n - 1)
        for j in 0:(n - 1)
            idx = i * n + j + 1
            a[idx] = i + j
            b[idx] = i - j
        end
    end

    for idx in 1:(n * n)
        c[idx] = a[idx] + b[idx]
    end

    total = Int64(0)
    for idx in 1:(n * n)
        total += c[idx]
    end
    println(total)
end

main()
