"task 14 file_read — expected output: 2389704704
 build: none (image is prebuilt)    run: tools/pharo/PharoConsole.exe --headless tools/pharo/Pharo13.0-SNAPSHOT-64bit-d7c6f761d5.image st --quit --no-source 14_file_read.st
 data.bin must be in the working directory: 52428800 bytes, the bytes 0 through 255
 repeating. One pass in 1 MiB chunks through FileReference>>binaryReadStream (a
 ZnBufferedReadStream over the FileSystem's BinaryFileStream); `next: n` answers a
 ByteArray of up to n bytes and simply answers a short one at the end, so the loop
 stops on the empty chunk rather than on an exception."

| out err s buf total t0 |
out := Stdio stdout.
err := Stdio stderr.
t0 := Time microsecondClockValue.
s := 'data.bin' asFileReference binaryReadStream.
total := 0.

buf := s next: 1048576.
[buf notEmpty] whileTrue: [
	1 to: buf size do: [:i | total := total + (buf at: i)].
	buf := s next: 1048576].

s close.
err nextPutAll: 'TIME_MS=', ((Time microsecondClockValue - t0) / 1000.0) printString, String lf; flush.
out nextPutAll: (total \\ 4294967296) printString; lf; flush.
