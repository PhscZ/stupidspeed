"task 03 func_sum — expected output: 100000000
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 03_func_sum.st -q
 DEVIATION: the function is a BlockClosure rather than a method. Smalltalk has no
 no-inline attribute, and a method chunk cannot be defined from a script file that
 also runs a do-it, so the callable is a block held in a variable. A block value: is
 still a real message send, so the hundred million calls happen, which is what the
 task measures; there is nothing to inline away because the VM dispatches through
 the closure's compiled method. This is the same position Java and Scala are in.
 timing: Time millisecondClockValue is Dolphin's millisecond clock. Dolphin's console has no
 stderr stream, so the contract's fallback applies and TIME_MS goes to time.txt in the working
 directory. Built and run against Dolphin 8.2.3 on this machine, so the timing is real.
 The time.txt write uses nextPut: 10 instead of cr: cr on a file stream hangs the VM,
 while nextPut: 10 writes the newline byte and the run completes."

| ssT0 out addOne value |
ssT0 := Time millisecondClockValue.
out := SessionManager current stdout.

addOne := [:n | n + 1].
value := 0.

0 to: 99999999 do: [:i | value := addOne value: value].

(FileWriteStream write: 'time.txt' type: #binary)
	nextPutAll: 'TIME_MS=', (Time millisecondClockValue - ssT0) printString;
	nextPut: 10;
	close.

out nextPutAll: value printString; cr; flush.
SessionManager current quit: 0!
