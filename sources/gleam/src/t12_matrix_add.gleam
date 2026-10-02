// task 12 matrix_add — expected output: 999000000
// build: gleam build    run: gleam run --module t12_matrix_add
// note: run from sources/gleam/, the project root.
// note: Gleam module names may not begin with a digit, so the file is t12_matrix_add.gleam
//       and the module is t12_matrix_add. Every file in this row is named the same way.
// note: Gleam has no array type and no mutable state, so the three 1000x1000 matrices are
//       flat row-major atomics arrays reached through @external FFI -- the runtime's own
//       fixed-size mutable array of 64-bit integers. They are built and added with plain
//       index arithmetic. The total fits comfortably in a 64-bit integer.
// note: Gleam has no loop syntax and no mutable variables. Every loop in this row is tail
//       recursion with explicit accumulators, which the BEAM turns into a jump. The
//       functional style is deliberately avoided: no list.map, no fold and no
//       higher-order functions in any timed path.

import gleam/erlang/atom
import gleam/int
import gleam/io

type Atomics

@external(erlang, "atomics", "new")
fn atomics_new(size: Int, opts: List(#(atom.Atom, Bool))) -> Atomics

@external(erlang, "atomics", "put")
fn atomics_put(a: Atomics, index: Int, value: Int) -> atom.Atom

@external(erlang, "atomics", "get")
fn atomics_get(a: Atomics, index: Int) -> Int

pub fn main() {
  let n = 1000
  let e = n * n
  let a = atomics_new(e, opts())
  let b = atomics_new(e, opts())
  let c = atomics_new(e, opts())
  fill(a, b, 0, n)
  add(a, b, c, 0, e)
  io.println(int.to_string(sum(c, 0, e)))
}

fn opts() -> List(#(atom.Atom, Bool)) {
  [#(atom.create("signed"), True)]
}

fn fill(a: Atomics, b: Atomics, i: Int, n: Int) -> Nil {
  case i >= n {
    True -> Nil
    False -> {
      inner(a, b, i, 0, n)
      fill(a, b, i + 1, n)
    }
  }
}

fn inner(a: Atomics, b: Atomics, i: Int, j: Int, n: Int) -> Nil {
  case j >= n {
    True -> Nil
    False -> {
      let index = i * n + j
      let _ = atomics_put(a, index + 1, i + j)
      let _ = atomics_put(b, index + 1, i - j)
      inner(a, b, i, j + 1, n)
    }
  }
}

fn add(a: Atomics, b: Atomics, c: Atomics, k: Int, e: Int) -> Nil {
  case k >= e {
    True -> Nil
    False -> {
      let _ = atomics_put(c, k + 1, atomics_get(a, k + 1) + atomics_get(b, k + 1))
      add(a, b, c, k + 1, e)
    }
  }
}

fn sum(c: Atomics, k: Int, e: Int) -> Int {
  case k >= e {
    True -> 0
    False -> atomics_get(c, k + 1) + sum(c, k + 1, e)
  }
}
