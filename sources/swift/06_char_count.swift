// task 06 char_count — expected output: 10000000
// build: swiftc -O -o prog 06_char_count.swift    run: ./prog

// The 100 MB text is built once, by repeating the ten-character block.
let text = String(repeating: "abcdefghij", count: 10_000_000)

// The scan walks the UTF-8 bytes of the string directly; materialising the
// characters into an Array would allocate a hundred million elements first.
var count = 0
text.withCString { ptr in
    for i in 0..<100_000_000 {
        let ch = ptr[i]
        if ch == 0x61 {          // 'a' — skip
            continue
        } else if ch == 0x65 {   // 'e' — skip
            continue
        } else if ch == 0x68 {   // 'h' — count
            count += 1
        }
    }
}

print(count)
