// task 03 func_sum — expected output: 100000000
// build: valac -X -O2 -o prog 03_func_sum_add_one.vala 03_func_sum.vala    run: ./prog
// note: build from the MSYS2 UCRT64 shell (tools/msys2.cmd, MSYSTEM=UCRT64). valac translates
//       the Vala to C and drives gcc, and -X -O2 is what hands -O2 to that gcc; without it
//       the generated C is compiled unoptimised.
// note: this task calls no GLib function, so the linker drops the GLib import and the built
//       executable needs nothing at run time.
// note: Vala has no no-inline attribute — `[NoInline]` is rejected as "attribute never used",
//       and a same-file `add_one` keeps external linkage in the generated C, which gcc -O2 is
//       free to inline at its single call site. add_one therefore lives in its own file,
//       03_func_sum_add_one.vala, compiled on the same valac command line; valac
//       emits one C file per Vala file and gcc compiles them as separate translation units,
//       so the hundred million calls are real calls. Verified with objdump: the loop body in
//       main is `call <add_one>` and `add_one` is an exported symbol.

int main () {
    int64 value = 0;

    for (int64 i = 0; i < 100000000; i++) {
        value = add_one (value);
    }

    stdout.printf ("%lld\n", value);
    return 0;
}
