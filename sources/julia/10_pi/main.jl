# task 10 pi — expected output: 44889
# build: julia main.jl    run: julia main.jl

# Gibbons' unbounded spigot: each state transition emits one digit, starting with the
# leading 3 of pi. Sum the first 10000 emitted digits and print only the sum.
function pi_digit_sum(count::Int)
    q = big(1)
    r = big(0)
    t = big(1)
    k = big(1)
    n = big(3)
    l = big(3)

    total = Int64(0)
    emitted = 0
    while emitted < count
        if 4q + r - t < n * t
            total += Int64(n)
            emitted += 1
            (q, r, t, k, n, l) = (
                10q,
                10 * (r - n * t),
                t,
                k,
                (10 * (3q + r)) ÷ t - 10n,
                l,
            )
        else
            (q, r, t, k, n, l) = (
                q * k,
                (2q + r) * l,
                t * l,
                k + 1,
                (q * (7k + 2) + r * l) ÷ (t * l),
                l + 2,
            )
        end
    end
    return total
end

function main()
    println(pi_digit_sum(10000))
end

main()
