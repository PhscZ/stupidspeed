# task 07 string_append — expected output: 250000
# build: none (interpreted)    run: ring 07_string_append.ring
# note: this is the spec's text = text + "x" form, and it is quadratic in Ring: + appends
#       the right operand into a copy of the left one, and the assignment then copies that
#       result back into the variable, so every one of the 250000 iterations copies the
#       whole accumulated string twice.
# note: Ring's += operator is deliberately NOT used. += appends straight into the variable's
#       own string object, which doubles its capacity as needed (Ring's own release notes
#       advertise it as 60x faster than the old behaviour). Using it would turn this cell
#       into a linear one and would not be the task the other rows run.
# note: see RUN.md for the measured cost of this cell.

text = ""

for i = 1 to 250000
    text = text + "x"
next

? len(text)
