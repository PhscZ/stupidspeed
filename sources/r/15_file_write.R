# task 15 file_write — expected output: 419430400
# build: Rscript 15_file_write.R    run: Rscript 15_file_write.R
#
# The buffer is the 1 MiB pattern 0,1,2,...,255 repeated 4096 times, built once and
# written 50 times per pass to out.bin, 8 passes over the file (reopened at offset 0
# each pass). flush() pushes R's buffer down to the OS and close() closes the
# connection, one flush and close per pass; the byte count is printed after all passes.

write_file <- function() {
  t0 <- proc.time()[["elapsed"]]
  buf <- as.raw(rep(0:255, 4096))
  written <- 0
  p <- 0
  while (p < 8) {
    con <- file("out.bin", "wb")
    i <- 0
    while (i < 50) {
      writeBin(buf, con)
      written <- written + length(buf)
      i <- i + 1
    }
    flush(con)
    close(con)
    p <- p + 1
  }
  cat(sprintf("TIME_MS=%.3f\n", (proc.time()[["elapsed"]] - t0) * 1000), file = stderr())
  cat(sprintf("%.0f\n", written))
}

write_file()
