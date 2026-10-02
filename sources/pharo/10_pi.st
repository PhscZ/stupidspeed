"task 10 pi — expected output: 4470
 build: none (image is prebuilt)    run: tools/pharo/PharoConsole.exe --headless tools/pharo/Pharo13.0-SNAPSHOT-64bit-d7c6f761d5.image st --quit --no-source 10_pi.st
 Pharo's integers are arbitrary precision natively — LargePositiveInteger is a core
 class backed by LargeIntegers.dll — so this is the real Gibbons unbounded spigot on
 the library's own big integers, not hand-rolled base-1e9 limbs. Only the digit sum is
 printed. Note the update order in the produce branch: the next n is computed from q
 and r as they were on entry, before q and r move. `//` is integer division."

| out q r t k n l total emitted |
out := Stdio stdout.

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

out nextPutAll: total printString; lf; flush.
