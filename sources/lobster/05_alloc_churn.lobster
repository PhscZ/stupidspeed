// task 05 alloc_churn — expected output: 1274991808
// build: none (interpreted)    run: lobster 05_alloc_churn.lobster
//
// A 64-byte buffer is a class of eight 64-bit int fields; each iteration allocates
// one and overwrites the slot 256 iterations back, releasing the buffer it replaces.

class Buf:
    a:int
    b:int
    c:int
    d:int
    e:int
    f:int
    g:int
    h:int

let slots = []
for(256):
    push(slots, nil)

var total = 0
for(10000000) i:
    let buf = Buf { 0, 0, 0, 0, 0, 0, 0, 0 }
    buf.a = i % 256
    total += buf.a
    slots[i % 256] = buf

print total
