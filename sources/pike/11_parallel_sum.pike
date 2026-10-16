// task 11 parallel_sum — expected output: 8748000081000000
// build: none (interpreted)    run: pike 11_parallel_sum.pike (Pike 8.0.1956 win32)
// Pike compiles the program to its own bytecode every time it is started, but that compile
// runs before the first statement of the program, so it is outside the measured region --
// exactly as in the lua row, where the timer is the first executed statement.  What the
// timer brackets is the task's own work and nothing else.  The interpreter is the official
// Pike 8.0.1956 win32 MSI build plus the four-byte CPUID stack fix in
// tools/pike/patch_pike.py; see exec/pike/build_all.bat.
//
// CORRECT-ANSWER-NO-SPEEDUP CELL.  The loop is serialised by Pike's global interpreter lock;
// it is not merely "not faster".
//
// Thread.Thread is Pike's own thread class and one Thread is one real OS thread (the build
// info says "threads............. yes (nt)"), so this is not a green-thread fake.  But Pike
// takes a global interpreter lock around bytecode execution -- pike_low_lock_interpreter,
// called in the thread-farm init before main() runs -- so only one thread is ever inside
// Pike code at a time and the four loops are executed one after another, in any order.  The
// cell is correct, uses real OS threads, and cannot be faster than one thread, because the
// runtime serialises them.
//
// Measured on this machine with tools/pike/thrtest.pike, which runs the same
// 50M-iteration integer loop once and then four times in four threads:
//
//     1 thread :  3040.9 ms
//     4 threads: 11906.9 ms      -> 0.26x, i.e. 1/3.9, i.e. exactly 4x one thread
//
// In the full run the same fact shows from the other side: this task matches task 02 almost
// exactly (11_parallel_sum 110547 ms vs 02_switch_case 155900 ms for identical work), so the
// four threads buy nothing over doing the work serially.
//
// (The large absolute numbers have a second cause that is also a property of this build:
// the info file says "int type............ long (4 bytes)", so `acc` overflows 32 bits
// partway through and Pike promotes it to a Gmp.mpz bignum, after which every addition in
// the loop is a bignum operation.)

int work(int t) {
    int acc = 0;
    int first = t * 27000000;
    int last = first + 27000000 - 1;

    for (int i = first; i <= last; i++) {
        switch (i % 4) {
            case 0:
                acc = acc + 1;
                break;
            case 1:
                acc = acc + i;
                break;
            case 2:
                acc = acc + 2 * i;
                break;
            case 3:
                acc = acc + 3 * i;
                break;
        }
    }
    return acc;
}

int main() {
    int __t0 = gethrtime(1);
    array(Thread.Thread) workers = ({});

    for (int t = 0; t < 4; t++) {
        workers += ({ Thread.Thread(work, t) });
    }

    int total = 0;
    foreach (workers, Thread.Thread worker) {
        total = total + worker->wait();
    }

    int __t1 = gethrtime(1);
    // gethrtime() alone counts microseconds; gethrtime(1) counts nanoseconds, which is what
    // its own documentation says and what System.REAL_TIME_RESOLUTION=100 here allows.
    werror("TIME_MS=%.3f\n", (__t1 - __t0) / 1000000.0);
    write("%d\n", total);
    return 0;
}
