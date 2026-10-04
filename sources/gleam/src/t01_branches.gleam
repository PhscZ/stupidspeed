// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: gleam build    run: gleam run --module t01_branches
// note: run from sources/gleam/, the project root. `gleam build` compiles every module in
//       this row; `gleam run --module X` re-checks and then calls X.main. Only the
//       program's own output goes to stdout, gleam's progress lines go to stderr.
// note: Gleam module names may not begin with a digit, so the file is t01_branches.gleam
//       and the module is t01_branches. Every file in this row is named the same way.
// note: Gleam has no loop syntax and no mutable variables. Every loop in this row is tail
//       recursion with explicit accumulators, which the BEAM turns into a jump, plus case
//       for the branches. The functional style is deliberately avoided: no list.map, no
//       fold, no comprehensions and no higher-order functions in any timed path. This is
//       the most procedural register the language has; it cannot honestly be called
//       imperative, and the row does not claim to be.

import gleam/erlang/atom
import gleam/float
import gleam/int
import gleam/io

@external(erlang, "erlang", "monotonic_time")
fn monotonic_time(unit: atom.Atom) -> Int

pub fn main() {
  let t0 = monotonic_time(atom.create("microsecond"))
  let #(a, b, c, d) = loop(0, 0, 0, 0, 0)
  let ms = int.to_float(monotonic_time(atom.create("microsecond")) - t0) /. 1000.0
  io.println_error("TIME_MS=" <> float.to_string(ms))
  io.println(
    int.to_string(a)
    <> " "
    <> int.to_string(b)
    <> " "
    <> int.to_string(c)
    <> " "
    <> int.to_string(d),
  )
}

fn loop(i: Int, a: Int, b: Int, c: Int, d: Int) -> #(Int, Int, Int, Int) {
  case i {
    100000000 -> #(a, b, c, d)
    _ ->
      case i % 3 {
        0 -> loop(i + 1, a + 1, b, c, d)
        _ ->
          case i % 5 {
            0 -> loop(i + 1, a, b + 1, c, d)
            _ ->
              case i % 7 {
                0 -> loop(i + 1, a, b, c + 1, d)
                _ -> loop(i + 1, a, b, c, d + 1)
              }
          }
      }
  }
}
