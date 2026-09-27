# task 07 string_append — expected output: 1000000
# build: none (elixir compiles the script on every run)
# run: elixir 07_string_append.exs
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
# Plain binary append a million times. NOTE: BEAM's writable-binary optimisation turns the
# natural <<acc::binary, "x">> into an amortised O(1) in-place extend, so this runs LINEAR here
# rather than the quadratic copy task 07 is designed to measure. That is the runtime's real
# behaviour for this operation and is recorded rather than worked around; forcing a copy would
# mean writing the row artificially.
defmodule T07 do
  def run do
    acc = append(1_000_000, <<>>)
    IO.puts(byte_size(acc))
  end

  defp append(0, acc), do: acc
  defp append(n, acc), do: append(n - 1, <<acc::binary, "x">>)
end

T07.run()
