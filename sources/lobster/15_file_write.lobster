// task 15 file_write — expected output: 52428800
// build: none (interpreted)    run: lobster 15_file_write.lobster   (writes out.bin in this directory)

// one 1 MiB chunk: the byte cycle 0..255 repeated 4096 times
let chunk = ensure_size("", 1048576, 0)
for(1048576) i:
    write_int8_le(chunk, i, i % 256)

// write_file creates/overwrites, it cannot append, so the 50 chunks are one 50 MiB string
let full = repeat_string(chunk, 50)
let written = if write_file("out.bin", full): full.length else: 0

print written
