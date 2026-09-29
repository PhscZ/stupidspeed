# task 06 char_count — expected output: 10000000
# build: none — `janet` compiles the script to bytecode and runs it on every invocation
# run: janet 06_char_count.janet
# note: `(string/repeat "abcdefghij" 10000000)` builds the whole hundred-million-character
#       string in one allocation, the block repeat the spec asks for, not an append loop.
# note: Janet strings are byte strings, so `(in text i)` returns the byte as an integer;
#       'h' is 104, 'a' is 97 and 'e' is 101. The C row counts only 'h' — 'a' and 'e' are
#       never matched — so this does the same, with the same if-test shape.
# note: the count, 10000000, is exact.
(def text (string/repeat "abcdefghij" 10000000))

(var count 0)
(def n (length text))

(for i 0 n
  (if (= (in text i) 104)
    (++ count)))

(print count)
