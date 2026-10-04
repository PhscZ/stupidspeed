// task 15 file_write — expected output: 52428800
// build: gleam build    run: gleam run --module t15_file_write
// note: run from sources/gleam/, the project root; out.bin (50 MiB) is created there.
// note: Gleam module names may not begin with a digit, so the file is t15_file_write.gleam
//       and the module is t15_file_write. Every file in this row is named the same way.
// note: Gleam's standard library has no file API, so this goes through @external FFI to the
//       Erlang file module. file:open/2 returns {ok, IoDevice} | {error, Reason}, which is
//       the prelude's Result; file:write/2, file:datasync/1 and file:close/1 return the bare
//       atom `ok` on success, so those three are typed as atoms and asserted against the
//       `ok` atom, which panics if a write fails instead of silently reporting success.
// note: the 1 MiB buffer is built once as bytes 0..255 repeated 4096 times and written 50
//       times, then committed with file:datasync/1, which is the BEAM's fsync on the
//       descriptor, and closed. Buffered, one megabyte at a time.
// note: Gleam has no loop syntax and no mutable variables. Every loop in this row is tail
//       recursion with explicit accumulators, which the BEAM turns into a jump.

import gleam/bit_array
import gleam/erlang/atom
import gleam/float
import gleam/int
import gleam/io

type Fd

@external(erlang, "file", "open")
fn file_open(path: String, modes: List(atom.Atom)) -> Result(Fd, atom.Atom)

@external(erlang, "file", "write")
fn file_write(fd: Fd, data: BitArray) -> atom.Atom

@external(erlang, "file", "datasync")
fn file_datasync(fd: Fd) -> atom.Atom

@external(erlang, "file", "close")
fn file_close(fd: Fd) -> atom.Atom

@external(erlang, "binary", "copy")
fn binary_copy(subject: BitArray, times: Int) -> BitArray

@external(erlang, "erlang", "monotonic_time")
fn monotonic_time(unit: atom.Atom) -> Int

pub fn main() {
  let t0 = monotonic_time(atom.create("microsecond"))
  let buf = binary_copy(cycle(0, <<>>), 4096)
  let modes = [atom.create("write"), atom.create("raw"), atom.create("binary")]
  case file_open("out.bin", modes) {
    Ok(fd) -> {
      write(fd, buf, 50)
      check(file_datasync(fd))
      check(file_close(fd))
      let ms = int.to_float(monotonic_time(atom.create("microsecond")) - t0) /. 1000.0
      io.println_error("TIME_MS=" <> float.to_string(ms))
      io.println(int.to_string(50 * 1048576))
    }
    Error(_) -> panic as "cannot open out.bin"
  }
}

fn cycle(n: Int, acc: BitArray) -> BitArray {
  case n {
    256 -> acc
    _ -> cycle(n + 1, bit_array.append(acc, <<n:8>>))
  }
}

fn write(fd: Fd, buf: BitArray, n: Int) -> Nil {
  case n {
    0 -> Nil
    _ -> {
      check(file_write(fd, buf))
      write(fd, buf, n - 1)
    }
  }
}

fn check(result: atom.Atom) -> Nil {
  case result == atom.create("ok") {
    True -> Nil
    False -> panic as "file operation failed"
  }
}
