# task 01 branches — expected output: 33333334 13333333 7619048 45714285
# build: none (elixir compiles the script on every run)
# run: elixir 01_branches.exs
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
defmodule T01 do
  def run do
    t0 = System.monotonic_time(:microsecond)
    loop(0, 0, 0, 0, 0, t0)
  end

  defp loop(i, a, b, c, d, t0) when i >= 100_000_000 do
    result = "#{a} #{b} #{c} #{d}"
    IO.puts(:stderr, "TIME_MS=#{(System.monotonic_time(:microsecond) - t0) / 1000}")
    IO.puts(result)
  end

  defp loop(i, a, b, c, d, t0) do
    cond do
      rem(i, 3) == 0 -> loop(i + 1, a + 1, b, c, d, t0)
      rem(i, 5) == 0 -> loop(i + 1, a, b + 1, c, d, t0)
      rem(i, 7) == 0 -> loop(i + 1, a, b, c + 1, d, t0)
      true           -> loop(i + 1, a, b, c, d + 1, t0)
    end
  end
end

T01.run()
