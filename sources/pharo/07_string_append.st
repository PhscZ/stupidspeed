"task 07 string_append — expected output: 250000
 build: none (image is prebuilt)    run: tools/pharo/PharoConsole.exe --headless tools/pharo/Pharo13.0-SNAPSHOT-64bit-d7c6f761d5.image st --quit --no-source 07_string_append.st
 Plain String concatenation, no growable stream. A Pharo String is immutable, so
 every `,` allocates a fresh string and copies the whole receiver: the task is
 quadratic by design, exactly as the Ruby row notes for String#+ (a WriteStream would
 grow in place and is deliberately not used)."

| out text |
out := Stdio stdout.
text := ''.

1 to: 250000 do: [:i | text := text , 'x'].

out nextPutAll: text size printString; lf; flush.
