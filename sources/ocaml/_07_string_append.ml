(* task 07 string_append — expected output: 1000000 *)
(* build: ocamlopt -unsafe -o prog.exe _07_string_append.ml *)
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
(* Plain string concatenation a million times. OCaml strings are immutable, so ^ allocates a
   fresh string and copies both sides on every step, which is the same quadratic copy the C row's
   realloc plus strcat does. Deliberately no Buffer, which would make this linear. *)
let () =
  let text = ref "" in
  for _ = 1 to 1000000 do
    text := !text ^ "x"
  done;
  Printf.printf "%d\n" (String.length !text)
