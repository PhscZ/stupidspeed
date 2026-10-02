// task 14 file_read — expected output: 2389704704
// build: mkdir -p temp/pony/14_file_read && cp sources/pony/14_file_read.pony temp/pony/14_file_read/ && cp temp/verify/data.bin temp/pony/14_file_read/ && tools/ponyc/bin/ponyc.exe -o temp/pony/14_file_read temp/pony/14_file_read
// run: cd temp/pony/14_file_read && ./14_file_read.exe
// note: data.bin is opened read-only through the capability API, FilePath(FileAuth(env.root),
//       "data.bin"), and read in 1 MiB chunks until a short read; File.read returns up to len
//       bytes, so the loop is what handles a partial read rather than a single read(50 MiB).
// note: the byte total is 6684672000, which is reduced modulo 4294967296; U64 holds the running
//       sum without wrapping.

use "files"

actor Main
  new create(env: Env) =>
    try
      let path = FilePath(FileAuth(env.root), "data.bin")
      let file = match OpenFile(path)
      | let f: File => f
      else
        error
      end

      var total: U64 = 0
      var more = true
      while more do
        let buf: Array[U8] iso = file.read(1 << 20)
        if buf.size() == 0 then
          more = false
        else
          let bytes: Array[U8] val = consume buf
          for byte in bytes.values() do
            total = total + byte.u64()
          end
        end
      end
      file.dispose()
      env.out.print((total % 4294967296).string())
    end
