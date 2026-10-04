"task 02 switch_case — expected output: 7500000075000000
 build: none (image is prebuilt)    run: tools/pharo/PharoConsole.exe --headless tools/pharo/Pharo13.0-SNAPSHOT-64bit-d7c6f761d5.image st --quit --no-source 02_switch_case.st
 Smalltalk has no switch statement, so the four-way decision is the ifTrue: chain the
 compiler would lower a case dispatch into anyway. `\\` is integer remainder.
 Every intermediate value fits in a 64-bit Spur SmallInteger, so nothing is promoted
 to a boxed LargePositiveInteger: 3 * 99999999 is 3e8 and the running total is 7.5e15,
 both under 2^60."

| out err acc t0 |
out := Stdio stdout.
err := Stdio stderr.
t0 := Time microsecondClockValue.
acc := 0.

0 to: 99999999 do: [:i |
	| r |
	r := i \\ 4.
	r = 0 ifTrue: [acc := acc + 1].
	r = 1 ifTrue: [acc := acc + i].
	r = 2 ifTrue: [acc := acc + (2 * i)].
	r = 3 ifTrue: [acc := acc + (3 * i)]].

err nextPutAll: 'TIME_MS=', ((Time microsecondClockValue - t0) / 1000.0) printString, String lf; flush.
out nextPutAll: acc printString; lf; flush.
