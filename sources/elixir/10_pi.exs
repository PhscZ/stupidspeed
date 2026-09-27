# task 10 pi — expected output: 9092
# build: none (elixir compiles the script on every run)
# run: elixir 10_pi.exs
# note: like Erlang, Elixir has no mutable variables and no loop syntax, so there is no
#       imperative register to write in. Every loop here is tail recursion with explicit
#       accumulators, which the BEAM turns into a jump, plus case/cond for the branches.
#       What is deliberately avoided is the functional style: no Enum.map, Enum.reduce,
#       comprehensions or higher-order functions in any timed path. This is the most
#       procedural register the language has; it cannot honestly be called imperative,
#       and the row does not claim to be.
# note: mutable state, where a task genuinely needs it, uses the language's own escape
#       hatches -- the process dictionary (Process.put/get) and the :atomics module,
#       which is a real fixed-size mutable array of 64-bit integers.
# note: Elixir has arbitrary-precision integers built in, so this row does NOT hand-roll
#       base-1e9 limbs. They promote automatically and div/rem are exact at any size, which is
#       the fast route the Python, Ruby, Java, Clojure and Common Lisp rows take.

# Gibbons' unbounded spigot over Elixir's built-in exact integers.
defmodule T10 do
  def run, do: loop(1, 0, 1, 1, 3, 3, 0, 0)

  defp loop(_q, _r, _t, _k, _l, _n, produced, sum) when produced >= 2000 do
    IO.puts(sum)
  end

  defp loop(q, r, t, k, l, n, produced, sum) do
    u = 4 * q + r
    v = (n + 1) * t

    if u < v do
      # n is settled: emit it and advance
      next = div(10 * (3 * q + r), t) - 10 * n
      loop(10 * q, 10 * (r - n * t), t, k, l, next, produced + 1, sum + n)
    else
      # not settled: widen the state by one more term
      next = div(q * (7 * k + 2) + r * l, t * l)
      loop(q * k, (2 * q + r) * l, t * l, k + 1, l + 2, next, produced, sum)
    end
  end
end

T10.run()
