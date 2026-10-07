"task 15 file_write — expected output: 52428800
 build: none (image is prebuilt)    run: tools/pharo/PharoConsole.exe --headless tools/pharo/Pharo13.0-SNAPSHOT-64bit-d7c6f761d5.image st --quit --no-source 15_file_write.st
 A 1 MiB buffer holding the byte cycle 0..255 repeated 4096 times, written 50 times
 to out.bin in the working directory through
 FileReference>>unbufferedBinaryWriteStream, so each nextPutAll: is one write and the
 1 MiB buffer is the buffering the task asks for. flush then sync then close:
 BinaryFileStream>>sync is Pharo's fsync, so the 50 MiB really is on the disk before
 the count is printed."

| out err buf w written t0 |
out := Stdio stdout.
err := Stdio stderr.
t0 := Time microsecondClockValue.

buf := ByteArray new: 1048576.
1 to: 1048576 do: [:i | buf at: i put: ((i - 1) \\ 256)].

w := 'out.bin' asFileReference unbufferedBinaryWriteStream.
written := 0.
1 to: 50 do: [:i |
	w nextPutAll: buf.
	written := written + 1048576].
w flush.
w sync.
w close.

err nextPutAll: 'TIME_MS=', ((Time microsecondClockValue - t0) / 1000.0) printString, String lf; flush.
out nextPutAll: written printString; lf; flush.
