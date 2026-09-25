"task 15 file_write — expected output: 104857600
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 15_file_write.st -q
 A 1 MiB buffer holding the byte cycle 0..255 repeated 4096 times, written 100 times.
 Dolphin has no fsync exposed on a write stream, so the deviation is flush + close,
 the same one the D, Julia, Nim, Dart, Pascal and COBOL rows note."

| out buf w written |
out := SessionManager current stdout.

buf := ByteArray new: 1048576.
1 to: 1048576 do: [:i | buf at: i put: ((i - 1) \\ 256)].

w := FileWriteStream write: 'out.bin' type: #binary.
written := 0.
1 to: 100 do: [:i |
	w nextPutAll: buf.
	written := written + 1048576].
w flush.
w close.

out nextPutAll: written printString; cr; flush.
SessionManager current quit: 0!
