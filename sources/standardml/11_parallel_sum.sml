(* task 11 parallel_sum — expected output: 7500000075000000 *)
(* build: tools/polyml/PolyML.exe -q --error-exit --script build/11_parallel_sum.ML
            (writes 11_parallel_sum.obj into this directory)
        gcc -Wl,-u,WinMain -mconsole -o 11_parallel_sum.exe 11_parallel_sum.obj \
            tools/polyml/polystub.obj -Ltools/polyml -lpolyml *)
(* run:   ./11_parallel_sum.exe -H 256   (run from this directory) *)
(* note: PolyLib.dll must be beside the produced .exe — copy it once with
         `cp tools/polyml/PolyLib.dll .`. Without it the process dies before
         main with Windows status 0xC0000135 and prints nothing. *)
(* note: -H 256 is Poly/ML's initial heap size in megabytes, and it is required, not a
        tuning knob. An exported image starts on the run-time system's default heap and
        grows it on demand; under memory pressure that growth fails and the process dies
        with "Run out of store - interrupting threads" and no output (measured: task 12
        failed in about half of six runs with the default heap, task 06 died silently
        once, and no run failed with -H 256). Reserving the heap up front also removes
        the growth steps, which is why task 12 measures about 25 ms with the flag
        against about 55 ms without it. *)
(* note: the threads are Poly/ML's own `Thread` structure, which ships with
        the distribution, so nothing extra is installed and no flag is
        needed. *)
(* note: NOTE THE NESTING: the fork and the processor query live in
        `Thread.Thread`, not in `Thread`. *)
(* note: `Thread.fork` and `Thread.numProcessors` are both "not declared in
        structure Thread", while `Thread.Thread.fork` and
        `Thread.Thread.numProcessors` are. `Thread.Mutex` and
        `Thread.ConditionVar` are at the top level, as written below. *)
(* note: these are REAL OS THREADS, not green ones. The Windows arm of the
        runtime's PolyThreadForkThread is literally `CreateThread(NULL, 0,
        NewThreadFunction, newTaskData, 0, NULL)` (libpolyml/processes.cpp),
        and the GC task farm uses the same call. There is no green fallback
        and no thread-count setting in 5.9.1. *)
(* note: measured: 3.30x on four workers. The same `work` function run four
        times in a row takes 0.2311438 s; on four threads it takes 0.0700827
        s, and both print 7500000075000000. That is why this is a plain PASS
        and NOT a correct-answer-no-speedup cell like CPython's. *)
(* note: `Thread.Thread.numProcessors ()` reports 20 and
        `numPhysicalProcessors ()` reports SOME 12 on this host, matching
        its 20 logical / 12 physical cores. *)
(* note: each worker owns a fixed quarter of the range, so which one
        finishes first cannot change the answer. The four results are joined
        through a mutex and a condition variable. *)
(* note: the accumulator is an Int (63-bit) and the total 7500000075000000
        is below 2^62, so it is exact and prints as plain digits. *)
fun work (t : int, per : int) =
  let
    val lo = t * per
    val hi = (t + 1) * per
    fun loop (i, acc) =
      if i >= hi then acc
      else loop (i + 1, acc +
        (case i mod 4 of 0 => 1 | 1 => i | 2 => 2 * i | _ => 3 * i))
  in
    loop (lo, 0)
  end

fun main () =
  let
    val t0 = Time.now ()
    val per = 25000000
    val results = Array.array (4, 0)
    val mutex = Thread.Mutex.mutex ()
    val cond = Thread.ConditionVar.conditionVar ()
    val done = ref 0
    fun worker t =
      let val r = work (t, per)
      in
        Thread.Mutex.lock mutex;
        Array.update (results, t, r);
        done := !done + 1;
        if !done = 4 then Thread.ConditionVar.signal cond else ();
        Thread.Mutex.unlock mutex
      end
    val _ = List.app
      (fn t => ignore (Thread.Thread.fork (fn () => worker t, []))) [0, 1, 2, 3]
    val () = Thread.Mutex.lock mutex
    val () = while !done < 4 do Thread.ConditionVar.wait (cond, mutex)
    val () = Thread.Mutex.unlock mutex
    val () = TextIO.output (TextIO.stdErr, "TIME_MS=" ^ Real.fmt (StringCvt.FIX (SOME 3)) (Time.toReal (Time.- (Time.now (), t0)) * 1000.0) ^ "\n")
  in
    print (Int.toString (Array.foldl (op +) 0 results) ^ "\n")
  end
