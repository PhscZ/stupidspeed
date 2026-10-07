"task 07 string_append — expected output: 250000
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 07_string_append.st -q
 Plain String concatenation, no growable stream: Dolphin's String is immutable, so
 every append copies the whole thing and the task is quadratic by design.
 timing: Time millisecondClockValue is Dolphin's millisecond clock. Dolphin's console has no
 stderr stream, so the contract's fallback applies and TIME_MS goes to time.txt in the working
 directory. Built and run against Dolphin 8.2.3 on this machine, so the timing is real.
 The time.txt write uses nextPut: 10 instead of cr: cr on a file stream hangs the VM,
 while nextPut: 10 writes the newline byte and the run completes."

| ssT0 out text |
ssT0 := Time millisecondClockValue.
out := SessionManager current stdout.
text := ''.

1 to: 250000 do: [:i | text := text , 'x'].

(FileWriteStream write: 'time.txt' type: #binary)
	nextPutAll: 'TIME_MS=', (Time millisecondClockValue - ssT0) printString;
	nextPut: 10;
	close.

out nextPutAll: text size printString; cr; flush.
SessionManager current quit: 0!
