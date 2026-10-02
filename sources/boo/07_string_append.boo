// task 07 string_append — expected output: 1000000
// build: tools/dotnet10/dotnet.exe tools/boo/src/booc/bin/Release/net10.0/booc.dll -o:prog.exe 07_string_append.boo    run: tools/dotnet10/dotnet.exe prog.exe
// note: the run needs Boo.Lang.dll (tools/boo/src/Boo.Lang/bin/Release/net10.0/) and a
//       prog.runtimeconfig.json for Microsoft.NETCore.App 10.0.0 beside prog.exe.
// note: System.String is immutable, so `text = text + "x"` copies the whole string every time
//       and the loop is quadratic. That is the point of the task; a StringBuilder would hide it.
// note: this is the row's slow cell: a clean-state run measured 1712 s, and small-N scaling
//       (10000 appends 0.77 s, 40000 appends 3.6 s) fits 577 ms + 1.885e-6*N^2, which predicts
//       ~1885 s at N = 1e6 and agrees. An earlier measurement on a loaded host gave 2770 s;
//       the number is load-dependent, so treat ~1700-2800 s as the range rather than a constant.

text = ""

i as int = 0
while i < 1000000:
    text = text + "x"
    i += 1

print(text.Length)

