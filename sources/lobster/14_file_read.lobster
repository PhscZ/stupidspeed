// task 14 file_read — expected output: 2389704704
// build: none (interpreted)    run: lobster 14_file_read.lobster   (from this directory, with data.bin beside it)

let data = assert read_file("data.bin")

var total = 0
for data:
    total += _

print total % 4294967296
