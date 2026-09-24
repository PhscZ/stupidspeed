# task 07 string_append — expected output: 1000000
# build: julia main.jl    run: julia main.jl

function main()
    text = ""
    for _ in 1:1000000
        text = text * "x"
    end
    println(length(text))
end

main()
