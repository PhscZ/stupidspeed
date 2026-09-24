# task 07 string_append — expected output: 1000000
# build: nim c -d:release -o:prog main.nim    run: ./prog
#
# `&` builds a new string, so every append copies the whole string (quadratic),
# which is what this task measures. `add` would grow the buffer in place instead.

var text = ""
for _ in 0 ..< 1_000_000:
  text = text & "x"
echo text.len
