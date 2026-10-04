// task 04 array_sum — expected output: 499999500000
// build: gleam build    run: gleam run --module t04_array_sum
// note: run from sources/gleam/, the project root.
// note: Gleam module names may not begin with a digit, so the file is t04_array_sum.gleam
//       and the module is t04_array_sum. Every file in this row is named the same way.
// note: Gleam's own language has no mutable state and no array type, so where a task
//       genuinely needs one this row reaches for the runtime's escape hatch through
//       @external FFI: the atomics module, a real fixed-size mutable array of 64-bit
//       integers with O(1) get/put. The three declarations below are hand-written Gleam
//       types for it. Filled in one pass and summed in another, so the fill is not part of
//       the read loop.
// note: Gleam has no loop syntax and no mutable variables. Every loop in this row is tail
//       recursion with explicit accumulators, which the BEAM turns into a jump. The
//       functional style is deliberately avoided: no list.map, no fold and no
//       higher-order functions in any timed path.

import gleam/erlang/atom
import gleam/float
import gleam/int
import gleam/io

type Atomics

@external(erlang, "atomics", "new")
fn atomics_new(size: Int, opts: List(#(atom.Atom, Bool))) -> Atomics

@external(erlang, "atomics", "put")
fn atomics_put(a: Atomics, index: Int, value: Int) -> atom.Atom

@external(erlang, "atomics", "get")
fn atomics_get(a: Atomics, index: Int) -> Int

@external(erlang, "erlang", "monotonic_time")
fn monotonic_time(unit: atom.Atom) -> Int

pub fn main() {
  let t0 = monotonic_time(atom.create("microsecond"))
  let n = 1000000
  let arr = atomics_new(n, [#(atom.create("signed"), True)])
  fill(arr, 0, n)
  let answer = sum(arr, 0, n)
  let ms = int.to_float(monotonic_time(atom.create("microsecond")) - t0) /. 1000.0
  io.println_error("TIME_MS=" <> float.to_string(ms))
  io.println(int.to_string(answer))
}

fn fill(arr: Atomics, i: Int, n: Int) -> Nil {
  case i >= n {
    True -> Nil
    False -> {
      let _ = atomics_put(arr, i + 1, i)
      fill(arr, i + 1, n)
    }
  }
}

fn sum(arr: Atomics, i: Int, n: Int) -> Int {
  case i >= n {
    True -> 0
    False -> atomics_get(arr, i + 1) + sum(arr, i + 1, n)
  }
}
