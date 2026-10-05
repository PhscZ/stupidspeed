"task 14 file_read — expected output: 2389704704
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 14_file_read.st -q
 One pass over 50 MiB in 1 MiB chunks. nextAvailable: answers as many bytes as are
 left rather than raising at the end, which is why it is used here and not next:.
 timing: Time millisecondClockValue is Dolphin's millisecond clock. Dolphin's console has no
 stderr stream, so the contract's fallback applies and TIME_MS goes to time.txt in the working
 directory. Built and run against Dolphin 8.2.3 on this machine, so the timing is real.
 The time.txt write uses nextPut: 10 instead of cr: cr on a file stream hangs the VM,
 while nextPut: 10 writes the newline byte and the run completes."

| ssT0 out s buf total |
ssT0 := Time millisecondClockValue.
out := SessionManager current stdout.
s := FileStream read: 'data.bin' type: #binary.
total := 0.

buf := s nextAvailable: 1048576.
[buf notEmpty] whileTrue: [
	1 to: buf size do: [:i | total := total + (buf at: i)].
	buf := s nextAvailable: 1048576].

s close.
(FileWriteStream write: 'time.txt' type: #binary)
	nextPutAll: 'TIME_MS=', (Time millisecondClockValue - ssT0) printString;
	nextPut: 10;
	close.

out nextPutAll: (total \\ 4294967296) printString; cr; flush.
SessionManager current quit: 0!
