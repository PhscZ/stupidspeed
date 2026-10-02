"task 03 func_sum — expected output: 100000000
 build: none (image is prebuilt)    run: tools/pharo/PharoConsole.exe --headless tools/pharo/Pharo13.0-SNAPSHOT-64bit-d7c6f761d5.image st --quit --no-source 03_func_sum.st
 DEVIATION: the function is a BlockClosure held in a variable rather than a compiled
 method, for the same reason the Dolphin Smalltalk row records: a method chunk cannot
 be defined from a script file that also runs a do-it. `value:` is a real send that
 dispatches through the block's compiled method, so the hundred million calls happen
 and there is nothing for the JIT to inline away. This is the same position Java and
 Scala are in."

| out addOne value |
out := Stdio stdout.

addOne := [:n | n + 1].
value := 0.

0 to: 99999999 do: [:i | value := addOne value: value].

out nextPutAll: value printString; lf; flush.
