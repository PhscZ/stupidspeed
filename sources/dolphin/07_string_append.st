"task 07 string_append — expected output: 250000
 build: none (image is prebuilt)    run: Dolphin8 DPRO.img8 -u -f 07_string_append.st -q
 Plain String concatenation, no growable stream: Dolphin's String is immutable, so
 every append copies the whole thing and the task is quadratic by design."

| out text |
out := SessionManager current stdout.
text := ''.

1 to: 250000 do: [:i | text := text , 'x'].

out nextPutAll: text size printString; cr; flush.
SessionManager current quit: 0!
