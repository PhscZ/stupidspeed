# task 14 file_read — expected output: 2389704704
# build: Rscript 14_file_read.R    run: Rscript 14_file_read.R
#
# data.bin is 52428800 bytes, the bytes 0..255 repeating, opened from the
# working directory and read in 1 MiB chunks, never a byte per syscall. The bytes
# are added one at a time in a while loop, the same per-byte accumulation every
# other row runs; the accumulation is exact because the total before the modulus
# (6684672000) is far below 2^53. The modulus is taken once, at the end.
# (Adding a chunk with a single sum() call would be a vectorised bulk aggregate
# in the timed path, which is not the loop the task asks for.)

read_file <- function() {
  con <- file("data.bin", "rb")
  total <- 0
  repeat {
    chunk <- readBin(con, "raw", n = 1048576)
    if (length(chunk) == 0) break
    bytes <- as.integer(chunk)
    n <- length(bytes)
    i <- 0
    while (i < n) {
      total <- total + bytes[i + 1]
      i <- i + 1
    }
    if (n < 1048576) break
  }
  close(con)
  cat(sprintf("%.0f\n", total %% 4294967296))
}

read_file()
