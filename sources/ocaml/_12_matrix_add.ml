(* task 12 matrix_add — expected output: 999000000 *)
(* build: ocamlopt -unsafe -o prog.exe _12_matrix_add.ml *)
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
  let n = 1000 in
  let elems = n * n in
  let a = Array.make elems 0 and b = Array.make elems 0 and c = Array.make elems 0 in
  for i = 0 to n - 1 do
    for j = 0 to n - 1 do
      let idx = i * n + j in
      a.(idx) <- i + j;
      b.(idx) <- i - j
    done
  done;
  for p = 0 to n - 1 do
    for q = 0 to n - 1 do
      let idx = p * n + q in
      c.(idx) <- a.(idx) + b.(idx)
    done
  done;
  let total = ref 0 in
  for k = 0 to elems - 1 do
    total := !total + c.(k)
  done;
  Printf.printf "%d\n" !total
