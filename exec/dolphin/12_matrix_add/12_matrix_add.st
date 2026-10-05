"task 12 matrix_add — expected output: 999000000
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 12_matrix_add.st -q
 Three 1000x1000 arrays, 24 MB together, too big to sit in cache. Rows are Arrays of
 Arrays, so each row is one contiguous object.
 timing: Time millisecondClockValue is Dolphin's millisecond clock. Dolphin's console has no
 stderr stream, so the contract's fallback applies and TIME_MS goes to time.txt in the working
 directory. Built and run against Dolphin 8.2.3 on this machine, so the timing is real.
 The time.txt write uses nextPut: 10 instead of cr: cr on a file stream hangs the VM,
 while nextPut: 10 writes the newline byte and the run completes."

| ssT0 out n a b c total |
ssT0 := Time millisecondClockValue.
out := SessionManager current stdout.
n := 1000.
a := Array new: n.
b := Array new: n.
c := Array new: n.

1 to: n do: [:i |
	| ra rb |
	ra := Array new: n.
	rb := Array new: n.
	1 to: n do: [:j |
		ra at: j put: (i - 1) + (j - 1).
		rb at: j put: (i - 1) - (j - 1)].
	a at: i put: ra.
	b at: i put: rb].

1 to: n do: [:i |
	| ra rb rc |
	ra := a at: i.
	rb := b at: i.
	rc := Array new: n.
	1 to: n do: [:j | rc at: j put: (ra at: j) + (rb at: j)].
	c at: i put: rc].

total := 0.
1 to: n do: [:i |
	| rc |
	rc := c at: i.
	1 to: n do: [:j | total := total + (rc at: j)]].

(FileWriteStream write: 'time.txt' type: #binary)
	nextPutAll: 'TIME_MS=', (Time millisecondClockValue - ssT0) printString;
	nextPut: 10;
	close.

out nextPutAll: total printString; cr; flush.
SessionManager current quit: 0!
