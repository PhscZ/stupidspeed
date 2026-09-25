"task 10 pi — expected output: 44889
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 10_pi.st -q
 Dolphin's integers are arbitrary precision natively (LargePositiveInteger is a core
 class, and the VM has LargeIntPrim), so this is the real Gibbons unbounded spigot
 with no hand-rolled limbs. Only the digit sum is printed.
 Note the update order: the produce branch computes the next n from the q and r as
 they were on entry, before q and r move."

| out q r t k n l total emitted |
out := SessionManager current stdout.

q := 1. r := 0. t := 1. k := 1. n := 3. l := 3.
total := 0. emitted := 0.

[emitted < 10000] whileTrue: [
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

out nextPutAll: total printString; cr; flush.
SessionManager current quit: 0!
