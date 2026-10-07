# task 14 file_read — expected output: 2389704704
# build: none — `janet` compiles the script to bytecode and runs it on every invocation
# run: janet 14_file_read.janet
# note: data.bin must be in the working directory: 52428800 bytes, the bytes 0 through 255
#       repeating.
# note: chunks are 1 MiB, the same size the C row reads. `(file/read f 1048576 buf)` reads
#       into a `buffer` (a byte array), and two behaviours have to be handled: it returns
#       nil when it read nothing, which is the end-of-file test, and when a buffer is passed
#       the bytes are appended to it, so the buffer is cleared each iteration.
# note: `(in buf i)` returns the byte as an integer, and the accumulator is a double. The
#       running total, 6684672000, is below 2^53, so it is exact, and the remainder is taken
#       with `%`, which is exact on doubles this size.
# note: the file is opened `:rb`. Janet's mode keyword is a set of flags and `r` alone is
#       text mode, which on Windows would translate CRLF pairs; data.bin has no adjacent
#       0x0D 0x0A, so the sum is the same either way, but `b` is the correct mode for a byte
#       stream.

# timing: os/clock is Janet's monotonic clock, in seconds as a double; TIME_MS goes to
#         stderr with eprintf and stdout is unchanged.
(def ss-t0 (os/clock))
(defn ss-report [] (eprintf "TIME_MS=%.3f\n" (* 1000 (- (os/clock) ss-t0))))

(def CHUNK 1048576)

(def f (file/open "data.bin" :rb))
(def buf (buffer/new CHUNK))
(var total 0)

(while true
  (buffer/clear buf)
  (def got (file/read f CHUNK buf))
  (if (nil? got) (break))
  (def n (length got))
  (for i 0 n
    (+= total (in got i))))

(file/close f)

(ss-report)
(print (% total 4294967296))
