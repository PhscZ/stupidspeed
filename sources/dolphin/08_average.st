"task 08 average — expected output: 0.498046875
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 08_average.st -q
 Float division throughout: `reading` is a Double, and the reading is a multiple of
 1/256, which is exact in binary, so the sum is exact and the digits do not depend on
 the order the numbers are added in."

| out total |
out := SessionManager current stdout.
total := 0.0.

0 to: 99999999 do: [:i |
	| reading |
	reading := (i \\ 256) / 256.0.
	total := total + reading].

out nextPutAll: (total / 100000000.0) printString; cr; flush.
SessionManager current quit: 0!
