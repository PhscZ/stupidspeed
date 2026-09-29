# task 11 parallel_sum — expected output: 7500000075000000
# build: none (interpreted)    run: ring 11_parallel_sum.ring
# note: Ring's core language has no thread keyword, but the distribution ships its own
#       Threads extension (load "threads.ring", a TinyCThread binding over Win32 threads),
#       and the VM has no global interpreter lock: each thread gets its own VM state that
#       shares the global scope, so four workers really run at the same time on four cores.
#       That is the exception README.md grants to a language whose standard library has no
#       threads, the same as Lua's Lanes and Tcl's Thread package.
# note: the partials cannot come back through thrd_join, whose result is a C int, and a
#       quarter of this task is about 1.9e15. Each worker instead writes its partial into its
#       own slot of a global list, which the shared global scope makes visible to the parent,
#       and the parent sums the four after joining. Distinct slots mean no lock is needed.
# note: the four ranges are fixed quarters, so the answer cannot depend on the order the
#       workers finish in.
# note: the light release does not ship the Threads extension at all — no ring_threads.dll, no
#       bin/load/threads.ring and no extensions/ringthreads/ — so the loader, the extension and
#       its bundled tinycthread were fetched from the v1.27 tag and the DLL was built with gcc
#       beside ring.exe. See BUILD.md.

load "threads.ring"

partial = list(4)

for t = 1 to 4
    partial[t] = 0
next

handles = list(4)
joined = 0

for t = 1 to 4
    handles[t] = new_thrd_t()
    thrd_create(handles[t], "work(" + t + ")")
next

for t = 1 to 4
    thrd_join(handles[t], :joined)
next

total = 0

for t = 1 to 4
    total = total + partial[t]
next

? total

func work t
    acc = 0
    lo = (t - 1) * 25000000
    hi = t * 25000000

    for i = lo to hi - 1
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

    partial[t] = acc
