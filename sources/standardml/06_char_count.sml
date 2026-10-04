(* task 06 char_count — expected output: 10000000 *)
(* build: tools/polyml/PolyML.exe -q --error-exit --script build/06_char_count.ML
            (writes 06_char_count.obj into this directory)
        gcc -Wl,-u,WinMain -mconsole -o 06_char_count.exe 06_char_count.obj \
            tools/polyml/polystub.obj -Ltools/polyml -lpolyml *)
(* run:   ./06_char_count.exe   (run from this directory) *)
(* note: PolyLib.dll must be beside the produced .exe — copy it once with
         `cp tools/polyml/PolyLib.dll .`. Without it the process dies before
         main with Windows status 0xC0000135 and prints nothing. *)
(* note: the hundred-million-character string is built by REPEATING THE
        WHOLE BLOCK, not by appending in a loop: `rep` doubles `s` and folds
        in the odd factor, so 10000000 blocks of 10 characters cost about 2
        * 100 MB of copying and no per-character loop. Appending would make
        the build itself quadratic, which the spec forbids. *)
(* note: SML has no `String.repeat` in the Basis and Poly/ML adds none, so
        the doubling is written out. *)
(* note: `String.concat (List.tabulate (n, ...))` would also be a block
        repeat, but it allocates ten million list cells first, so the
        doubling is both lighter and closer to the spec's wording. *)
(* note: `String.sub` returns a `char`, and `char` is a byte here. Only 'h'
        (104) increments the count; 'a' and 'e' are matched and skipped,
        exactly as in the C row, and the three comparisons are the spec's
        skip/skip/count shape. *)
(* note: measured: 0.308 s, 3.1 ns per character. *)
fun main () =
  let
    val __t0 = Time.now ()
    val block = "abcdefghij"
    fun rep (s, k) =
      if k = 1 then s
      else
        let val h = rep (s, k div 2)
        in if k mod 2 = 0 then h ^ h else h ^ h ^ s end
    val text = rep (block, 10000000)
    val n = String.size text
    fun scan (i, count) =
      if i >= n then count
      else
        let val ch = String.sub (text, i)
        in
          if ch = #"a" orelse ch = #"e" orelse ch = #"h" then
            (if ch = #"h" then scan (i + 1, count + 1) else scan (i + 1, count))
          else
            scan (i + 1, count)
        end
    val result = scan (0, 0)
    val () = TextIO.output (TextIO.stdErr, "TIME_MS=" ^ Real.fmt (StringCvt.FIX (SOME 3)) (Time.toReal (Time.- (Time.now (), __t0)) * 1000.0) ^ "\n")
  in
    print (Int.toString result ^ "\n")
  end
