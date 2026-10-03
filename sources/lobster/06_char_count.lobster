// task 06 char_count — expected output: 10000000
// build: none (interpreted)    run: lobster 06_char_count.lobster

let block = "abcdefghij"
let text = ensure_size("", 100000000, 0)

for(10000000) i:
    write_substring(text, i * 10, block, 0)

var count = 0
for text:
    if _ == 'h':
        count += 1

print count
