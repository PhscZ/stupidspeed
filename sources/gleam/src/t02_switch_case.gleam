// task 02 switch_case — expected output: 7500000075000000
// build: gleam build    run: gleam run --module t02_switch_case
// note: run from sources/gleam/, the project root.
// note: Gleam module names may not begin with a digit, so the file is t02_switch_case.gleam
//       and the module is t02_switch_case. Every file in this row is named the same way.
// note: Gleam has no loop syntax and no mutable variables. Every loop in this row is tail
//       recursion with explicit accumulators, which the BEAM turns into a jump, plus case
//       for the branches. The functional style is deliberately avoided: no list.map, no
//       fold, no comprehensions and no higher-order functions in any timed path. This is
//       the most procedural register the language has; it cannot honestly be called
//       imperative, and the row does not claim to be.
// note: `case i % 4` over four integer literals is this language's switch, and the Erlang
//       backend compiles it to a jump table, so this task and task 01 really are the two
//       shapes the benchmark wants to compare. Int is an arbitrary-precision Erlang integer,
//       so the 7500000075000000 total is exact.

import gleam/int
import gleam/io

pub fn main() {
  io.println(int.to_string(loop(0, 0)))
}

fn loop(i: Int, acc: Int) -> Int {
  case i {
    100000000 -> acc
    _ ->
      case i % 4 {
        0 -> loop(i + 1, acc + 1)
        1 -> loop(i + 1, acc + i)
        2 -> loop(i + 1, acc + 2 * i)
        _ -> loop(i + 1, acc + 3 * i)
      }
  }
}
