// task 07 string_append — expected output: 250000
// build: mkdir -p temp/pony/07_string_append && cp sources/pony/07_string_append.pony temp/pony/07_string_append/ && tools/ponyc/bin/ponyc.exe -o temp/pony/07_string_append temp/pony/07_string_append
// run: temp/pony/07_string_append/07_string_append.exe
// note: String is immutable, but a String built inside a `recover iso` block is owned by the
//       block and `append` grows it in place with the usual doubling, so the 250000 appends
//       are amortised O(1) rather than quadratic. The constructor preallocates the final size
//       anyway.

actor Main
  new create(env: Env) =>
    let text: String val = recover iso
      let s = String(250000)
      var i: USize = 0
      while i < 250000 do
        s.append("x")
        i = i + 1
      end
      s
    end
    env.out.print(text.size().string())
