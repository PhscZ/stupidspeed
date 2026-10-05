"task 09 fib_recursive — expected output: 102334155
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 09_fib_recursive.st -q
 DEVIATION: the recursion goes through a block rather than a method, for the reason
 task 03 records: a method chunk cannot be defined from a script that also runs a
 do-it. A block value: is a real send, so the 331 million calls are still 331 million
 sends, and each one re-enters the same CompiledBlock.
 timing: Time millisecondClockValue is Dolphin's millisecond clock. Dolphin's console has no
 stderr stream, so the contract's fallback applies and TIME_MS goes to time.txt in the working
 directory. Built and run against Dolphin 8.2.3 on this machine, so the timing is real.
 The time.txt write uses nextPut: 10 instead of cr: cr on a file stream hangs the VM,
 while nextPut: 10 writes the newline byte and the run completes."

| ssT0 out fib result |
ssT0 := Time millisecondClockValue.
out := SessionManager current stdout.

fib := nil.
fib := [:n |
	n < 2
		ifTrue: [n]
		ifFalse: [(fib value: n - 1) + (fib value: n - 2)]].

result := fib value: 40.

(FileWriteStream write: 'time.txt' type: #binary)
	nextPutAll: 'TIME_MS=', (Time millisecondClockValue - ssT0) printString;
	nextPut: 10;
	close.

out nextPutAll: result printString; cr; flush.
SessionManager current quit: 0!
