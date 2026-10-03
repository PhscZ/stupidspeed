⍝ task 15 file_write — expected output: 52428800
⍝ build: none (interpreted)    run: dyascript -script 15_file_write.dyalog
⍝ note: the 1 MiB buffer is the byte cycle 0..255 repeated 4096 times, built as
⍝       characters with ⎕UCS (1048576⍴⍳256) and written 50 times to out.bin with
⍝       ⎕NAPPEND using conversion code 80. Code 83 would be rejected here for the
⍝       same reason as in 14_file_read.dyalog.
⍝ note: the byte count printed is the program's own counter, not ⎕NSIZE. Measured,
⍝       ⎕NSIZE on the tie reports 5242880 while the file is already 52428800 bytes
⍝       — a factor of ten low — so it cannot be used for this line.
⍝ note: deviation — Dyalog has no fsync. The ⎕N* foreign functions contain no
⍝       flush, sync or FlushFileBuffers operation; the closest thing is ⎕NUNTIE ⍬,
⍝       which the manual documents as flushing all file caches, and that is an
⍝       APL-level flush to the OS rather than a durability barrier. So this row
⍝       joins the flush-and-close list the Tcl, D, Julia, Nim, Dart, Pascal, COBOL,
⍝       Dolphin, Haxe, Eiffel, Seed7, Scheme, SWI-Prolog, Octave, J, Janet, Ring,
⍝       JScript, AutoHotkey and ActionScript rows are on. The string
⍝       FlushFileBuffers does occur in dyalog200_64_unicode.dll and ⎕NA could call
⍝       kernel32|FlushFileBuffers directly, but that is a DLL call the task did not
⍝       ask for, so the deviation is recorded rather than taken.
⍝ note: out.bin is deleted first so a rerun writes the same 52428800 bytes rather
⍝       than appending to the previous run's file.
⎕IO←0
⎕PP←17

:If ⎕NEXISTS 'out.bin'
  ⎕NDELETE 'out.bin'
:EndIf

∇ r←file_write;buf;tie;written;i
  buf←⎕UCS 1048576⍴⍳256
  tie←'out.bin'⎕NCREATE 0
  written←0
  i←0
  :While i<50
    buf ⎕NAPPEND tie 80
    written+←1048576
    i+←1
  :EndWhile
  ⎕NUNTIE tie
  r←⍕written
∇

⎕←file_write
