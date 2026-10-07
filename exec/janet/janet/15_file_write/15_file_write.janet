# task 15 file_write — expected output: 52428800
# build: none — `janet` compiles the script to bytecode and runs it on every invocation
# run: janet 15_file_write.janet
# note: out.bin is written into the working directory, 52428800 bytes.
# note: the 1 MiB buffer is bytes 0..255 repeated 4096 times, built once by index before the
#       write loop, and written 50 times.
# note: `(file/write f buf)` returns the file, not a byte count, so the count is read back
#       from `(file/tell f)`, which is the file's own position after the fifty writes.
# note: the file is opened `:wb`, not `:w`. Janet's mode keyword is a set of flags and `w`
#       alone is text mode: on Windows the C runtime translates every 0x0A byte to CRLF, so
#       the buffer's 4096 newline bytes (i % 256 == 10) become 8192 and the file comes out
#       4096 bytes too long, 52633600 instead of 52428800. The `b` flag turns that off.
# note: deviation — Janet's standard library has `file/flush` (fflush) but no fsync: the File
#       module is close, flush, lines, open, read, seek, tell, temp, write, and there is no
#       file/sync. The buffer is therefore flushed, not fsynced, unlike the C row's
#       fflush + _commit. The printed byte count is unaffected.

# timing: os/clock is Janet's monotonic clock, in seconds as a double; TIME_MS goes to
#         stderr with eprintf and stdout is unchanged.
(def ss-t0 (os/clock))
(defn ss-report [] (eprintf "TIME_MS=%.3f\n" (* 1000 (- (os/clock) ss-t0))))

(def CHUNK 1048576)
(def REPEATS 50)

(def buf (buffer/new-filled CHUNK 0))
(for i 0 CHUNK
  (put buf i (% i 256)))

(def f (file/open "out.bin" :wb))

(for i 0 REPEATS
  (file/write f buf))

(file/flush f)

(def written (file/tell f))
(file/close f)

(ss-report)
(print written)
