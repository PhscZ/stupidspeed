"task 04 array_sum — expected output: 499999500000
 build: none (image is prebuilt)    run: tools/pharo/PharoConsole.exe --headless tools/pharo/Pharo13.0-SNAPSHOT-64bit-d7c6f761d5.image st --quit --no-source 04_array_sum.st
 An Array of a million SmallIntegers, filled and then read back in order. Array is
 Pharo's fixed-size indexable collection of object pointers; the integers themselves
 are tagged immediates, so the walk is over one contiguous run of slots."

| out arr total |
out := Stdio stdout.
arr := Array new: 1000000.

1 to: 1000000 do: [:i | arr at: i put: i - 1].

total := 0.
1 to: 1000000 do: [:i | total := total + (arr at: i)].

out nextPutAll: total printString; lf; flush.
