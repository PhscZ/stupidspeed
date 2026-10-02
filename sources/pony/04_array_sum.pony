// task 04 array_sum — expected output: 499999500000
// build: mkdir -p temp/pony/04_array_sum && cp sources/pony/04_array_sum.pony temp/pony/04_array_sum/ && tools/ponyc/bin/ponyc.exe -o temp/pony/04_array_sum temp/pony/04_array_sum
// run: temp/pony/04_array_sum/04_array_sum.exe
// note: Array[A](len) only reserves space — its size stays zero — so the million elements come
//       from Array[U64].init(0, n), which is one contiguous allocation. The sum 499999500000
//       fits in U64.


actor Main
  new create(env: Env) =>
    let n: USize = 1000000
    let array = Array[U64].init(0, n)
    try
      var i: USize = 0
      while i < n do
        array(i)? = i.u64()
        i = i + 1
      end
      var total: U64 = 0
      i = 0
      while i < n do
        total = total + array(i)?
        i = i + 1
      end
      env.out.print(total.string())
    end
