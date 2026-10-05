; helper for task 03 func_sum — the caller is 03_func_sum.ahk
; note: AutoHotkey has no inlining pass, so there is no no-inline marker to write and
;       nothing that could delete this call: the interpreter resolves every function
;       reference to an address while the script is loading and calls it at run time.
;       The separate file is the row's cross-file convention, not a way to defeat an
;       optimiser, and the same function is called a hundred million times.
; note: the file is loaded with #Include, which is a textual merge at load time, so it
;       must not contain top-level code; it holds the definition only.

AddOne(n) {
    return n + 1
}
