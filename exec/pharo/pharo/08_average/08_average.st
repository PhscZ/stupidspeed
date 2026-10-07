"task 08 average — expected output: 0.498046875
 build: none (image is prebuilt)    run: tools/pharo/PharoConsole.exe --headless tools/pharo/Pharo13.0-SNAPSHOT-64bit-d7c6f761d5.image st --quit --no-source 08_average.st
 Float division throughout: `256.0` makes the quotient a Double (Pharo would answer a
 Fraction for an all-integer `/`). Every reading is a multiple of 1/256, which is
 exact in binary, so the sum is exact and the digits do not depend on the order the
 numbers are added in. Float printString answers the shortest round-tripping form,
 which for this value is 0.498046875."

| out err total t0 |
out := Stdio stdout.
err := Stdio stderr.
t0 := Time microsecondClockValue.
total := 0.0.

0 to: 99999999 do: [:i |
	| reading |
	reading := (i \\ 256) / 256.0.
	total := total + reading].

err nextPutAll: 'TIME_MS=', ((Time microsecondClockValue - t0) / 1000.0) printString, String lf; flush.
out nextPutAll: (total / 100000000.0) printString; lf; flush.
