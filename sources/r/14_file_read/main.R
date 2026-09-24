# task 14 file_read — expected output: 484442112
# build: Rscript main.R    run: Rscript main.R
#
# data.bin is 104857600 bytes, the bytes 0..255 repeating, opened from the
# working directory and read in 1 MiB chunks, never a byte per syscall. R has
# no per-byte loop worth running, so each chunk is summed vectorised; the
# accumulation is exact because the total before the modulus (13369344000)
# is far below 2^53. The modulus is taken once, at the end.

read_file <- function() {
  con <- file("data.bin", "rb")
  total <- 0
  repeat {
    chunk <- readBin(con, "raw", n = 1048576)
    if (length(chunk) == 0) break
    total <- total + sum(as.integer(chunk))
    if (length(chunk) < 1048576) break
  }
  close(con)
  cat(sprintf("%.0f\n", total %% 4294967296))
}

read_file()
