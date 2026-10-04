# task 06 char_count — expected output: 10000000
# build: none (elixir compiles the script on every run)
# run: elixir 06_char_count.exs
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
# The 100 MB text is built once with :binary.copy, which allocates it in a single pass rather
# than a hundred million appends, and then scanned one byte at a time with :binary.at, which
# is O(1).
defmodule T06 do
  def run do
    t0 = System.monotonic_time(:microsecond)
    text = :binary.copy("abcdefghij", 10_000_000)
    count = scan(text, 0, 100_000_000, 0)
    IO.puts(:stderr, "TIME_MS=#{(System.monotonic_time(:microsecond) - t0) / 1000}")
    IO.puts(count)
  end

  defp scan(_text, i, n, count) when i >= n, do: count

  defp scan(text, i, n, count) do
    if :binary.at(text, i) == ?h do
      scan(text, i + 1, n, count + 1)
    else
      scan(text, i + 1, n, count)
    end
  end
end

T06.run()
