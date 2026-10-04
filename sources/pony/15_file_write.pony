// task 15 file_write — expected output: 52428800
// timing: Time.nanos() is Pony's monotonic clock (QueryPerformanceCounter on Windows);
//        TIME_MS goes to stderr with env.err.print and stdout is unchanged.
// build: mkdir -p temp/pony/15_file_write && cp sources/pony/15_file_write.pony temp/pony/15_file_write/ && tools/ponyc/bin/ponyc.exe -o temp/pony/15_file_write temp/pony/15_file_write
// run: cd temp/pony/15_file_write && ./15_file_write.exe
// note: out.bin is opened through the capability API and written a buffered 1 MiB at a time,
//       fifty times. File.write queues the buffer and then loops until every queued byte has
//       gone out, so no short write is lost.
// note: File.sync is fsync — on Windows it is FlushFileBuffers on the underlying handle — and
//       it is called before the file is closed and before the byte count is printed.

use "time"
use "files"

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
    try
      let path = FilePath(FileAuth(env.root), "out.bin")
      let file = File(path)
      if not file.valid() then error end

      let buffer: Array[U8] val = recover val
        let b = Array[U8](1 << 20)
        var i: USize = 0
        while i < (1 << 20) do
          b.push((i % 256).u8())
          i = i + 1
        end
        b
      end

      var written: USize = 0
      var pass: USize = 0
      while pass < 50 do
        file.write(buffer)
        written = written + buffer.size()
        pass = pass + 1
      end
      file.sync()
      file.dispose()
      ss.report()
      env.out.print(written.string())
    end
