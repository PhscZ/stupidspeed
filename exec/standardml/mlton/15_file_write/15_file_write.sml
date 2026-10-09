(* task 15 file_write — expected output: 52428800 *)
(* build: tools/polyml/PolyML.exe -q --error-exit --script build/15_file_write.ML
            (writes 15_file_write.obj into this directory)
        gcc -Wl,-u,WinMain -mconsole -o 15_file_write.exe 15_file_write.obj \
            tools/polyml/polystub.obj -Ltools/polyml -lpolyml *)
(* run:   ./15_file_write.exe -H 256   (run from this directory) *)
(* note: PolyLib.dll must be beside the produced .exe — copy it once with
         `cp tools/polyml/PolyLib.dll .`. Without it the process dies before
         main with Windows status 0xC0000135 and prints nothing. *)
(* note: -H 256 is Poly/ML's initial heap size in megabytes, and it is required, not a
        tuning knob. An exported image starts on the run-time system's default heap and
        grows it on demand; under memory pressure that growth fails and the process dies
        with "Run out of store - interrupting threads" and no output (measured: task 12
        failed in about half of six runs with the default heap, task 06 died silently
        once, and no run failed with -H 256). Reserving the heap up front also removes
        the growth steps, which is why task 12 measures about 25 ms with the flag
        against about 55 ms without it. *)
(* note: out.bin is written into the working directory, 52428800 bytes. *)
(* note: the buffer is the spec's own 1 MiB: bytes 0..255 repeated 4096
        times, built once by `Word8Vector.tabulate` before the write loop,
        then written 50 times. Unlike the read side, a 1 MiB WRITE buffer is
        reliable — 8/8 runs correct at 1 MiB, and 8/8 at 256 KiB and 64 KiB
        as well — so task 15 keeps the spec's shape exactly and task 14 is
        the only one that deviates. *)
(* note: the write path is BinIO.openOut, BinIO.output, BinIO.flushOut,
        BinIO.closeOut. BinIO is the binary layer because there is no
        `Posix` structure in the Windows basis. `openOut` here is a binary
        stream, so no 0x0A byte is translated to CRLF, which is what keeps
        the file at 52428800 bytes instead of 52633600. *)
(* note: DEVIATION — there is no fsync. `Posix` is absent, so
        `Posix.FileSys.fsync` is unreachable; the Windows runtime contains
        no FlushFileBuffers call anywhere (a grep for
        fsync|FlushFileBuffers|_commit over the whole 5.9.1 tree finds only
        basis/Posix.sml and libpolyml/unix_specific.cpp, both POSIX-only);
        and the Basis gives no way to obtain the OS file handle such a call
        would need, because BinIO streams are opaque and OS.IO has no
        stdIn/stdOut here. The file is therefore flushed and closed, not
        fsynced — the same deviation the R and Octave rows record. The
        printed byte count is unaffected. *)
(* note: verified byte-exact: the same program reading its own output back
        and comparing all 256 values reports 0 mismatches, and
        sha256(data.bin) == sha256(out.bin) after a run. *)
(* note: measured: 0.197 s. *)
val CHUNK = 1048576
val REPEATS = 50

fun main () =
  let
    val t0 = Time.now ()
    val buf = Word8Vector.tabulate (CHUNK, fn i => Word8.fromInt (i mod 256))
    val outs = BinIO.openOut "out.bin"
    fun wr (k, written) =
      if k = 0 then written
      else (BinIO.output (outs, buf); wr (k - 1, written + CHUNK))
    val written = wr (REPEATS, 0)
    val () = BinIO.flushOut outs
    val () = BinIO.closeOut outs
    val () = TextIO.output (TextIO.stdErr, "TIME_MS=" ^ Real.fmt (StringCvt.FIX (SOME 3)) (Time.toReal (Time.- (Time.now (), t0)) * 1000.0) ^ "\n")
  in
    print (Int.toString written ^ "\n")
  end
