"task 01 branches — expected output: 33333334 13333333 7619048 45714285
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 01_branches.st -q
 Dolphin 8 is an interpreter with a JIT, and `SessionManager current stdout` is the
 headless console stream. Loop bounds are inclusive, as the task says: 0 to 99999999."

| out a b c d |
out := SessionManager current stdout.
a := 0. b := 0. c := 0. d := 0.

0 to: 99999999 do: [:i |
	(i \\ 3) == 0
		ifTrue: [a := a + 1]
		ifFalse: [
			(i \\ 5) == 0
				ifTrue: [b := b + 1]
				ifFalse: [
					(i \\ 7) == 0
						ifTrue: [c := c + 1]
						ifFalse: [d := d + 1]]]].

out
	nextPutAll: a printString, ' ', b printString, ' ', c printString, ' ', d printString;
	cr;
	flush.
SessionManager current quit: 0!
