"task 01 branches — expected output: 33333334 13333333 7619048 45714285
 build: none (image is prebuilt)    run: tools/pharo/PharoConsole.exe --headless tools/pharo/Pharo13.0-SNAPSHOT-64bit-d7c6f761d5.image st --quit --no-source 01_branches.st
 The run command is issued from this directory with the toolchain paths relative to the
 repository root, the convention the other rows use.
 `--headless`, `st --quit` and `--no-source` are all load-bearing. Without --headless
 the VM opens a window and never returns. `st` on its own evaluates the file and then
 leaves the image running; --quit exits without saving, so the .image file is never
 rewritten. --no-source stops the handler logging each do-it into the shared
 Pharo13.0-SNAPSHOT-64bit-d7c6f761d5.changes file, which it otherwise appends to on
 every run: with it, a run touches nothing outside the working directory. The output
 stream is Stdio stdout, the headless console.
 The loop is `0 to: 99999999 do:`, which Pharo's compiler turns into a counted loop
 rather than materialising a collection."

| out err a b c d t0 |
out := Stdio stdout.
err := Stdio stderr.
t0 := Time microsecondClockValue.
a := 0. b := 0. c := 0. d := 0.

0 to: 99999999 do: [:i |
	(i \\ 3) = 0
		ifTrue: [a := a + 1]
		ifFalse: [
			(i \\ 5) = 0
				ifTrue: [b := b + 1]
				ifFalse: [
					(i \\ 7) = 0
						ifTrue: [c := c + 1]
						ifFalse: [d := d + 1]]]].

err nextPutAll: 'TIME_MS=', ((Time microsecondClockValue - t0) / 1000.0) printString, String lf; flush.
out
	nextPutAll: a printString, ' ', b printString, ' ', c printString, ' ', d printString;
	lf;
	flush.
