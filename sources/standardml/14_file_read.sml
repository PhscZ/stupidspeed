(* task 14 file_read — expected output: 2389704704 *)
(* build: tools/polyml/PolyML.exe -q --error-exit --script build/14_file_read.ML
            (writes 14_file_read.obj into this directory)
        gcc -Wl,-u,WinMain -mconsole -o 14_file_read.exe 14_file_read.obj \
            tools/polyml/polystub.obj -Ltools/polyml -lpolyml *)
(* run:   ./14_file_read.exe   (run from this directory) *)
(* note: PolyLib.dll must be beside the produced .exe — copy it once with
         `cp tools/polyml/PolyLib.dll .`. Without it the process dies before
         main with Windows status 0xC0000135 and prints nothing. *)
(* note: data.bin must be in the working directory: 52428800 bytes, the
        bytes 0 through 255 repeating. *)
(* note: It is a generated fixture, not a committed file — copy
        `temp/data.bin` here before the run, the way the R and Octave rows
        do. *)
(* note: THE BINARY LAYER IS `BinIO`, NOT `Posix`. There is no `Posix`
        structure in the Windows basis at all: `Posix.FileSys.getcwd ()`
        fails with "Structure (Posix) has not been declared", because
        basis/Posix.sml is backed by libpolyml/unix_specific.cpp, which is
        not built on Windows. BinIO is complete and is what this uses —
        openIn, inputN, closeIn, over Word8Vector. (BinIO has no
        stdIn/stdOut, so console output goes through TextIO.) CHUNKS ARE
        65536 BYTES, NOT 1 MiB. This is a real trap, not a preference. A 1
        MiB `BinIO.inputN` request is exactly the runtime's
        `defaultSpaceSize` (1024*1024/sizeof(PolyWord), one 1 MiB segment)
        and it is correct only 3 times in 24 runs. The other 21 print
        NOTHING and die with "Run out of store - interrupting threads" after
        a 5-second stall — Poly/ML's allocation-failure path sleeps 5000 ms
        before retrying. Chunks of 8 KiB, 64 KiB, 256 KiB and 512 KiB were
        16/16 correct each. It is not memory pressure: a pure 50 MiB
        allocation with no file I/O succeeds 3/3, the chunked read itself
        uses only 3 MB of heap, and the failures happened with 1433 MB free
        as well as with 602 MB. 64 KiB costs nothing: 0.28 s for the whole
        file, the same as 256 KiB. *)
(* note: this is the deviation RUN.md records for this task: the spec's "one
        pass" is honoured, but the chunk size is chosen for correctness
        rather than for speed. *)
(* note: `Word8.toInt` returns 0..255 unsigned, so the sum is over raw byte
        values. The accumulator is a 63-bit Int and the running total
        6684672000 is exact, so the final `mod 4294967296` is exact. *)
(* note: Reading this file as TEXT would be silently wrong on Windows: the
        204800 CR bytes are translated away and the answer comes out short,
        which is why BinIO is used and not TextIO. *)
(* note: measured: 0.326 s for 52428800 bytes, 5.3 ns per byte including the
        per-byte conversion. *)
val CHUNK = 65536

fun main () =
  let
    val t0 = Time.now ()
    val ins = BinIO.openIn "data.bin"
    fun loop (nbytes, total) =
      let
        val got = BinIO.inputN (ins, CHUNK)
      in
        if Word8Vector.length got = 0 then (nbytes, total)
        else
          let
            val m = Word8Vector.length got
            fun s (i, acc) =
              if i >= m then acc
              else s (i + 1, acc + Word8.toInt (Word8Vector.sub (got, i)))
          in
            loop (nbytes + m, total + s (0, 0))
          end
      end
    val (nbytes, total) = loop (0, 0)
    val () = BinIO.closeIn ins
    val result = total mod 4294967296
    val () = TextIO.output (TextIO.stdErr, "TIME_MS=" ^ Real.fmt (StringCvt.FIX (SOME 3)) (Time.toReal (Time.- (Time.now (), t0)) * 1000.0) ^ "\n")
  in
    print (Int.toString result ^ "\n")
  end
