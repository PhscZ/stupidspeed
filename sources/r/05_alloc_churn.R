# task 05 alloc_churn — expected output: 1274991808
# build: Rscript 05_alloc_churn.R    run: Rscript 05_alloc_churn.R
#
# raw(64) is 64 real bytes. R has no references: the list assignment keeps the
# buffer reachable and drops the one it replaces, and R copies on modify, so
# every iteration really does allocate a fresh 64-byte object and abandon the
# old one to the garbage collector.

alloc_churn <- function() {
  total <- 0
  slots <- vector("list", 256)
  i <- 0
  while (i < 10000000) {
    buf <- raw(64)
    buf[1] <- as.raw(as.integer(i %% 256))
    total <- total + as.integer(buf[1])
    slots[[as.integer(i %% 256) + 1]] <- buf
    i <- i + 1
  }
  cat(sprintf("%.0f\n", total))
}

alloc_churn()
