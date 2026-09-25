"task 04 array_sum — expected output: 499999500000
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 04_array_sum.st -q
 An Array of SmallIntegers, filled and then read back in order."

| out arr total |
out := SessionManager current stdout.
arr := Array new: 1000000.

1 to: 1000000 do: [:i | arr at: i put: i - 1].

total := 0.
1 to: 1000000 do: [:i | total := total + (arr at: i)].

out nextPutAll: total printString; cr; flush.
SessionManager current quit: 0!
