"task 12 matrix_add — expected output: 999000000
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 12_matrix_add.st -q
 Three 1000x1000 arrays, 24 MB together, too big to sit in cache. Rows are Arrays of
 Arrays, so each row is one contiguous object."

| out n a b c total |
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

out nextPutAll: total printString; cr; flush.
SessionManager current quit: 0!
