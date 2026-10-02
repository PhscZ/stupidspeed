// task 15 file_write — expected output: 52428800
// build: tools/dotnet10/dotnet.exe tools/boo/src/booc/bin/Release/net10.0/booc.dll -o:prog.exe 15_file_write.boo    run: tools/dotnet10/dotnet.exe prog.exe
// note: the run needs Boo.Lang.dll (tools/boo/src/Boo.Lang/bin/Release/net10.0/) and a
//       prog.runtimeconfig.json for Microsoft.NETCore.App 10.0.0 beside prog.exe.
// note: FileStream.Flush(true) flushes the buffer and calls FlushFileBuffers, which is the fsync
//       the task asks for. The 1 MiB buffer is written fifty times, one write per pass.

import System.IO

buffer = array[of byte](1048576)

i as int = 0
while i < buffer.Length:
    buffer[i] = cast(byte, i % 256)
    i += 1

fs = FileStream("out.bin", FileMode.Create, FileAccess.Write)

written as long = 0
p as int = 0
while p < 50:
    fs.Write(buffer, 0, buffer.Length)
    written += buffer.Length
    p += 1

fs.Flush(true)
fs.Close()

print(written)

