// task 07 string_append — expected output: 250000
// build: gleam build    run: gleam run --module t07_string_append
// note: run from sources/gleam/, the project root.
// note: Gleam module names may not begin with a digit, so the file is t07_string_append.gleam
//       and the module is t07_string_append. Every file in this row is named the same way.
// note: the append uses the `<>` operator rather than string.append, because `<>` is
//       compiled inline to <<A/binary, B/binary>> and BEAM's writable-binary optimisation
//       then turns the natural append loop into an amortised O(1) in-place extend, so this
//       runs LINEAR here rather than the quadratic copy task 07 is designed to measure.
//       string.append is a cross-module call, which would lose that optimisation and be
//       quadratic for the wrong reason. The runtime's real behaviour is recorded rather
//       than worked around; forcing a copy would mean writing the row artificially.
// note: Gleam has no loop syntax and no mutable variables. Every loop in this row is tail
//       recursion with explicit accumulators, which the BEAM turns into a jump.

import gleam/int
import gleam/io
import gleam/string

pub fn main() {
  io.println(int.to_string(string.length(append(250000, ""))))
}

fn append(n: Int, acc: String) -> String {
  case n {
    0 -> acc
    _ -> append(n - 1, acc <> "x")
  }
}
