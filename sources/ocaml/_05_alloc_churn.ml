(* task 05 alloc_churn — expected output: 1274991808 *)
(* build: ocamlopt -unsafe -o prog.exe _05_alloc_churn.ml *)
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
(* Ten million 64-byte buffers, each stored into one of 256 slots so the buffer it replaces
   becomes garbage -- the same reachability line the C and Java rows draw. The running total adds
   v, the value written, exactly as the Java row does. *)
let () =
  let slots = Array.make 256 Bytes.empty in
  let total = ref 0 in
  for i = 0 to 10000000 - 1 do
    let v = i mod 256 in
    let buf = Bytes.make 64 '\000' in
    Bytes.unsafe_set buf 0 (Char.chr v);
    slots.(v) <- buf;
    total := !total + v
  done;
  Printf.printf "%d\n" !total
