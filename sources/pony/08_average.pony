// task 08 average — expected output: 0.498046875
// build: mkdir -p temp/pony/08_average && cp sources/pony/08_average.pony temp/pony/08_average/ && tools/ponyc/bin/ponyc.exe -o temp/pony/08_average temp/pony/08_average
// run: temp/pony/08_average/08_average.exe
// note: F64 is IEEE binary64. Every reading is an exact multiple of 1/256 and the running sum
//       stays below 2^53, so the sum is exact whatever the order, and the final quotient is
//       exactly 255/512.
// note: F64.string() would print six significant digits ("0.498047"), so the line goes through
//       format.Format.float with precision 17; %g drops the trailing zeros and prints
//       "0.498046875". (Pony's float *literal* parser is lossy — 0.498046875 written as a
//       literal is not exact — which is another reason to print a computed value.)

use "format"

actor Main
  new create(env: Env) =>
    var total: F64 = 0
    var i: U64 = 0
    while i < 100000000 do
      let reading = (i % 256).f64() / 256.0
      total = total + reading
      i = i + 1
    end
    env.out.print(Format.float[F64](total / 100000000.0, FormatDefault, PrefixDefault, 17))
