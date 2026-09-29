# task 01 branches — expected output: 33333334 13333333 7619048 45714285
# build: none — `janet` compiles the script to bytecode and runs it on every invocation
# run: janet 01_branches.janet
# note: Janet has one numeric type, the IEEE 754 double, and `%`, `=`, `<` and `+=` compile
#       to single bytecode instructions (JOP_REMAINDER, JOP_EQUALS, ...), not function calls.
#       Every counter here stays far below 2^53, so all of it is exact.
# note: `cond` is the if/else-if/else chain; its last form is the else branch.
# note: `print` writes its arguments with no separator and appends one newline, so the four
#       counters are joined with explicit " " strings, the same line the C row prints.
(var a 0)
(var b 0)
(var c 0)
(var d 0)

(for i 0 100000000
  (cond
    (= 0 (% i 3)) (++ a)
    (= 0 (% i 5)) (++ b)
    (= 0 (% i 7)) (++ c)
    (++ d)))

(print a " " b " " c " " d)
