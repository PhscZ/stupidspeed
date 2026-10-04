(* task 05 alloc_churn — expected output: 1274991808 *)
(* build: tools/polyml/PolyML.exe -q --error-exit --script build/05_alloc_churn.ML
            (writes 05_alloc_churn.obj into this directory)
        gcc -Wl,-u,WinMain -mconsole -o 05_alloc_churn.exe 05_alloc_churn.obj \
            tools/polyml/polystub.obj -Ltools/polyml -lpolyml *)
(* run:   ./05_alloc_churn.exe   (run from this directory) *)
(* note: PolyLib.dll must be beside the produced .exe — copy it once with
         `cp tools/polyml/PolyLib.dll .`. Without it the process dies before
         main with Windows status 0xC0000135 and prints nothing. *)
(* note: `Word8Array.array (64, 0w0)` is the 64-byte allocation, a byte
        array rather than a boxed one, so each iteration allocates exactly
        64 bytes plus a header. `Word8Array.update` writes the byte and
        `Word8Array.sub` reads it back, the same thing the C row does with
        buf[0]. *)
(* note: storing into `slots` keeps the buffer reachable and drops the one
        it replaces, which is what makes the replaced buffer garbage for the
        collector — the same thing the C row's free(slots[slot]) does by
        hand. Without the store the whole loop would be dead code. *)
(* note: this really does go through the GC.
        PolyML.Statistics.getLocalStats() is how to see it, and it is a
        Poly/ML extension rather than part of the SML Basis: ten million
        iterations produced 3 full GCs and 113 partial GCs, 20.95 MB
        allocated, and 0.0234 s of GC time inside 0.5323 s of wall time
        (4.4%). *)
(* note: the total, 1274991808, is exact in a 63-bit Int. *)
(* note: measured: 0.759 s, 76 ns per iteration — the slowest per-iteration
        cell in the row, which is what an allocation benchmark should look
        like. *)
fun main () =
  let
    val __t0 = Time.now ()
    val slots = Array.array (256, Word8Array.array (64, 0w0))
    fun loop (i, total) =
      if i >= 10000000 then total
      else
        let
          val buf = Word8Array.array (64, 0w0)
          val () = Word8Array.update (buf, 0, Word8.fromInt (i mod 256))
          val v = Word8.toInt (Word8Array.sub (buf, 0))
          val () = Array.update (slots, i mod 256, buf)
        in
          loop (i + 1, total + v)
        end
    val result = loop (0, 0)
    val () = TextIO.output (TextIO.stdErr, "TIME_MS=" ^ Real.fmt (StringCvt.FIX (SOME 3)) (Time.toReal (Time.- (Time.now (), __t0)) * 1000.0) ^ "\n")
  in
    print (Int.toString result ^ "\n")
  end
