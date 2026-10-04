"task 14 file_read — expected output: 2389704704
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 14_file_read.st -q
 One pass over 50 MiB in 1 MiB chunks. nextAvailable: answers as many bytes as are
 left rather than raising at the end, which is why it is used here and not next:.
 timing: Time millisecondClockValue is Dolphin's millisecond clock. Dolphin's console has no
 stderr stream, so the contract's fallback applies and TIME_MS goes to time.txt in the working
 directory. Instrumented by inspection: Dolphin is not installed on this machine, so this
 row's timing is unverified."

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
	cr;
	close.

out nextPutAll: (total \\ 4294967296) printString; cr; flush.
SessionManager current quit: 0!
