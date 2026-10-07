# task 08 average — expected output: 0.498046875
# build: none (elixir compiles the script on every run)
# run: elixir 08_average.exs
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
# A hundred million readings, each a multiple of 1/256, accumulated as a float. The total is
# far below 2^53, so the sum is exact and the digits do not depend on the order of addition.
defmodule T08 do
  def run do
    t0 = System.monotonic_time(:microsecond)
    total = acc(0, 100_000_000, 0.0)
    avg = total / 100_000_000
    IO.puts(:stderr, "TIME_MS=#{(System.monotonic_time(:microsecond) - t0) / 1000}")
    IO.puts(avg)
  end

  defp acc(i, n, total) when i >= n, do: total
  defp acc(i, n, total), do: acc(i + 1, n, total + rem(i, 256) / 256)
end

T08.run()
