# task 04 array_sum — expected output: 499999500000
# build: none (interpreted)    run: ring 04_array_sum.ring
# note: list(n) allocates the million slots up front, the way the C row's malloc does. A
#       Ring list item is a full Item, not a machine word, so this is a million boxed
#       doubles rather than a million int64s; the algorithm is the same either way.
# note: Ring lists are 1-based, so a[i] holds the value i-1 and the sum is still 0..999999.

n = 1000000
a = list(n)

for i = 1 to n
    a[i] = i - 1
next

total = 0

for i = 1 to n
    total = total + a[i]
next

? total
