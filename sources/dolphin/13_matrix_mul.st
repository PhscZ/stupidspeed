"task 13 matrix_mul — expected output: 599995000
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 13_matrix_mul.st -q
 Plain triple loop, no tricks: the innermost loop walks B down a column, which is the
 cache-hostile order the task asks for."

| out n a b c total |
out := SessionManager current stdout.
n := 500.
a := Array new: n.
b := Array new: n.
c := Array new: n.

1 to: n do: [:i |
	| ra rb |
	ra := Array new: n.
	rb := Array new: n.
	1 to: n do: [:j |
		ra at: j put: ((i - 1) + (j - 1)) \\ 7.
		rb at: j put: ((i - 1) * (j - 1)) \\ 5].
	a at: i put: ra.
	b at: i put: rb].

1 to: n do: [:i |
	| ra rc |
	ra := a at: i.
	rc := Array new: n.
	1 to: n do: [:j |
		| sum |
		sum := 0.
		1 to: n do: [:k |
			sum := sum + ((ra at: k) * ((b at: k) at: j))].
		rc at: j put: sum].
	c at: i put: rc].

total := 0.
1 to: n do: [:i |
	| rc |
	rc := c at: i.
	1 to: n do: [:j | total := total + (rc at: j)]].

out nextPutAll: total printString; cr; flush.
SessionManager current quit: 0!
