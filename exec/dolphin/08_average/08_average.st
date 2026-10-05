"task 08 average — expected output: 0.498046875
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 08_average.st -q
 Float division throughout: `reading` is a Double, and the reading is a multiple of
 1/256, which is exact in binary, so the sum is exact and the digits do not depend on
 the order the numbers are added in.
 timing: Time millisecondClockValue is Dolphin's millisecond clock. Dolphin's console has no
 stderr stream, so the contract's fallback applies and TIME_MS goes to time.txt in the working
 directory. Built and run against Dolphin 8.2.3 on this machine, so the timing is real.
 The time.txt write uses nextPut: 10 instead of cr: cr on a file stream hangs the VM,
 while nextPut: 10 writes the newline byte and the run completes."

| ssT0 out total |
ssT0 := Time millisecondClockValue.
out := SessionManager current stdout.
total := 0.0.

0 to: 99999999 do: [:i |
	| reading |
	reading := (i \\ 256) / 256.0.
	total := total + reading].

(FileWriteStream write: 'time.txt' type: #binary)
	nextPutAll: 'TIME_MS=', (Time millisecondClockValue - ssT0) printString;
	nextPut: 10;
	close.

out nextPutAll: (total / 100000000.0) printString; cr; flush.
SessionManager current quit: 0!
