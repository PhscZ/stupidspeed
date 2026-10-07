"task 06 char_count — expected output: 10000000
 build: none (image is prebuilt)    run: tools/pharo/PharoConsole.exe --headless tools/pharo/Pharo13.0-SNAPSHOT-64bit-d7c6f761d5.image st --quit --no-source 06_char_count.st
 The 100 MB text is built by filling a pre-sized ByteString with the 10000-byte block
 10000 times through replaceFrom:to:with:startingAt: (primitive 105), not by
 appending, so the build is not the benchmark. Then it is scanned one character at a
 time. `String` in Pharo is ByteString, so the characters are single bytes."

| out err block text count t0 |
out := Stdio stdout.
err := Stdio stderr.
t0 := Time microsecondClockValue.

block := String new: 10000.
1 to: 1000 do: [:k |
	block
		replaceFrom: (k - 1) * 10 + 1
		to: k * 10
		with: 'abcdefghij'
		startingAt: 1].

text := String new: 100000000.
1 to: 10000 do: [:k |
	text
		replaceFrom: (k - 1) * 10000 + 1
		to: k * 10000
		with: block
		startingAt: 1].

count := 0.
1 to: 100000000 do: [:i |
	| ch |
	ch := text at: i.
	ch = $a
		ifFalse: [
			ch = $e
				ifFalse: [ch = $h ifTrue: [count := count + 1]]]].

err nextPutAll: 'TIME_MS=', ((Time microsecondClockValue - t0) / 1000.0) printString, String lf; flush.
out nextPutAll: count printString; lf; flush.
