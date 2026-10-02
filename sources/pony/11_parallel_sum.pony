// task 11 parallel_sum — expected output: 7500000075000000
// build: mkdir -p temp/pony/11_parallel_sum && cp sources/pony/11_parallel_sum.pony temp/pony/11_parallel_sum/ && tools/ponyc/bin/ponyc.exe -o temp/pony/11_parallel_sum temp/pony/11_parallel_sum
// run: temp/pony/11_parallel_sum/11_parallel_sum.exe --ponymaxthreads=4 --ponynoscale
// note: PARALLEL. Pony's actors are the language's concurrency construct: each Worker is an
//       actor, so each quarter runs as its own behaviour and the four are scheduled by the
//       runtime's thread pool, one OS thread per scheduler. Each worker owns a fixed quarter,
//       so the order they finish in cannot change the answer.
// note: --ponymaxthreads=4 --ponynoscale fixes the pool at four scheduler threads and stops
//       the runtime from scaling it with load. Verified on this host with a probe built from
//       this file that also reports runtime_info.Scheduler.scheduler_index(): with the flags
//       the pool prints 4/4 and the four workers report schedulers 1, 2, 0 and 3 — four
//       different OS threads — while at --ponymaxthreads=1 all four report scheduler 0.
// note: each worker sends its partial to Main with a behaviour call; Main counts the four
//       replies and prints once the last one arrives. Behaviours are asynchronous, so this is
//       a reply-to-collector join rather than a blocking join.


actor Worker
  let _t: U64
  let _main: Main

  new create(t: U64, main: Main) =>
    _t = t
    _main = main

  be work() =>
    var acc: U64 = 0
    var i: U64 = _t * 25000000
    let stop: U64 = (_t + 1) * 25000000
    while i < stop do
      match (i % 4)
      | 0 => acc = acc + 1
      | 1 => acc = acc + i
      | 2 => acc = acc + (2 * i)
      | 3 => acc = acc + (3 * i)
      end
      i = i + 1
    end
    _main.done(acc)

actor Main
  let _env: Env
  var _total: U64 = 0
  var _replies: USize = 0

  new create(env: Env) =>
    _env = env
    var t: U64 = 0
    while t < 4 do
      Worker(t, this).work()
      t = t + 1
    end

  be done(partial: U64) =>
    _total = _total + partial
    _replies = _replies + 1
    if _replies == 4 then
      _env.out.print(_total.string())
    end
