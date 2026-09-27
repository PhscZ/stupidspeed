# task 13 matrix_mul — expected output: 599995000
# build: none (elixir compiles the script on every run)
# run: elixir 13_matrix_mul.exs
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
# The plain i, j, k triple loop in that order on flat row-major arrays, so the k loop walks a
# column of b. Reordering would be faster, which is the point.
defmodule T13 do
  def run do
    n = 500
    e = n * n
    a = :atomics.new(e, signed: true)
    b = :atomics.new(e, signed: true)
    c = :atomics.new(e, signed: true)
    fill(a, b, 0, n)
    mul(a, b, c, 0, n)
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
    :atomics.put(a, idx + 1, rem(i + j, 7))
    :atomics.put(b, idx + 1, rem(i * j, 5))
    inner(a, b, i, j + 1, n)
  end

  defp mul(_a, _b, _c, r, n) when r >= n, do: :ok
  defp mul(a, b, c, r, n) do
    row(a, b, c, r, 0, n)
    mul(a, b, c, r + 1, n)
  end

  defp row(_a, _b, _c, _r, col, n) when col >= n, do: :ok
  defp row(a, b, c, r, col, n) do
    :atomics.put(c, r * n + col + 1, dot(a, b, r, col, 0, n, 0))
    row(a, b, c, r, col + 1, n)
  end

  defp dot(_a, _b, _r, _col, k, n, acc) when k >= n, do: acc
  defp dot(a, b, r, col, k, n, acc) do
    dot(a, b, r, col, k + 1, n,
        acc + :atomics.get(a, r * n + k + 1) * :atomics.get(b, k * n + col + 1))
  end

  defp sum(_c, k, e) when k >= e, do: 0
  defp sum(c, k, e), do: :atomics.get(c, k + 1) + sum(c, k + 1, e)
end

T13.run()
