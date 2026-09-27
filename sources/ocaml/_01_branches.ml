(* task 01 branches — expected output: 33333334 13333333 7619048 45714285 *)
(* build: ocamlopt -unsafe -o prog.exe _01_branches.ml *)
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
let () =
  let a = ref 0 and b = ref 0 and c = ref 0 and d = ref 0 in
  for i = 0 to 100000000 - 1 do
    if i mod 3 = 0 then incr a
    else if i mod 5 = 0 then incr b
    else if i mod 7 = 0 then incr c
    else incr d
  done;
  Printf.printf "%d %d %d %d\n" !a !b !c !d
