# task 07 string_append — expected output: 1000000
# build: Rscript 07_string_append.R    run: Rscript 07_string_append.R
#
# paste0() allocates a fresh string holding both arguments, so this is the
# plain quadratic append the task asks for: R has no growable string type.

string_append <- function() {
  text <- ""
  i <- 0
  while (i < 1000000) {
    text <- paste0(text, "x")
    i <- i + 1
  }
  cat(sprintf("%.0f\n", nchar(text)))
}

string_append()
