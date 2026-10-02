// task 03 func_sum (helper) — expected output: 100000000
// build: gleam build    run: gleam run --module t03_func_sum
// note: this is the helper module task 03 calls, not a task of its own -- the same split
//       the Standard ML row makes with 03_func_sum_add_one.sml. It is a separate module so
//       the call crosses a module boundary and cannot be inlined away; the Erlang backend
//       inlines only within a module, and only when asked to. The build compiles it along
//       with the other modules, and the task-03 run command above is the one that runs.

pub fn add_one(n: Int) -> Int {
  n + 1
}
