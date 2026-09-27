(* task 06 char_count — expected output: 10000000 *)
(* build: ocamlopt -unsafe -o prog.exe _06_char_count.ml *)
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
(* The 100 MB text is built once by doubling the ten-character block in place, which is O(log n)
   blits rather than a hundred million of them, and then scanned one character at a time. It is a
   Bytes rather than a String because OCaml 5 strings are immutable and String.blit no longer
   exists; the bytes are never mutated after the build, so this is a mutable text buffer only
   because that is what the language allows. *)
let () =
  let n = 100000000 in
  let text = Bytes.create n in
  Bytes.blit_string "abcdefghij" 0 text 0 10;
  let k = ref 10 in
  while !k < n do
    Bytes.blit text 0 text !k (min !k (n - !k));
    k := !k * 2
  done;
  let count = ref 0 in
  for i = 0 to n - 1 do
    if Bytes.unsafe_get text i = 'h' then incr count
  done;
  Printf.printf "%d\n" !count
