// task 08 average — expected output: 0.498046875
// build: gleam build    run: gleam run --module t08_average
// note: run from sources/gleam/, the project root.
// note: Gleam module names may not begin with a digit, so the file is t08_average.gleam
//       and the module is t08_average. Every file in this row is named the same way.
// note: Gleam's Float is an Erlang float, an IEEE-754 double. A hundred million readings,
//       each a multiple of 1/256, accumulated with the float operators `+.` and `/.`. The
//       total is far below 2^53, so the sum is exact and the digits do not depend on the
//       order of addition. float.to_string prints the shortest representation that round
//       trips, which is exactly 0.498046875 here.
// note: Gleam has no loop syntax and no mutable variables. Every loop in this row is tail
//       recursion with explicit accumulators, which the BEAM turns into a jump.

import gleam/float
import gleam/int
import gleam/io

pub fn main() {
  let total = acc(0, 100000000, 0.0)
  io.println(float.to_string(total /. 100000000.0))
}

fn acc(i: Int, n: Int, total: Float) -> Float {
  case i >= n {
    True -> total
    False -> acc(i + 1, n, total +. int.to_float(i % 256) /. 256.0)
  }
}
