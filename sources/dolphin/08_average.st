"task 08 average — expected output: 0.498046875
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 08_average.st -q
 Float division throughout: `reading` is a Double, and the reading is a multiple of
 1/256, which is exact in binary, so the sum is exact and the digits do not depend on
 the order the numbers are added in.
 timing: Time millisecondClockValue is Dolphin's millisecond clock. Dolphin's console has no
 stderr stream, so the contract's fallback applies and TIME_MS goes to time.txt in the working
 directory. Instrumented by inspection: Dolphin is not installed on this machine, so this
 row's timing is unverified."

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
	cr;
	close.

out nextPutAll: (total / 100000000.0) printString; cr; flush.
SessionManager current quit: 0!
