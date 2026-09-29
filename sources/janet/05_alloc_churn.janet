# task 05 alloc_churn — expected output: 1274991808
# build: none — `janet` compiles the script to bytecode and runs it on every invocation
# run: janet 05_alloc_churn.janet
# note: Janet's growable byte sequence is `buffer`, so the allocation primitive here is
#       `(buffer/new-filled 64 0)`, which allocates a fresh 64-byte buffer every iteration.
#       `(put buf 0 v)` writes the byte and `(in buf 0)` reads it back, the same thing the C
#       row does with buf[0].
# note: storing into slots keeps the buffer reachable and drops the one it replaces, which
#       is what makes the replaced buffer garbage for Janet's mark-sweep collector — the
#       same thing the C row's free(slots[slot]) does by hand. Without the store the whole
#       loop would be dead code.
# note: the total, 1274991808, stays inside 2^53, so it is exact.
(def slots (array/new-filled 256 nil))

(var total 0)

(for i 0 10000000
  (def buf (buffer/new-filled 64 0))
  (put buf 0 (% i 256))
  (+= total (in buf 0))
  (put slots (% i 256) buf))

(print total)
