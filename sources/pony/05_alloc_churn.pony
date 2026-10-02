// task 05 alloc_churn — expected output: 1274991808
// build: mkdir -p temp/pony/05_alloc_churn && cp sources/pony/05_alloc_churn.pony temp/pony/05_alloc_churn/ && tools/ponyc/bin/ponyc.exe -o temp/pony/05_alloc_churn temp/pony/05_alloc_churn
// run: temp/pony/05_alloc_churn/05_alloc_churn.exe
// note: `slots` is what keeps each buffer reachable and drops the one it replaces; without it
//       the buffer is dead and the allocation can be deleted, which is the README's warning
//       that the line is not decoration. Pony's GC is per-actor and tracing, so the ten
//       million dropped 64-byte buffers are real garbage for the collector.


actor Main
  new create(env: Env) =>
    let slots = Array[Array[U8]]
    var i: USize = 0
    while i < 256 do
      slots.push(Array[U8].init(0, 64))
      i = i + 1
    end
    try
      var total: U64 = 0
      i = 0
      while i < 10000000 do
        let buf = Array[U8].init(0, 64)
        buf(0)? = (i % 256).u8()
        total = total + buf(0)?.u64()
        slots(i % 256)? = buf
        i = i + 1
      end
      env.out.print(total.string())
    end
