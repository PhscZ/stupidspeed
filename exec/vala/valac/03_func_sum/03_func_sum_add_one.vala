// task 03 func_sum (helper unit) — expected output: 100000000
// build: valac -X -O2 -o prog 03_func_sum_add_one.vala 03_func_sum.vala    run: ./prog
// note: add_one is kept in its own Vala file so valac emits it as its own C translation unit
//       and gcc cannot inline the call into main's loop. See 03_func_sum.vala for the full note.

int64 add_one (int64 n) {
    return n + 1;
}
