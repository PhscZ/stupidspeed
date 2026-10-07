NB. task 11 parallel_sum — expected output: 7500000075000000
NB. build: none (interpreted)    run: jconsole.exe 11_parallel_sum.ijs
NB. note: these are real OS threads inside the interpreter, J's own task
NB.       primitives (T. and t.), which arrived in J9.4 and are futex-based. No
NB.       child processes and no extra install are needed.
NB. note: 0 T. '' creates one thread in threadpool 0 and returns its number; the
NB.       four are created BEFORE the dispatch, because a task whose keyword is
NB.       'worker' runs in a worker thread only if the pool is not empty, and a
NB.       task with no free thread runs in the calling thread instead. Each
NB.       u t. n y returns a pyx, a future; opening one blocks until the value
NB.       exists, so > each on the four of them is the join.
NB. note: each worker owns a fixed quarter of task 02's range, so which one
NB.       finishes first cannot change the answer.
NB. note: the four workers really do overlap. Timed with 6!:1 inside the workers
NB.       they all start at the same instant and finish together (one run:
NB.       starts 0.423 0.423 0.423 0.423, ends 51.786 57.253 57.916 55.058), and
NB.       the identical four ranges run serially in the same process take
NB.       40.2 s against 22.5-23.3 s on four threads -- about 1.7x. It is not a
NB.       4x cell: the same 25M-iteration worker takes 10.5 s on the master
NB.       thread and 19.3 s inside a worker thread, so J's explicit verbs run
NB.       about 1.8x slower per thread, which caps the gain. See RUN.md.

t0 =: 6!:1 ''

worker =: 3 : 0
  acc =. 0
  i =. y * 25000000
  lim =. i + 25000000
  while. i < lim do.
    select. 4 | i
    case. 0 do.
      acc =. acc + 1
    case. 1 do.
      acc =. acc + i
    case. 2 do.
      acc =. acc + 2 * i
    case. 3 do.
      acc =. acc + 3 * i
    end.
    i =. i + 1
  end.
  acc
)

0 T. ''
0 T. ''
0 T. ''
0 T. ''

parts =. > each worker t. 'worker'"0 ] 0 1 2 3

res =: ": +/ > parts
t1 =: 6!:1 ''
stderr 'TIME_MS=', (": (t1 - t0) * 1000)

stdout res, LF
exit 0
