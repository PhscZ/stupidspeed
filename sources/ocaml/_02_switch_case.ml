(* task 02 switch_case — expected output: 7500000075000000 *)
(* build: ocamlopt -unsafe -o prog.exe _02_switch_case.ml *)
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
(* OCaml's native int is 63-bit, so the total 7500000075000000 fits with room to spare and no
   Int64 is needed. *)
let () =
  let acc = ref 0 in
  for i = 0 to 100000000 - 1 do
    acc := !acc + (match i mod 4 with
                   | 0 -> 1
                   | 1 -> i
                   | 2 -> 2 * i
                   | _ -> 3 * i)
  done;
  Printf.printf "%d\n" !acc
