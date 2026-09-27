# task 03 func_sum — expected output: 100000000
# build: none (elixir compiles the script on every run)
# run: elixir 03_func_sum.exs
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
# The helper lives in its own module, so the call crosses a module boundary. BEAM does not
# inline across modules, so add_one/1 is a real call -- the same guarantee the Fortran, Tcl,
# Vala and Common Lisp rows get by splitting this task into two files.
defmodule AddOne do
  def add_one(n), do: n + 1
end

defmodule T03 do
  def run, do: loop(0, 0)

  defp loop(i, value) when i >= 100_000_000, do: IO.puts(value)

  defp loop(i, value), do: loop(i + 1, AddOne.add_one(value))
end

T03.run()
