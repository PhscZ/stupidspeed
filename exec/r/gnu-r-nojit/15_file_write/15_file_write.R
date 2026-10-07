# task 15 file_write — expected output: 52428800
# build: Rscript 15_file_write.R    run: Rscript 15_file_write.R
#
# The buffer is the 1 MiB pattern 0,1,2,...,255 repeated 4096 times, written
# 50 times to out.bin. flush() pushes R's buffer down to the OS and close()
# closes the connection; the byte count is printed after both.

write_file <- function() {
  t0 <- proc.time()[["elapsed"]]
  buf <- as.raw(rep(0:255, 4096))
  con <- file("out.bin", "wb")
  written <- 0
  i <- 0
  while (i < 50) {
    writeBin(buf, con)
    written <- written + length(buf)
    i <- i + 1
  }
  flush(con)
  close(con)
  cat(sprintf("TIME_MS=%.3f\n", (proc.time()[["elapsed"]] - t0) * 1000), file = stderr())
  cat(sprintf("%.0f\n", written))
}

write_file()
