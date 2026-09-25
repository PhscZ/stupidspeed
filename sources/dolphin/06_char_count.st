"task 06 char_count — expected output: 10000000
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 06_char_count.st -q
 The 100 MB text is built by repeating the whole 10000-byte block 10000 times with
 replaceFrom:to:with:startingAt:, not by appending, so the build is not the benchmark.
 Then it is scanned one character at a time."

| out text block count |
out := SessionManager current stdout.

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
	ch == $a
		ifFalse: [
			ch == $e
				ifFalse: [ch == $h ifTrue: [count := count + 1]]]].

out nextPutAll: count printString; cr; flush.
SessionManager current quit: 0!
