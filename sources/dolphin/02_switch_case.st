"task 02 switch_case — expected output: 7500000075000000
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 02_switch_case.st -q
 The four-way decision is a nested ifTrue:ifFalse: chain, which is what Dolphin
 compiles a switch into anyway; the branch on i \\ 4 is the same predicate.
 timing: Time millisecondClockValue is Dolphin's millisecond clock. Dolphin's console has no
 stderr stream, so the contract's fallback applies and TIME_MS goes to time.txt in the working
 directory. Instrumented by inspection: Dolphin is not installed on this machine, so this
 row's timing is unverified."

| ssT0 out acc |
ssT0 := Time millisecondClockValue.
out := SessionManager current stdout.
acc := 0.

0 to: 99999999 do: [:i |
	| r |
	r := i \\ 4.
	r == 0 ifTrue: [acc := acc + 1].
	r == 1 ifTrue: [acc := acc + i].
	r == 2 ifTrue: [acc := acc + (2 * i)].
	r == 3 ifTrue: [acc := acc + (3 * i)]].

(FileWriteStream write: 'time.txt' type: #binary)
	nextPutAll: 'TIME_MS=', (Time millisecondClockValue - ssT0) printString;
	cr;
	close.

out nextPutAll: acc printString; cr; flush.
SessionManager current quit: 0!
