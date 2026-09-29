NB. task 15 file_write — expected output: 52428800
NB. build: none (interpreted)    run: jconsole.exe 15_file_write.ijs
NB. note: the 1 MiB buffer is 1048576 $ a., which is the 256-byte alphabet reshaped,
NB.       i.e. bytes 0..255 repeated 4096 times, the analogue of the Python row's
NB.       bytes(range(256)) * 4096. It is appended 50 times to out.bin in the
NB.       working directory with 1!:3 and the bytes written are printed.
NB. note: J has no fsync, flush or FlushFileBuffers primitive: the 1!:, 2!: and 15!:
NB.       foreign tables contain none. Each 1!:3 with a boxed filename opens, writes
NB.       and closes the file, so J's own buffers are flushed and the data is handed
NB.       to the OS before the program prints, which is the strongest guarantee J
NB.       offers. This is a documented deviation, not a silent one.
NB. note: out.bin is erased first so that the result is the same on a rerun.

1!:55 :: 0: <'out.bin'

file_write =: 3 : 0
  buf =. 1048576 $ a.
  written =. 0
  i =. 0
  while. i < 50 do.
    buf 1!:3 <'out.bin'
    written =. written + # buf
    i =. i + 1
  end.
  ": written
)

stdout (file_write''), LF
exit 0
