// task 02 switch_case — expected output: 7500000075000000
// build: tools/dotnet10/dotnet.exe tools/boo/src/booc/bin/Release/net10.0/booc.dll -o:prog.exe 02_switch_case.boo    run: tools/dotnet10/dotnet.exe prog.exe
// note: the run needs Boo.Lang.dll (tools/boo/src/Boo.Lang/bin/Release/net10.0/) and a
//       prog.runtimeconfig.json for Microsoft.NETCore.App 10.0.0 beside prog.exe.
// note: Boo 0.9.7 has no switch statement. `switch` and `case` are not keywords in the lexer and
//       the parser has no switch rule, so the four cases are an if/elif/else chain on i % 4 --
//       the same shape the Lua and V rows use. Only the internal __switch__ goto primitive
//       survives in this compiler, and it is not a language construct.

acc as long = 0

i as long = 0
while i < 100000000:
    c = i % 4
    if c == 0:
        acc += 1
    elif c == 1:
        acc += i
    elif c == 2:
        acc += 2 * i
    else:
        acc += 3 * i
    i += 1

print(acc)

