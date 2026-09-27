# task 05 alloc_churn — expected output: 1274991808
# build: none (elixir compiles the script on every run)
# run: elixir 05_alloc_churn.exs
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
# Ten million 64-byte binaries, each stored into one of 256 slots so the buffer it replaces
# becomes garbage -- the same reachability line the C and Java rows draw. The slots are the
# process dictionary, which is the BEAM's mutable state. The total adds v, the value written.
defmodule T05 do
  def run, do: churn(0, 0)

  defp churn(i, total) when i >= 10_000_000, do: IO.puts(total)

  defp churn(i, total) do
    v = rem(i, 256)
    Process.put({:slot, v}, :binary.copy(<<v>>, 64))
    churn(i + 1, total + v)
  end
end

T05.run()
