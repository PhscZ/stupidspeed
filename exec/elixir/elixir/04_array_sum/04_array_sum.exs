# task 04 array_sum — expected output: 499999500000
# build: none (elixir compiles the script on every run)
# run: elixir 04_array_sum.exs
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
# :atomics is a real fixed-size mutable array of 64-bit integers with O(1) get/put -- the
# closest thing the BEAM has to an array, and genuinely imperative. Filled in one pass and
# summed in another, so the fill is not part of the read loop.
defmodule T04 do
  def run do
    t0 = System.monotonic_time(:microsecond)
    n = 1_000_000
    arr = :atomics.new(n, signed: true)
    fill(arr, 0, n)
    total = sum(arr, 0, n)
    IO.puts(:stderr, "TIME_MS=#{(System.monotonic_time(:microsecond) - t0) / 1000}")
    IO.puts(total)
  end

  defp fill(_arr, i, n) when i >= n, do: :ok
  defp fill(arr, i, n) do
    :atomics.put(arr, i + 1, i)
    fill(arr, i + 1, n)
  end

  defp sum(_arr, i, n) when i >= n, do: 0
  defp sum(arr, i, n), do: :atomics.get(arr, i + 1) + sum(arr, i + 1, n)
end

T04.run()
