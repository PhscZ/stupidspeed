"task 14 file_read — expected output: 484442112
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 14_file_read.st -q
 One pass over 100 MiB in 1 MiB chunks. nextAvailable: answers as many bytes as are
 left rather than raising at the end, which is why it is used here and not next:."

| out s buf total |
out := SessionManager current stdout.
s := FileStream read: 'data.bin' type: #binary.
total := 0.

buf := s nextAvailable: 1048576.
[buf notEmpty] whileTrue: [
	1 to: buf size do: [:i | total := total + (buf at: i)].
	buf := s nextAvailable: 1048576].

s close.
out nextPutAll: (total \\ 4294967296) printString; cr; flush.
SessionManager current quit: 0!
