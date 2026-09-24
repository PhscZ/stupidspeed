# task 05 alloc_churn — expected output: 1274991808
# build: none (interpreted)    run: nu main.nu
#
# nu has no byte buffers, so the closest analogue of a 64-byte buffer is a 64-element
# list, allocated fresh on every iteration and garbage collected when the slot that held
# it is overwritten. The 256 slots keep the last 256 buffers reachable, which is what
# stops the allocation from being dead code.

mut total = 0
mut slots = (0..255 | each {|_| [] })

for i in 0..9999999 {
    let buf = ((0..63 | each {|_| 0 }) | update 0 ($i mod 256))
    $total = $total + ($buf | get 0)
    $slots = ($slots | update ($i mod 256) $buf)
}

print $total
