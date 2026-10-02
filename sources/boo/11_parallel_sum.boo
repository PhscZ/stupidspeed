// task 11 parallel_sum — expected output: 7500000075000000
// build: tools/dotnet10/dotnet.exe tools/boo/src/booc/bin/Release/net10.0/booc.dll -o:prog.exe 11_parallel_sum.boo    run: tools/dotnet10/dotnet.exe prog.exe
// note: the run needs Boo.Lang.dll (tools/boo/src/Boo.Lang/bin/Release/net10.0/) and a
//       prog.runtimeconfig.json for Microsoft.NETCore.App 10.0.0 beside prog.exe.
// note: System.Threading.Thread is a real OS thread on CoreCLR, so the four workers run at the
//       same time -- this is a parallel cell, not a cooperative one.
// note: each worker is a Worker instance carrying its own index and its own result, so the four
//       threads share no state; the join happens before any Result is read.

import System
import System.Threading

// work does task 02's four-way decision over one fixed quarter of the range.
def work(t as long) as long:
    acc as long = 0
    i as long = t * 25000000
    end as long = i + 25000000
    while i < end:
        c = i % 4
        if c == 0:
            acc += 1
        elif c == 1:
            acc += i
        elif c == 2:
            acc += 2 * i
        else:
            acc += 3 * i
        i += 1
    return acc

class Worker:
    public Index as long
    public Result as long

    def constructor(t as long):
        Index = t

    def Run():
        Result = work(Index)

workers = array[of Worker](4)
threads = array[of Thread](4)

t as long = 0
while t < 4:
    workers[t] = Worker(t)
    threads[t] = Thread(ThreadStart(workers[t].Run))
    t += 1

t = 0
while t < 4:
    threads[t].Start()
    t += 1

t = 0
while t < 4:
    threads[t].Join()
    t += 1

total as long = 0
t = 0
while t < 4:
    total += workers[t].Result
    t += 1

print(total)

