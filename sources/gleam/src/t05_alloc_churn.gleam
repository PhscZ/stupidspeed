// task 05 alloc_churn — expected output: 1274991808
// build: gleam build    run: gleam run --module t05_alloc_churn
// note: run from sources/gleam/, the project root.
// note: Gleam module names may not begin with a digit, so the file is t05_alloc_churn.gleam
//       and the module is t05_alloc_churn. Every file in this row is named the same way.
// note: ten million 64-byte binaries, each stored into one of 256 slots so the buffer it
//       replaces becomes garbage -- the same reachability line the C and Java rows draw.
//       The slots are the process dictionary, reached through @external FFI on
//       erlang:put/2, which is the runtime's mutable state. The total adds v, the value
//       written into the buffer, so the allocation cannot be optimised away.
// note: Gleam has no loop syntax and no mutable variables. Every loop in this row is tail
//       recursion with explicit accumulators, which the BEAM turns into a jump. The
//       functional style is deliberately avoided: no list.map, no fold and no
//       higher-order functions in any timed path.

import gleam/erlang/atom
import gleam/float
import gleam/int
import gleam/io

@external(erlang, "erlang", "monotonic_time")
fn monotonic_time(unit: atom.Atom) -> Int

@external(erlang, "binary", "copy")
fn binary_copy(subject: BitArray, times: Int) -> BitArray

@external(erlang, "erlang", "put")
fn process_dictionary_put(key: a, value: b) -> c

pub fn main() {
  let t0 = monotonic_time(atom.create("microsecond"))
  churn(0, 0, t0)
}

fn churn(i: Int, total: Int, t0: Int) -> Nil {
  case i {
    10000000 -> {
      let ms = int.to_float(monotonic_time(atom.create("microsecond")) - t0) /. 1000.0
      io.println_error("TIME_MS=" <> float.to_string(ms))
      io.println(int.to_string(total))
    }
    _ -> {
      let v = i % 256
      let buf = binary_copy(<<v:8>>, 64)
      let _ = process_dictionary_put(v, buf)
      churn(i + 1, total + v, t0)
    }
  }
}
