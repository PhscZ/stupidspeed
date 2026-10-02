// task 09 fib_recursive — expected output: 102334155
// build: gleam build    run: gleam run --module t09_fib_recursive
// note: run from sources/gleam/, the project root.
// note: Gleam module names may not begin with a digit, so the file is t09_fib_recursive.gleam
//       and the module is t09_fib_recursive. Every file in this row is named the same way.
// note: naive fib(40): about 331 million calls, so this measures the call path itself. It is
//       the one task in this row that is not tail recursion -- the two calls are added --
//       and it is written exactly as the task specifies.
// note: Gleam has no loop syntax and no mutable variables, so every other loop in this row
//       is tail recursion with explicit accumulators, which the BEAM turns into a jump.

import gleam/int
import gleam/io

pub fn main() {
  io.println(int.to_string(fib(40)))
}

fn fib(n: Int) -> Int {
  case n < 2 {
    True -> n
    False -> fib(n - 1) + fib(n - 2)
  }
}
