# task 12 matrix_add — expected output: 999000000
# build: none (elixir compiles the script on every run)
# run: elixir 12_matrix_add.exs
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
# Three flat 1000x1000 :atomics arrays, row-major, filled and added with plain index
# arithmetic. The total fits comfortably in a 64-bit integer.
defmodule T12 do
  def run do
    n = 1000
    e = n * n
    a = :atomics.new(e, signed: true)
    b = :atomics.new(e, signed: true)
    c = :atomics.new(e, signed: true)
    fill(a, b, 0, n)
    add(a, b, c, 0, e)
    IO.puts(sum(c, 0, e))
  end

  defp fill(_a, _b, i, n) when i >= n, do: :ok
  defp fill(a, b, i, n) do
    inner(a, b, i, 0, n)
    fill(a, b, i + 1, n)
  end

  defp inner(_a, _b, _i, j, n) when j >= n, do: :ok
  defp inner(a, b, i, j, n) do
    idx = i * n + j
    :atomics.put(a, idx + 1, i + j)
    :atomics.put(b, idx + 1, i - j)
    inner(a, b, i, j + 1, n)
  end

  defp add(_a, _b, _c, k, e) when k >= e, do: :ok
  defp add(a, b, c, k, e) do
    :atomics.put(c, k + 1, :atomics.get(a, k + 1) + :atomics.get(b, k + 1))
    add(a, b, c, k + 1, e)
  end

  defp sum(_c, k, e) when k >= e, do: 0
  defp sum(c, k, e), do: :atomics.get(c, k + 1) + sum(c, k + 1, e)
end

T12.run()
