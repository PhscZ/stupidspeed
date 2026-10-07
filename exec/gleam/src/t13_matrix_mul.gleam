// task 13 matrix_mul — expected output: 599995000
// build: gleam build    run: gleam run --module t13_matrix_mul
// note: run from sources/gleam/, the project root.
// note: Gleam module names may not begin with a digit, so the file is t13_matrix_mul.gleam
//       and the module is t13_matrix_mul. Every file in this row is named the same way.
// note: the plain i, j, k triple loop in that order on flat row-major atomics arrays
//       reached through @external FFI, so the k loop walks a column of B. Reordering would
//       be faster, which is the point. A hundred and twenty-five million multiply-adds.
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
  let n = 500
  let e = n * n
  let a = atomics_new(e, opts())
  let b = atomics_new(e, opts())
  let c = atomics_new(e, opts())
  fill(a, b, 0, n)
  mul(a, b, c, 0, n)
  let answer = sum(c, 0, e)
  let ms = int.to_float(monotonic_time(atom.create("microsecond")) - t0) /. 1000.0
  io.println_error("TIME_MS=" <> float.to_string(ms))
  io.println(int.to_string(answer))
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
      let _ = atomics_put(a, index + 1, { i + j } % 7)
      let _ = atomics_put(b, index + 1, i * j % 5)
      inner(a, b, i, j + 1, n)
    }
  }
}

fn mul(a: Atomics, b: Atomics, c: Atomics, row: Int, n: Int) -> Nil {
  case row >= n {
    True -> Nil
    False -> {
      cols(a, b, c, row, 0, n)
      mul(a, b, c, row + 1, n)
    }
  }
}

fn cols(a: Atomics, b: Atomics, c: Atomics, row: Int, col: Int, n: Int) -> Nil {
  case col >= n {
    True -> Nil
    False -> {
      let _ = atomics_put(c, row * n + col + 1, dot(a, b, row, col, 0, n, 0))
      cols(a, b, c, row, col + 1, n)
    }
  }
}

fn dot(a: Atomics, b: Atomics, row: Int, col: Int, k: Int, n: Int, acc: Int) -> Int {
  case k >= n {
    True -> acc
    False ->
      dot(
        a,
        b,
        row,
        col,
        k + 1,
        n,
        acc + atomics_get(a, row * n + k + 1) * atomics_get(b, k * n + col + 1),
      )
  }
}

fn sum(c: Atomics, k: Int, e: Int) -> Int {
  case k >= e {
    True -> 0
    False -> atomics_get(c, k + 1) + sum(c, k + 1, e)
  }
}
