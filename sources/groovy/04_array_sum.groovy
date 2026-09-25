// task 04 array_sum — expected output: 499999500000
// build: none (interpreted)    run: groovy 04_array_sum.groovy
// long[] is a real primitive array, so this walks contiguous 8-byte memory.

long[] arr = new long[1000000]
for (int i = 0; i < 1000000; i++) {
    arr[i] = i
}

long total = 0
for (int i = 0; i < 1000000; i++) {
    total += arr[i]
}

println total
