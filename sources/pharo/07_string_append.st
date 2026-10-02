"task 07 string_append — expected output: 1000000
 build: none (image is prebuilt)    run: tools/pharo/PharoConsole.exe --headless tools/pharo/Pharo13.0-SNAPSHOT-64bit-d7c6f761d5.image st --quit --no-source 07_string_append.st
 Plain String concatenation, no growable stream. A Pharo String is immutable, so
 every `,` allocates a fresh string and copies the whole receiver: the task is
 quadratic by design, exactly as the Ruby row notes for String#+ (a WriteStream would
 grow in place and is deliberately not used). The cost is load-dependent: small-N scaling
 (20000 appends 1.58 s, 40000 appends 2.59 s) fits 1249 ms + 8.375e-7*N^2, which predicts
 ~839 s, about 14 minutes, on an idle host; a clean-state run that overlapped the other
 quadratic cell in this batch measured 3703 s. Treat ~14-60 minutes as the range."

| out text |
out := Stdio stdout.
text := ''.

1 to: 1000000 do: [:i | text := text , 'x'].

out nextPutAll: text size printString; lf; flush.
