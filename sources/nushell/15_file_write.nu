# task 15 file_write — expected output: 104857600
# build: none (interpreted)    run: nu 15_file_write.nu
#
# The 1 MiB buffer is the byte values 0,1,2,...,255 repeated 4096 times, built once from
# `into binary --compact` + `bytes collect` and then written 100 times with `save -a`
# (append). nu's `save` flushes and closes the file but offers no fsync, so there is no
# fsync here; the printed count is the buffer length times the number of writes.

let block = (0..255 | each {|b| $b | into binary --compact } | bytes collect)
let buffer = (1..4096 | each {|_| $block } | bytes collect)

for i in 0..99 {
    $buffer | save --append out.bin
}

print (($buffer | bytes length) * 100)
