"task 07 string_append — expected output: 250000
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 07_string_append.st -q
 Plain String concatenation, no growable stream: Dolphin's String is immutable, so
 every append copies the whole thing and the task is quadratic by design.
 timing: Time millisecondClockValue is Dolphin's millisecond clock. Dolphin's console has no
 stderr stream, so the contract's fallback applies and TIME_MS goes to time.txt in the working
 directory. Instrumented by inspection: Dolphin is not installed on this machine, so this
 row's timing is unverified."

| ssT0 out text |
ssT0 := Time millisecondClockValue.
out := SessionManager current stdout.
text := ''.

1 to: 250000 do: [:i | text := text , 'x'].

(FileWriteStream write: 'time.txt' type: #binary)
	nextPutAll: 'TIME_MS=', (Time millisecondClockValue - ssT0) printString;
	cr;
	close.

out nextPutAll: text size printString; cr; flush.
SessionManager current quit: 0!
