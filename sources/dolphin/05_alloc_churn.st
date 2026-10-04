"task 05 alloc_churn — expected output: 1274991808
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 05_alloc_churn.st -q
 Ten million 64-byte ByteArrays. Dolphin's memory manager has no garbage collector in
 the Java sense; it uses reference counting, so the slot store frees the buffer it
 replaces immediately, which is the 'free the old one' branch of the C reference.
 timing: Time millisecondClockValue is Dolphin's millisecond clock. Dolphin's console has no
 stderr stream, so the contract's fallback applies and TIME_MS goes to time.txt in the working
 directory. Instrumented by inspection: Dolphin is not installed on this machine, so this
 row's timing is unverified."

| ssT0 out slots total |
ssT0 := Time millisecondClockValue.
out := SessionManager current stdout.
slots := Array new: 256.
total := 0.

0 to: 9999999 do: [:i |
	| buf |
	buf := ByteArray new: 64.
	buf at: 1 put: (i \\ 256).
	total := total + (buf at: 1).
	slots at: (i \\ 256) + 1 put: buf].

(FileWriteStream write: 'time.txt' type: #binary)
	nextPutAll: 'TIME_MS=', (Time millisecondClockValue - ssT0) printString;
	cr;
	close.

out nextPutAll: total printString; cr; flush.
SessionManager current quit: 0!
