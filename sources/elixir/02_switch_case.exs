# task 02 switch_case — expected output: 7500000075000000
# build: none (elixir compiles the script on every run)
# run: elixir 02_switch_case.exs
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
# 7500000075000000 is past 2^31 but far inside Elixir's arbitrary-precision integers, which
# promote automatically, so no type declaration is needed.
defmodule T02 do
  def run do
    t0 = System.monotonic_time(:microsecond)
    loop(0, 0, t0)
  end

  defp loop(i, acc, t0) when i >= 100_000_000 do
    result = acc
    IO.puts(:stderr, "TIME_MS=#{(System.monotonic_time(:microsecond) - t0) / 1000}")
    IO.puts(result)
  end

  defp loop(i, acc, t0) do
    v = case rem(i, 4) do
          0 -> 1
          1 -> i
          2 -> 2 * i
          _ -> 3 * i
        end
    loop(i + 1, acc + v, t0)
  end
end

T02.run()
