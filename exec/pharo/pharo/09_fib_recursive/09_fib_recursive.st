"task 09 fib_recursive — expected output: 102334155
 build: none (image is prebuilt)    run: tools/pharo/PharoConsole.exe --headless tools/pharo/Pharo13.0-SNAPSHOT-64bit-d7c6f761d5.image st --quit --no-source 09_fib_recursive.st
 DEVIATION: the recursion goes through a BlockClosure rather than a compiled method,
 for the reason task 03 records: a method chunk cannot be defined from a script that
 also runs a do-it. `value:` is a real send, so the ~331 million calls are still 331
 million sends, and each one re-enters the same CompiledBlock."

| out err fib result t0 |
out := Stdio stdout.
err := Stdio stderr.
t0 := Time microsecondClockValue.

fib := nil.
fib := [:n |
	n < 2
		ifTrue: [n]
		ifFalse: [(fib value: n - 1) + (fib value: n - 2)]].

result := fib value: 40.
err nextPutAll: 'TIME_MS=', ((Time microsecondClockValue - t0) / 1000.0) printString, String lf; flush.
out nextPutAll: result printString; lf; flush.
