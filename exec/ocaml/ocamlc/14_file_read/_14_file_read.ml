(* task 14 file_read — expected output: 2389704704 *)
(* build: ocamlopt -unsafe -o prog.exe _14_file_read.ml *)
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
(* note: data.bin is read from the working directory in 1 MiB chunks and every byte is added up;
         the running total is reduced mod 2^32 after each chunk so it stays inside the 2^53 range
         where a float is exact. Char.code already yields 0..255, so no sign masking is needed. *)
(* timing: Unix.gettimeofday is the clock this build of the Unix module exposes (there is
   no clock_gettime binding here, so the monotonic clock is not reachable from OCaml);
   TIME_MS goes to stderr through Printf.eprintf and stdout is unchanged. *)
let ss_t0 = ref 0.0
let ss_now () = Unix.gettimeofday () *. 1000.0
let ss_report () = Printf.eprintf "TIME_MS=%.3f\n" (ss_now () -. !ss_t0)

let () =
  ss_t0 := ss_now ();
  let chunk = 1048576 in
  let buf = Bytes.create chunk in
  let ic = open_in_bin "data.bin" in
  let total = ref 0 in
  let finished = ref false in
  while not !finished do
    let got = input ic buf 0 chunk in
    if got = 0 then finished := true
    else begin
      for i = 0 to got - 1 do
        total := (!total + Char.code (Bytes.unsafe_get buf i)) mod 4294967296
      done
    end
  done;
  close_in ic;
  ss_report ();
  Printf.printf "%d\n" !total
