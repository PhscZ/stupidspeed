// task 14 file_read — expected output: 2389704704
// build: tools/dotnet10/dotnet.exe tools/boo/src/booc/bin/Release/net10.0/booc.dll -o:prog.exe 14_file_read.boo    run: tools/dotnet10/dotnet.exe prog.exe
// note: the run needs Boo.Lang.dll (tools/boo/src/Boo.Lang/bin/Release/net10.0/) and a
//       prog.runtimeconfig.json for Microsoft.NETCore.App 10.0.0 beside prog.exe; the 50 MiB
//       data.bin is opened relative to the working directory, as in every other row.
// note: 1 MiB reads, and the per-byte sum is a plain loop over the buffer.

import System.IO

fs = FileStream("data.bin", FileMode.Open, FileAccess.Read)
buffer = array[of byte](1048576)

total as long = 0
read as int = 0
while true:
    read = fs.Read(buffer, 0, buffer.Length)
    if read <= 0:
        break
    i as int = 0
    while i < read:
        total += buffer[i]
        i += 1
fs.Close()

print(total % 4294967296)

