NB. task 14 file_read — expected output: 2389704704
NB. build: none (interpreted)    run: jconsole.exe 14_file_read.ijs
NB. note: data.bin is a fixture of 52428800 bytes, the bytes 0..255 repeating, read
NB.       from the working directory (copy it next to this script). The file is
NB.       opened once with 1!:21 and read in 1 MiB blocks with 1!:11, never a byte
NB.       per syscall, the same shape as the R and Python rows.
NB. note: each block is converted once to its byte codes with a. i. chunk and then
NB.       added one byte at a time in a while. loop. The total before the modulus
NB.       (6684672000) is far below 2^63, so the accumulation is exact; the
NB.       modulus is taken once, at the end.

file_read =: 3 : 0
  fh =. 1!:21 <'data.bin'
  sz =. 1!:4 fh
  total =. 0
  pos =. 0
  while. pos < sz do.
    len =. 1048576 <. sz - pos
    chunk =. 1!:11 (fh ; pos , len)
    codes =. a. i. chunk
    i =. 0
    while. i < len do.
      total =. total + i { codes
      i =. i + 1
    end.
    pos =. pos + len
  end.
  1!:22 fh
  ": 4294967296 | total
)

stdout (file_read''), LF
exit 0
