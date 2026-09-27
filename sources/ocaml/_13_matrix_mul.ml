(* task 13 matrix_mul — expected output: 599995000 *)
(* build: ocamlopt -unsafe -o prog.exe _13_matrix_mul.ml *)
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
(* The plain i, j, k triple loop in that order on flat row-major arrays, so the k loop walks a
   column of b. Reordering would be faster, which is the point. *)
let () =
  let n = 500 in
  let elems = n * n in
  let a = Array.make elems 0 and b = Array.make elems 0 and c = Array.make elems 0 in
  for i = 0 to n - 1 do
    for j = 0 to n - 1 do
      let idx = i * n + j in
      a.(idx) <- (i + j) mod 7;
      b.(idx) <- (i * j) mod 5
    done
  done;
  for r = 0 to n - 1 do
    for col = 0 to n - 1 do
      let sum = ref 0 in
      for k = 0 to n - 1 do
        sum := !sum + a.(r * n + k) * b.(k * n + col)
      done;
      c.(r * n + col) <- !sum
    done
  done;
  let total = ref 0 in
  for e = 0 to elems - 1 do
    total := !total + c.(e)
  done;
  Printf.printf "%d\n" !total
