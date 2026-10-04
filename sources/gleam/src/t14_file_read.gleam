// task 14 file_read — expected output: 2389704704
// build: gleam build    run: gleam run --module t14_file_read
// note: run from sources/gleam/, the project root, with data.bin (50 MiB) in it.
// note: Gleam module names may not begin with a digit, so the file is t14_file_read.gleam
//       and the module is t14_file_read. Every file in this row is named the same way.
// note: Gleam's standard library has no file API, so this goes through @external FFI to the
//       Erlang file module. file:read/2 returns `{ok, Data} | eof | {error, Reason}`, and
//       `eof` is a bare atom with no Gleam representation, so the return is modelled with a
//       local type whose constructors compile to exactly those atoms: Ok -> {ok, _},
//       Error -> {error, _}, Eof -> eof. That is how the prelude's own Result already
//       interoperates with Erlang, applied to the third case. The Eof branch of file_open
//       is unreachable and says so.
// note: data.bin is read in 1 MiB chunks and every byte is added up; the running total is
//       reduced mod 2^32 after each chunk, so it stays inside the small-integer range.
//       Binaries are byte arrays, so each element is already 0..255.
// note: Gleam has no loop syntax and no mutable variables. Every loop in this row is tail
//       recursion with explicit accumulators, which the BEAM turns into a jump. The
//       functional style is deliberately avoided: no list.map, no fold and no
//       higher-order functions in any timed path.

import gleam/erlang/atom
import gleam/float
import gleam/int
import gleam/io

type Fd

type Res(a) {
  Ok(a)
  Error(atom.Atom)
  Eof
}

@external(erlang, "file", "open")
fn file_open(path: String, modes: List(atom.Atom)) -> Res(Fd)

@external(erlang, "file", "read")
fn file_read(fd: Fd, size: Int) -> Res(BitArray)

@external(erlang, "file", "close")
fn file_close(fd: Fd) -> atom.Atom

@external(erlang, "erlang", "monotonic_time")
fn monotonic_time(unit: atom.Atom) -> Int

pub fn main() {
  let t0 = monotonic_time(atom.create("microsecond"))
  let modes = [atom.create("read"), atom.create("raw"), atom.create("binary")]
  case file_open("data.bin", modes) {
    Ok(fd) -> {
      let total = chunks(fd, 0)
      let _ = file_close(fd)
      let ms = int.to_float(monotonic_time(atom.create("microsecond")) - t0) /. 1000.0
      io.println_error("TIME_MS=" <> float.to_string(ms))
      io.println(int.to_string(total % 4294967296))
    }
    Error(_) -> panic as "cannot open data.bin"
    Eof -> panic as "file_open cannot return eof"
  }
}

fn chunks(fd: Fd, acc: Int) -> Int {
  case file_read(fd, 1048576) {
    Ok(bin) -> chunks(fd, { acc + sum(bin, 0) } % 4294967296)
    Eof -> acc
    Error(_) -> panic as "cannot read data.bin"
  }
}

fn sum(bits: BitArray, acc: Int) -> Int {
  case bits {
    <<b, rest:bits>> -> sum(rest, acc + b)
    _ -> acc
  }
}
