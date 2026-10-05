// task 11 parallel_sum — expected output: 7500000075000000
// build: none (interpreted)    run: lobster 11_parallel_sum.lobster
//
// Lobster has real worker threads: start_worker_threads runs one isolated VM per
// thread, and the only way they share state is by copying serializable objects
// through the tuple space (thread_write / thread_read).  So the four ranges of task
// 02's work go out as requests and come back as responses, and the main thread sums
// the four partial sums.

// timing: seconds_elapsed() is the VM's monotonic clock (QueryPerformanceCounter on Windows).
// Lobster has no stderr, so the contract's fallback applies: TIME_MS is written to time.txt.
let t_start = seconds_elapsed()

class ps_request:
    attribute serializable
    t:int

class ps_response:
    attribute serializable
    acc:int

def work_range(t:int) -> int:
    var acc = 0
    var i = t * 25000000
    let hi = i + 25000000
    while i < hi:
        switch i % 4:
            case 0: acc += 1
            case 1: acc += i
            case 2: acc += 2 * i
            case 3: acc += 3 * i
        i++
    return acc

if not is_worker_thread():
    start_worker_threads(4)
    for(4) t:
        thread_write(ps_request { t })

    var total = 0
    for(4):
        let resp = thread_read(typeof ps_response)
        if resp: total += resp.acc
    stop_worker_threads()

    write_file("time.txt", "TIME_MS=" + string((seconds_elapsed() - t_start) * 1000.0) + "\n")
    print total
else:
    while workers_alive():
        let req = thread_read(typeof ps_request)
        if req:
            thread_write(ps_response { work_range(req.t) })
