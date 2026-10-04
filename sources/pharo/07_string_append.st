"task 07 string_append — expected output: 250000
 build: none (image is prebuilt)    run: tools/pharo/PharoConsole.exe --headless tools/pharo/Pharo13.0-SNAPSHOT-64bit-d7c6f761d5.image st --quit --no-source 07_string_append.st
 Plain String concatenation, no growable stream. A Pharo String is immutable, so
 every `,` allocates a fresh string and copies the whole receiver: the task is
 quadratic by design, exactly as the Ruby row notes for String#+ (a WriteStream would
 grow in place and is deliberately not used)."

| out err text t0 |
out := Stdio stdout.
err := Stdio stderr.
t0 := Time microsecondClockValue.
text := ''.

1 to: 250000 do: [:i | text := text , 'x'].

err nextPutAll: 'TIME_MS=', ((Time microsecondClockValue - t0) / 1000.0) printString, String lf; flush.
out nextPutAll: text size printString; lf; flush.
