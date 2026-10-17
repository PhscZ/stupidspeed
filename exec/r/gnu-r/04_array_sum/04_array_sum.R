# task 04 array_sum — expected output: 599999940000000
# build: Rscript 04_array_sum.R    run: Rscript 04_array_sum.R
#
# R indexes from 1, so array[i] is array[i + 1] here. numeric() gives a
# double vector, which holds all ten million values exactly.

array_sum <- function() {
  t0 <- proc.time()[["elapsed"]]
  n <- 10000000
  array <- numeric(n)
  i <- 0
  while (i < n) {
    array[i + 1] <- i
    i <- i + 1
  }
  total <- 0
  for (pass in 1:12) {
    i <- 0
    while (i < n) {
      total <- total + array[i + 1]
      i <- i + 1
    }
  }
  cat(sprintf("TIME_MS=%.3f\n", (proc.time()[["elapsed"]] - t0) * 1000), file = stderr())
  cat(sprintf("%.0f\n", total))
}

array_sum()
