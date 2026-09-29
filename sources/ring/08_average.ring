# task 08 average — expected output: 0.498046875
# build: none (interpreted)    run: ring 08_average.ring
# note: decimals(9) is set before the print because Ring's default is 2 decimals, which
#       would round the answer to 0.50. decimals() only affects the non-integral branch of
#       the number-to-string conversion, so the integer cells in this row are unaffected.
# note: i % 256 and the division by 256.0 are double operations, like the C row's; the total
#       is a double from the start.

total = 0.0

for i = 0 to 99999999
    reading = (i % 256) / 256.0
    total = total + reading
next

decimals(9)
? total / 100000000
