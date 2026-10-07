"task 04 array_sum — expected output: 499999500000
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 04_array_sum.st -q
 An Array of SmallIntegers, filled and then read back in order.
 timing: Time millisecondClockValue is Dolphin's millisecond clock. Dolphin's console has no
 stderr stream, so the contract's fallback applies and TIME_MS goes to time.txt in the working
 directory. Built and run against Dolphin 8.2.3 on this machine, so the timing is real.
 The time.txt write uses nextPut: 10 instead of cr: cr on a file stream hangs the VM,
 while nextPut: 10 writes the newline byte and the run completes."

| ssT0 out arr total |
ssT0 := Time millisecondClockValue.
out := SessionManager current stdout.
arr := Array new: 1000000.

1 to: 1000000 do: [:i | arr at: i put: i - 1].

total := 0.
1 to: 1000000 do: [:i | total := total + (arr at: i)].

(FileWriteStream write: 'time.txt' type: #binary)
	nextPutAll: 'TIME_MS=', (Time millisecondClockValue - ssT0) printString;
	nextPut: 10;
	close.

out nextPutAll: total printString; cr; flush.
SessionManager current quit: 0!
