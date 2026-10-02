// task 12 matrix_add — expected output: 999000000
// build: mkdir -p temp/pony/12_matrix_add && cp sources/pony/12_matrix_add.pony temp/pony/12_matrix_add/ && tools/ponyc/bin/ponyc.exe -o temp/pony/12_matrix_add temp/pony/12_matrix_add
// run: temp/pony/12_matrix_add/12_matrix_add.exe
// note: A[i][j] = i + j and B[i][j] = i - j, so B needs a signed element; the three 1000x1000
//       matrices are flat I64 arrays of a million elements each, 8 MB apiece.


actor Main
  new create(env: Env) =>
    let n: USize = 1000
    let cells = n * n
    let a = Array[I64].init(0, cells)
    let b = Array[I64].init(0, cells)
    let c = Array[I64].init(0, cells)
    try
      var i: USize = 0
      while i < n do
        var j: USize = 0
        while j < n do
          let idx = (i * n) + j
          a(idx)? = i.i64() + j.i64()
          b(idx)? = i.i64() - j.i64()
          j = j + 1
        end
        i = i + 1
      end

      var k: USize = 0
      var total: I64 = 0
      while k < cells do
        c(k)? = a(k)? + b(k)?
        total = total + c(k)?
        k = k + 1
      end
      env.out.print(total.string())
    end
