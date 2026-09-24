// task 07 string_append — expected output: 1000000
// build: swiftc -O -o prog main.swift    run: ./prog

// Plain Swift string concatenation: `text + "x"` builds a new String value.
var text = ""
for _ in 0..<1_000_000 {
    text = text + "x"
}

// The string is pure ASCII, so the UTF-8 count is the length without walking it
// grapheme by grapheme.
print(text.utf8.count)
