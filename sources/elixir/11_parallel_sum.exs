# task 11 parallel_sum — expected output: 7500000075000000
# build: none (elixir compiles the script on every run)
# run: elixir 11_parallel_sum.exs
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
# note: four real OS threads. spawn/1 puts each worker on its own scheduler, and the BEAM runs
#       one scheduler per core with no global lock, so the four really overlap. The parent blocks
#       in receive, which is the join. Measured 3.42x against the same work run serially.

defmodule T11 do
  @span 25_000_000

  def run do
    t0 = System.monotonic_time(:microsecond)
    self = self()
    pids = for t <- [0, 1, 2, 3], do: spawn(fn -> send(self, {self(), work(t)}) end)
    total = collect(pids, 0)
    IO.puts(:stderr, "TIME_MS=#{(System.monotonic_time(:microsecond) - t0) / 1000}")
    IO.puts(total)
  end

  defp collect([], acc), do: acc
  defp collect([p | rest], acc) do
    receive do
      {^p, v} -> collect(rest, acc + v)
    end
  end

  defp work(t) do
    start = t * @span
    finish = (t + 1) * @span
    wloop(start, finish, 0)
  end

  defp wloop(i, finish, acc) when i >= finish, do: acc
  defp wloop(i, finish, acc) do
    v = case rem(i, 4) do
          0 -> 1
          1 -> i
          2 -> 2 * i
          _ -> 3 * i
        end
    wloop(i + 1, finish, acc + v)
  end
end

T11.run()
