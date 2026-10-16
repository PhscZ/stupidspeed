// task 13 matrix_mul — expected output: 599995000
// timing: Time.nanos() is Pony's monotonic clock (QueryPerformanceCounter on Windows);
//        TIME_MS goes to stderr with env.err.print and stdout is unchanged.
// build: mkdir -p temp/pony/13_matrix_mul && cp sources/pony/13_matrix_mul.pony temp/pony/13_matrix_mul/ && tools/ponyc/bin/ponyc.exe -o temp/pony/13_matrix_mul temp/pony/13_matrix_mul
// run: temp/pony/13_matrix_mul/13_matrix_mul.exe
// note: plain triple loop in i, j, k order — the k loop walks B by column, which is the point.
//       A holds (i+j) mod 7 and B holds (i*j) mod 5, both under U64.


use "time"
class SsClock
  var t0: U64 = 0
  let env: Env
  new create(env': Env) =>
    env = env'
  fun ref start() =>
    t0 = Time.nanos()
  fun ref report() =>
    env.err.print("TIME_MS=" + ((Time.nanos() - t0) / 1000000).string())

actor Main
  new create(env: Env) =>
    let ss = SsClock(env)
    ss.start()
    let n: USize = 500
    let cells = n * n
    let a = Array[U64].init(0, cells)
    let b = Array[U64].init(0, cells)
    let c = Array[U64].init(0, cells)
    try
      var i: USize = 0
      while i < n do
        var j: USize = 0
        while j < n do
          let idx = (i * n) + j
          a(idx)? = ((i + j) % 7).u64()
          b(idx)? = ((i * j) % 5).u64()
          j = j + 1
        end
        i = i + 1
      end

      i = 0
      while i < n do
        var j: USize = 0
        let row = i * n
        while j < n do
          var sum: U64 = 0
          var k: USize = 0
          while k < n do
            sum = sum + (a(row + k)? * b((k * n) + j)?)
            k = k + 1
          end
          c(row + j)? = sum
          j = j + 1
        end
        i = i + 1
      end

      var m: USize = 0
      var total: U64 = 0
      while m < cells do
        total = total + c(m)?
        m = m + 1
      end
      ss.report()
      env.out.print(total.string())
    end
