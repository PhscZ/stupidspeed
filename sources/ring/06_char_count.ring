# task 06 char_count — expected output: 10000000
# build: none (interpreted)    run: ring 06_char_count.ring
# note: copy("abcdefghij", 10000000) builds the whole 100000000-character text in one call,
#       which is the block repeat the spec asks for rather than an append loop.
# note: for ch in text walks the string one character at a time and hands back a fresh
#       1-character string per step, the analogue of the C row's char.
# note: Ring has no continue, so 'a' and 'e' are handled by empty branches of the same
#       if/elseif chain — the same control flow the C row's continue produces.

text = copy("abcdefghij", 10000000)
count = 0

for ch in text
    if ch = "a"
    elseif ch = "e"
    elseif ch = "h"
        count = count + 1
    ok
next

? count
