# task 07 string_append — expected output: 250000
# build: Rscript 07_string_append.R    run: Rscript 07_string_append.R
#
# paste0() allocates a fresh string holding both arguments, so this is the
# plain quadratic append the task asks for: R has no growable string type.

string_append <- function() {
  t0 <- proc.time()[["elapsed"]]
  text <- ""
  i <- 0
  while (i < 250000) {
    text <- paste0(text, "x")
    i <- i + 1
  }
  cat(sprintf("TIME_MS=%.3f\n", (proc.time()[["elapsed"]] - t0) * 1000), file = stderr())
  cat(sprintf("%.0f\n", nchar(text)))
}

string_append()
