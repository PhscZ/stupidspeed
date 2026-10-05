"task 11 parallel_sum — expected output: 7500000075000000
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 11_parallel_sum.st -q
 CAVEAT, and it is the same one CPython and CRuby carry: Dolphin's Process objects are
 green. The VM schedules them on one OS thread, so this buys concurrency, never
 parallelism, and it prints the right answer with no speedup over task 02. Every
 production Smalltalk is in this position; there is no OS-thread class in the image.
 The four ranges are fixed, so the total does not depend on the order they finish in.
 Each worker is an argumentless block wrapping a one-argument block, because `fork`
 takes no argument and the loop variable has to be captured by value.
 timing: Time millisecondClockValue is Dolphin's millisecond clock. Dolphin's console has no
 stderr stream, so the contract's fallback applies and TIME_MS goes to time.txt in the working
 directory. Built and run against Dolphin 8.2.3 on this machine, so the timing is real.
 The time.txt write uses nextPut: 10 instead of cr: cr on a file stream hangs the VM,
 while nextPut: 10 writes the newline byte and the run completes."

| ssT0 out results done total |
ssT0 := Time millisecondClockValue.
out := SessionManager current stdout.
results := Array new: 4.
done := Semaphore new.

1 to: 4 do: [:t |
	[[:id |
		| start stop acc |
		start := (id - 1) * 25000000.
		stop := id * 25000000 - 1.
		acc := 0.
		start to: stop do: [:i |
			| r |
			r := i \\ 4.
			r == 0 ifTrue: [acc := acc + 1].
			r == 1 ifTrue: [acc := acc + i].
			r == 2 ifTrue: [acc := acc + (2 * i)].
			r == 3 ifTrue: [acc := acc + (3 * i)]].
		results at: id put: acc.
		done signal] value: t] fork].

4 timesRepeat: [done wait].

total := 0.
1 to: 4 do: [:t | total := total + (results at: t)].

(FileWriteStream write: 'time.txt' type: #binary)
	nextPutAll: 'TIME_MS=', (Time millisecondClockValue - ssT0) printString;
	nextPut: 10;
	close.

out nextPutAll: total printString; cr; flush.
SessionManager current quit: 0!
