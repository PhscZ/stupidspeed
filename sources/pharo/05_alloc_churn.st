"task 05 alloc_churn — expected output: 1274991808
 build: none (image is prebuilt)    run: tools/pharo/PharoConsole.exe --headless tools/pharo/Pharo13.0-SNAPSHOT-64bit-d7c6f761d5.image st --quit --no-source 05_alloc_churn.st
 Ten million 64-byte ByteArrays, each one stored into a 256-slot ring so it stays
 reachable and the one it replaces becomes garbage. Pharo's scavenger reclaims the
 dead buffers; the ring keeps the allocation itself from being optimised away."

| out slots total |
out := Stdio stdout.
slots := Array new: 256.
total := 0.

0 to: 9999999 do: [:i |
	| buf idx |
	buf := ByteArray new: 64.
	idx := i \\ 256.
	buf at: 1 put: idx.
	total := total + (buf at: 1).
	slots at: idx + 1 put: buf].

out nextPutAll: total printString; lf; flush.
