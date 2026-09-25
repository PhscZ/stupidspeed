// task 06 char_count — expected output: 10000000
// build: none (interpreted)    run: groovy 06_char_count.groovy
// The 100 MB text is built once by repeating the whole block, then scanned one
// character at a time.

String text = 'abcdefghij' * 10000000
long count = 0

for (int i = 0; i < text.length(); i++) {
    char ch = text.charAt(i)
    if (ch == 'a') {
        // skip
    } else if (ch == 'e') {
        // skip
    } else if (ch == 'h') {
        count += 1
    }
}

println count
