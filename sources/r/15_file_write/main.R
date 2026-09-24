# task 15 file_write — expected output: 104857600
# build: Rscript main.R    run: Rscript main.R
#
# The buffer is the 1 MiB pattern 0,1,2,...,255 repeated 4096 times, written
# 100 times to out.bin. flush() pushes R's buffer down to the OS and close()
# closes the connection; the byte count is printed after both.

write_file <- function() {
  buf <- as.raw(rep(0:255, 4096))
  con <- file("out.bin", "wb")
  written <- 0
  i <- 0
  while (i < 100) {
    writeBin(buf, con)
    written <- written + length(buf)
    i <- i + 1
  }
  flush(con)
  close(con)
  cat(sprintf("%.0f\n", written))
}

write_file()
