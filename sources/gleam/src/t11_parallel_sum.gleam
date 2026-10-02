// task 11 parallel_sum — expected output: 7500000075000000
// build: gleam build    run: gleam run --module t11_parallel_sum
// note: run from sources/gleam/, the project root.
// note: Gleam module names may not begin with a digit, so the file is t11_parallel_sum.gleam
//       and the module is t11_parallel_sum. Every file in this row is named the same way.
// note: four real OS threads. Gleam has no thread primitive of its own, so this uses the
//       runtime's own concurrency through the gleam_erlang package: process.spawn/1 puts
//       each worker on its own BEAM process and the BEAM runs one scheduler per core with
//       no global lock, so the four really overlap. That is the same mechanism the Erlang
//       and Elixir rows use, and it is real parallelism, not cooperative scheduling.
// note: the workers report through a Subject and the parent blocks in receive_forever,
//       which is the join. Each worker owns a fixed range, so which one finishes first does
//       not change the answer. The four receives are written out one per line so the order
//       of the join is explicit rather than an argument to the `+` operator.
// note: Gleam has no loop syntax and no mutable variables. Every loop in this row is tail
//       recursion with explicit accumulators, which the BEAM turns into a jump.

import gleam/erlang/process
import gleam/int
import gleam/io

const span = 25000000

pub fn main() {
  let subject = process.new_subject()
  let _ = process.spawn(fn() { process.send(subject, work(0)) })
  let _ = process.spawn(fn() { process.send(subject, work(1)) })
  let _ = process.spawn(fn() { process.send(subject, work(2)) })
  let _ = process.spawn(fn() { process.send(subject, work(3)) })
  let first = process.receive_forever(subject)
  let second = process.receive_forever(subject)
  let third = process.receive_forever(subject)
  let fourth = process.receive_forever(subject)
  io.println(int.to_string(first + second + third + fourth))
}

fn work(t: Int) -> Int {
  loop(t * span, { t + 1 } * span, 0)
}

fn loop(i: Int, end: Int, acc: Int) -> Int {
  case i >= end {
    True -> acc
    False ->
      case i % 4 {
        0 -> loop(i + 1, end, acc + 1)
        1 -> loop(i + 1, end, acc + i)
        2 -> loop(i + 1, end, acc + 2 * i)
        _ -> loop(i + 1, end, acc + 3 * i)
      }
  }
}
