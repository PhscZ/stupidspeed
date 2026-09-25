"task 09 fib_recursive — expected output: 102334155
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 09_fib_recursive.st -q
 DEVIATION: the recursion goes through a block rather than a method, for the reason
 task 03 records: a method chunk cannot be defined from a script that also runs a
 do-it. A block value: is a real send, so the 331 million calls are still 331 million
 sends, and each one re-enters the same CompiledBlock."

| out fib |
out := SessionManager current stdout.

fib := nil.
fib := [:n |
	n < 2
		ifTrue: [n]
		ifFalse: [(fib value: n - 1) + (fib value: n - 2)]].

out nextPutAll: (fib value: 40) printString; cr; flush.
SessionManager current quit: 0!
