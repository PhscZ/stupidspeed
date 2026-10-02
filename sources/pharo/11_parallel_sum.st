"task 11 parallel_sum — expected output: 7500000075000000
 build: none (image is prebuilt)    run: tools/pharo/PharoConsole.exe --headless tools/pharo/Pharo13.0-SNAPSHOT-64bit-d7c6f761d5.image st --quit --no-source 11_parallel_sum.st
 CAVEAT, the same one the Dolphin Smalltalk row records: Pharo's Process objects are
 GREEN. The VM multiplexes the whole image onto a single OS thread, so four forked
 workers interleave and never run at once. This cell is CORRECT-ANSWER-NO-SPEEDUP:
 it prints 7500000075000000 with no speedup over task 02. Every production Smalltalk
 is in this position; there is no OS-thread class in the image.
 Measured on this machine: the serial task-02 loop is 2714 ms and the same work as
 four forked Processes is 3037 ms, so the four workers are if anything slightly slower
 than the serial loop, not faster. `Processor` preempts them round-robin on the one VM
 thread; the `fork`/`Semaphore` machinery buys concurrency, never parallelism.
 The four ranges are fixed, so the total does not depend on the order they finish in.
 Each worker is an argumentless block wrapping a one-argument block, because `fork`
 takes no argument and the loop variable has to be captured by value. The Semaphore
 is the join: each worker signals it once and the parent waits four times."

| out results done total |
out := Stdio stdout.
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
			r = 0 ifTrue: [acc := acc + 1].
			r = 1 ifTrue: [acc := acc + i].
			r = 2 ifTrue: [acc := acc + (2 * i)].
			r = 3 ifTrue: [acc := acc + (3 * i)]].
		results at: id put: acc.
		done signal] value: t] fork].

4 timesRepeat: [done wait].

total := 0.
1 to: 4 do: [:t | total := total + (results at: t)].

out nextPutAll: total printString; lf; flush.
