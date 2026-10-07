# task 03 func_sum — expected output: 100000000
# build: none — `janet` compiles the script to bytecode and runs it on every invocation
# run: janet 03_func_sum.janet
# note: add-one lives in its own file, 03_func_sum_add_one.janet, so the call crosses a
#       module boundary, the same two-file shape the Fortran, Tcl, Vala and Racket rows use.
# note: Janet has no no-inline marker to write, but it does not need one. Its bytecode
#       compiler can inline a function, yet `function_can_inline` (src/core/compile.c)
#       returns early unless `:optimize` is at least 2, and user scripts compile at the
#       default level 0 — `*optimize*` documents "Default is 0" and the shell exposes no
#       optimization flag. A plain `janet 03_func_sum.janet` therefore cannot inline
#       add-one, and the call happens a hundred million times.
# note: the module is imported with an empty prefix, so the helper is called as `add-one`
#       rather than the default `03_func_sum_add_one/add-one`. The path is written as a
#       string because the file name starts with a digit.

# timing: os/clock is Janet's monotonic clock, in seconds as a double; TIME_MS goes to
#         stderr with eprintf and stdout is unchanged.
(def ss-t0 (os/clock))
(defn ss-report [] (eprintf "TIME_MS=%.3f\n" (* 1000 (- (os/clock) ss-t0))))

(import "./03_func_sum_add_one" :prefix "")

(var value 0)

(for i 0 100000000
  (set value (add-one value)))

(ss-report)
(print value)
