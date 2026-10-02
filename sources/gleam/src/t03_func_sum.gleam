// task 03 func_sum — expected output: 100000000
// build: gleam build    run: gleam run --module t03_func_sum
// note: run from sources/gleam/, the project root.
// note: Gleam module names may not begin with a digit, so the file is t03_func_sum.gleam
//       and the module is t03_func_sum. Every file in this row is named the same way.
// note: the helper add_one lives in its own module, t03_add_one, exactly as the task asks.
//       Gleam has no no-inline attribute and no attribute syntax at all, but the Erlang
//       backend does not inline across modules, so the call is a real cross-module call a
//       hundred million times -- the same guarantee the Fortran, Tcl, Vala and Common Lisp
//       rows get by splitting the task into two files.
// note: Gleam has no loop syntax and no mutable variables. Every loop in this row is tail
//       recursion with explicit accumulators, which the BEAM turns into a jump. The
//       functional style is deliberately avoided: no list.map, no fold and no
//       higher-order functions in any timed path.

import gleam/int
import gleam/io
import t03_add_one

pub fn main() {
  io.println(int.to_string(loop(0, 0)))
}

fn loop(i: Int, value: Int) -> Int {
  case i {
    100000000 -> value
    _ -> loop(i + 1, t03_add_one.add_one(value))
  }
}
