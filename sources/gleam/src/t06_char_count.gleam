// task 06 char_count — expected output: 10000000
// build: gleam build    run: gleam run --module t06_char_count
// note: run from sources/gleam/, the project root.
// note: Gleam module names may not begin with a digit, so the file is t06_char_count.gleam
//       and the module is t06_char_count. Every file in this row is named the same way.
// note: the 100 MB text is built in one call by string.repeat, which doubles the block
//       rather than appending in a loop, and then scanned one byte at a time with the
//       language's own bit-array pattern `<<b, rest:bits>>`. A Gleam String is UTF-8, so
//       bit-array patterns cannot match it directly; bit_array.from_string is the identity
//       function on the BEAM and is used only to change the type the compiler sees.
// note: Gleam has no loop syntax and no mutable variables. Every loop in this row is tail
//       recursion with explicit accumulators, which the BEAM turns into a jump. The
//       functional style is deliberately avoided: no list.map, no fold and no
//       higher-order functions in any timed path.

import gleam/bit_array
import gleam/int
import gleam/io
import gleam/string

pub fn main() {
  let text = bit_array.from_string(string.repeat("abcdefghij", 10000000))
  io.println(int.to_string(scan(text, 0)))
}

fn scan(text: BitArray, count: Int) -> Int {
  case text {
    <<b, rest:bits>> ->
      case b {
        97 -> scan(rest, count)
        101 -> scan(rest, count)
        104 -> scan(rest, count + 1)
        _ -> scan(rest, count)
      }
    _ -> count
  }
}
