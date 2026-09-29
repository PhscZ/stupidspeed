# task 02 switch_case — expected output: 7500000075000000
# build: none (interpreted)    run: ring 02_switch_case.ring
# note: Ring's switch is written switch / on <value> / other / off; each on is a comparison
#       against the expression, so this is the same chain of tests the C row's switch makes.
# note: the total, 7500000075000000, is below 2^53, so it is held exactly in a double. The
#       engine prints integral values through a %lld path (ring_general_numtostring), which
#       was smoke-tested on this build: ? 7500000075000000 prints 7500000075000000 with no
#       decimal point and no exponent. Every integer cell in this row relies on that.

acc = 0

for i = 0 to 99999999
    switch i % 4
    on 0
        acc = acc + 1
    on 1
        acc = acc + i
    on 2
        acc = acc + 2 * i
    on 3
        acc = acc + 3 * i
    off
next

? acc
