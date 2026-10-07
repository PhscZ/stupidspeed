"task 15 file_write — expected output: 52428800
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 15_file_write.st -q
 A 1 MiB buffer holding the byte cycle 0..255 repeated 4096 times, written 50 times.
 Dolphin has no fsync exposed on a write stream, so the deviation is flush + close,
 the same one the D, Julia, Nim, Dart, Pascal and COBOL rows note.
 timing: Time millisecondClockValue is Dolphin's millisecond clock. Dolphin's console has no
 stderr stream, so the contract's fallback applies and TIME_MS goes to time.txt in the working
 directory. Built and run against Dolphin 8.2.3 on this machine, so the timing is real.
 The time.txt write uses nextPut: 10 instead of cr: cr on a file stream hangs the VM,
 while nextPut: 10 writes the newline byte and the run completes."

| ssT0 out buf w written |
ssT0 := Time millisecondClockValue.
out := SessionManager current stdout.

buf := ByteArray new: 1048576.
1 to: 1048576 do: [:i | buf at: i put: ((i - 1) \\ 256)].

w := FileWriteStream write: 'out.bin' type: #binary.
written := 0.
1 to: 50 do: [:i |
	w nextPutAll: buf.
	written := written + 1048576].
w flush.
w close.

(FileWriteStream write: 'time.txt' type: #binary)
	nextPutAll: 'TIME_MS=', (Time millisecondClockValue - ssT0) printString;
	nextPut: 10;
	close.

out nextPutAll: written printString; cr; flush.
SessionManager current quit: 0!
