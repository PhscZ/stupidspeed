"task 10 pi — expected output: 4470
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 10_pi.st -q
 Dolphin's integers are arbitrary precision natively (LargePositiveInteger is a core
 class, and the VM has LargeIntPrim), so this is the real Gibbons unbounded spigot
 with no hand-rolled limbs. Only the digit sum is printed.
 Note the update order: the produce branch computes the next n from the q and r as
 they were on entry, before q and r move.
 timing: Time millisecondClockValue is Dolphin's millisecond clock. Dolphin's console has no
 stderr stream, so the contract's fallback applies and TIME_MS goes to time.txt in the working
 directory. Built and run against Dolphin 8.2.3 on this machine, so the timing is real.
 The time.txt write uses nextPut: 10 instead of cr: cr on a file stream hangs the VM,
 while nextPut: 10 writes the newline byte and the run completes."

| ssT0 out q r t k n l total emitted |
ssT0 := Time millisecondClockValue.
out := SessionManager current stdout.

q := 1. r := 0. t := 1. k := 1. n := 3. l := 3.
total := 0. emitted := 0.

[emitted < 1000] whileTrue: [
	(4 * q + r - t) < (n * t)
		ifTrue: [
			| nextn |
			total := total + n.
			emitted := emitted + 1.
			nextn := (10 * (3 * q + r)) // t - (10 * n).
			q := 10 * q.
			r := 10 * (r - (n * t)).
			n := nextn]
		ifFalse: [
			| q2 r2 t2 |
			q2 := q * k.
			r2 := (2 * q + r) * l.
			t2 := t * l.
			n := (q * (7 * k + 2) + (r * l)) // t2.
			q := q2.
			r := r2.
			t := t2.
			k := k + 1.
			l := l + 2]].

(FileWriteStream write: 'time.txt' type: #binary)
	nextPutAll: 'TIME_MS=', (Time millisecondClockValue - ssT0) printString;
	nextPut: 10;
	close.

out nextPutAll: total printString; cr; flush.
SessionManager current quit: 0!
