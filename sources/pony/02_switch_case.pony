// task 02 switch_case — expected output: 7500000075000000
// build: mkdir -p temp/pony/02_switch_case && cp sources/pony/02_switch_case.pony temp/pony/02_switch_case/ && tools/ponyc/bin/ponyc.exe -o temp/pony/02_switch_case temp/pony/02_switch_case
// run: temp/pony/02_switch_case/02_switch_case.exe
// note: Pony's switch is `match`. The total is 7500000075000000, which fits in U64 (< 2^63).

actor Main
  new create(env: Env) =>
    var acc: U64 = 0
    var i: U64 = 0
    while i < 100000000 do
      match (i % 4)
      | 0 => acc = acc + 1
      | 1 => acc = acc + i
      | 2 => acc = acc + (2 * i)
      | 3 => acc = acc + (3 * i)
      end
      i = i + 1
    end
    env.out.print(acc.string())
