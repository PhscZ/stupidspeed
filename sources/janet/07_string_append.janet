# task 07 string_append — expected output: 250000
# build: none — `janet` compiles the script to bytecode and runs it on every invocation
# run: janet 07_string_append.janet
# note: Janet strings are immutable and `(string acc "x")` allocates a fresh buffer, copies
#       every argument into it, and then allocates the result string from that buffer, so
#       each append copies the accumulator twice. There is no string builder in the core
#       library — the mutable byte sequence is `buffer`, which would be a different
#       algorithm — so this loop is quadratic exactly as the spec intends, the same choice
#       the Racket row makes.
# note: `(length text)` is the printed value, so the loop cannot be deleted.
# note: this is the slowest cell in the row; see RUN.md for the measured cost.
(var text "")

(for i 0 250000
  (set text (string text "x")))

(print (length text))
