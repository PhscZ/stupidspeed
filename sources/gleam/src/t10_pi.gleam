// task 10 pi — expected output: 4470
// build: gleam build    run: gleam run --module t10_pi
// note: run from sources/gleam/, the project root.
// note: Gleam module names may not begin with a digit, so the file is t10_pi.gleam and the
//       module is t10_pi. Every file in this row is named the same way.
// note: Gleam's Int IS the Erlang integer, so it is arbitrary precision for free: `/` is a
//       real division on bignums and no library or hand-rolled limbs are needed. This is
//       the standard-library route the README describes, not the hand-rolled one.
// note: the algorithm is Gibbons' unbounded spigot, the same loop as every other row. The
//       state is (q, r, t, k, n, l) and the two rules below are exactly the ones from the
//       paper. One thousand digits are emitted and their sum is printed.
// note: Gleam has no loop syntax and no mutable variables. Every loop in this row is tail
//       recursion with explicit accumulators, which the BEAM turns into a jump.

import gleam/int
import gleam/io

const digits = 1000

pub fn main() {
  io.println(int.to_string(loop(1, 0, 1, 1, 3, 3, 0, 0)))
}

fn loop(q: Int, r: Int, t: Int, k: Int, n: Int, l: Int, emitted: Int, sum: Int) -> Int {
  case emitted >= digits {
    True -> sum
    False ->
      // if 4*q + r - t < n*t then emit n
      case 4 * q + r - t < n * t {
        True ->
          loop(
            10 * q,
            10 * { r - n * t },
            t,
            k,
            10 * { 3 * q + r } / t - 10 * n,
            l,
            emitted + 1,
            sum + n,
          )
        False ->
          loop(
            q * k,
            { 2 * q + r } * l,
            t * l,
            k + 1,
            { q * { 7 * k + 2 } + r * l } / { t * l },
            l + 2,
            emitted,
            sum,
          )
      }
  }
}
