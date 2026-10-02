// task 15 file_write — expected output: 52428800
// build: mkdir -p temp/pony/15_file_write && cp sources/pony/15_file_write.pony temp/pony/15_file_write/ && tools/ponyc/bin/ponyc.exe -o temp/pony/15_file_write temp/pony/15_file_write
// run: cd temp/pony/15_file_write && ./15_file_write.exe
// note: out.bin is opened through the capability API and written a buffered 1 MiB at a time,
//       fifty times. File.write queues the buffer and then loops until every queued byte has
//       gone out, so no short write is lost.
// note: File.sync is fsync — on Windows it is FlushFileBuffers on the underlying handle — and
//       it is called before the file is closed and before the byte count is printed.

use "files"

actor Main
  new create(env: Env) =>
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
      env.out.print(written.string())
    end
