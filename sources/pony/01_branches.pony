// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: mkdir -p temp/pony/01_branches && cp sources/pony/01_branches.pony temp/pony/01_branches/ && tools/ponyc/bin/ponyc.exe -o temp/pony/01_branches temp/pony/01_branches
// run: temp/pony/01_branches/01_branches.exe
// note: ponyc compiles a directory as one package, and all fifteen files in this row declare a
//       Main actor, so each task is copied to a scratch directory before it is built. The row
//       directory keeps the fifteen sources and no build output.

actor Main
  new create(env: Env) =>
    var a: U64 = 0
    var b: U64 = 0
    var c: U64 = 0
    var d: U64 = 0
    var i: U64 = 0
    while i < 100000000 do
      if (i % 3) == 0 then
        a = a + 1
      elseif (i % 5) == 0 then
        b = b + 1
      elseif (i % 7) == 0 then
        c = c + 1
      else
        d = d + 1
      end
      i = i + 1
    end
    env.out.print(a.string() + " " + b.string() + " " + c.string() + " " + d.string())
