# task 06 char_count — expected output: 10000000
# build: Rscript main.R    run: Rscript main.R
#
# The 100 MB text is built once by strrep, before the scan, never by appending.
# R has no character type: substr(text, i, i) is the per-character step, which
# makes a hundred million one-character strings. This task is expected to be
# very slow and may hit the 300 s timeout; that is a legitimate result, not a bug.

char_count <- function() {
  text <- strrep("abcdefghij", 10000000)
  n <- nchar(text)
  count <- 0
  i <- 1
  while (i <= n) {
    ch <- substr(text, i, i)
    if (ch == "a") {
      # skip
    } else if (ch == "e") {
      # skip
    } else if (ch == "h") {
      count <- count + 1
    }
    i <- i + 1
  }
  cat(sprintf("%.0f\n", count))
}

char_count()
