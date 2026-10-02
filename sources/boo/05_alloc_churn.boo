// task 05 alloc_churn — expected output: 1274991808
// build: tools/dotnet10/dotnet.exe tools/boo/src/booc/bin/Release/net10.0/booc.dll -o:prog.exe 05_alloc_churn.boo    run: tools/dotnet10/dotnet.exe prog.exe
// note: the run needs Boo.Lang.dll (tools/boo/src/Boo.Lang/bin/Release/net10.0/) and a
//       prog.runtimeconfig.json for Microsoft.NETCore.App 10.0.0 beside prog.exe.
// note: this Boo writes an array type as (T), not T[]: `array[of (byte)](256)` is a real
//       System.Byte[][], while `byte[]` is not accepted in a type reference at all
//       ("Unbalanced expression, closing paren not found").

total as long = 0
slots = array[of (byte)](256)

i as int = 0
while i < 10000000:
    buf = array[of byte](64)
    buf[0] = cast(byte, i % 256)
    total += buf[0]
    // Storing the buffer keeps it reachable; the array it replaces becomes garbage.
    slots[i % 256] = buf
    i += 1

print(total)

