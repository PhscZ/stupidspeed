(* task 09 fib_recursive — expected output: 102334155 *)
(* build: ocamlopt -unsafe -o prog.exe _09_fib_recursive.ml *)
(* run: prog.exe *)
(* note: the row is built from the MSYS2 UCRT64 package mingw-w64-ucrt-x86_64-ocaml
         (OCaml 5.4.1). Two environment details are required and are not obvious:
         OCAMLLIB must be set to the *Windows* form of the stdlib directory
         (C:\...\ucrt64\lib\ocaml), because ocamlopt is a native Win32 binary and the
         MSYS2-style /ucrt64/... path baked into its config resolves to nothing -- without
         it every compile fails with 'Unbound module Stdlib'. And the separate
         mingw-w64-ucrt-x86_64-flexdll package has to be installed, or the link step stops
         with "'flexlink' is not recognized". *)
(* note: -unsafe turns off array and string bounds checks, which is the usual speed knob
         for OCaml. -O3 is accepted but is a no-op here: this switch reports
         flambda: false, and -O3 only does anything under Flambda. *)
(* note: filenames carry the row's _ prefix. OCaml derives a module name from the file
         name and a module name has to be a valid identifier, so 01_branches.ml draws
         'Warning 24: bad source file name'; _01_branches.ml compiles clean. *)
(* Naive fib(40): about 331 million calls, so this measures the call path itself rather than any
   arithmetic. *)
let rec fib n = if n < 2 then n else fib (n - 1) + fib (n - 2)

let () = Printf.printf "%d\n" (fib 40)
