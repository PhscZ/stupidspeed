# task 14 file_read — expected output: 1937768448
# build: none (elixir compiles the script on every run)
# run: elixir 14_file_read.exs
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
# note: data.bin is read from the working directory 8 times, in 1 MiB chunks, and every byte of
#       every pass is added up; the running total is reduced mod 2^32 after each chunk so it stays
#       inside the 2^53 range where a float is exact. Binaries are byte arrays, so each element is
#       already 0..255.

defmodule T14 do
  def run do
    t0 = System.monotonic_time(:microsecond)
    total = passes(8, 0)
    answer = rem(total, 4_294_967_296)
    IO.puts(:stderr, "TIME_MS=#{(System.monotonic_time(:microsecond) - t0) / 1000}")
    IO.puts(answer)
  end

  defp passes(0, acc), do: acc
  defp passes(n, acc) do
    {:ok, f} = File.open("data.bin", [:read, :binary, :raw])
    total = chunks(f, acc)
    File.close(f)
    passes(n - 1, total)
  end

  defp chunks(f, acc) do
    case :file.read(f, 1_048_576) do
      {:ok, bin} -> chunks(f, rem(acc + sum(bin, 0), 4_294_967_296))
      :eof -> acc
    end
  end

  defp sum(<<>>, acc), do: acc
  defp sum(<<b, rest::binary>>, acc), do: sum(rest, acc + b)
end

T14.run()
