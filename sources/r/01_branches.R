# task 01 branches — expected output: 33333334 13333333 7619048 45714285
# build: Rscript 01_branches.R    run: Rscript 01_branches.R
#
# while, not for: for (i in 0:99999999) materialises a 400 MB integer vector
# before the first iteration. Counters are doubles; R has no 64-bit integers
# and every value here is exact in a double.

branches <- function() {
  a <- 0
  b <- 0
  c <- 0
  d <- 0
  i <- 0
  while (i < 100000000) {
    if (i %% 3 == 0) {
      a <- a + 1
    } else if (i %% 5 == 0) {
      b <- b + 1
    } else if (i %% 7 == 0) {
      c <- c + 1
    } else {
      d <- d + 1
    }
    i <- i + 1
  }
  cat(sprintf("%.0f %.0f %.0f %.0f\n", a, b, c, d))
}

branches()
