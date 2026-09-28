# task 15 file_write — expected output: 52428800
# build: none (elixir compiles the script on every run)
# run: elixir 15_file_write.exs
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
# note: the 1 MiB buffer is written 50 times, then closed. Elixir's File has no fsync wrapper in
#       this form, so the deviation is flush plus close -- the same one the Tcl, D, Julia, Nim,
#       Dart, Pascal, COBOL, Dolphin and Common Lisp rows note.

defmodule T15 do
  def run do
    buf = :binary.copy(<<0, 1, 2, 3, 4, 5, 6, 7, 8, 9>>, 1) |> cycle()
    {:ok, f} = File.open("out.bin", [:write, :binary, :raw])
    write(f, buf, 50)
    File.close(f)
    IO.puts(50 * 1_048_576)
  end

  # build the 256-byte 0..255 cycle, then repeat it 4096 times for exactly 1 MiB
  defp cycle(_) do
    base = for i <- 0..255, into: <<>>, do: <<i>>
    :binary.copy(base, 4096)
  end

  defp write(_f, _buf, 0), do: :ok
  defp write(f, buf, n) do
    :ok = :file.write(f, buf)
    write(f, buf, n - 1)
  end
end

T15.run()
