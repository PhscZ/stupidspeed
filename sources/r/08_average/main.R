# task 08 average — expected output: 0.498046875
# build: Rscript main.R    run: Rscript main.R
#
# Every reading is a multiple of 1/256 and the total stays far below 2^53, so
# the sum is exact. %.9f prints it as an exact decimal: no exponent, no
# trailing zeros, no locale separators.

average <- function() {
  total <- 0
  i <- 0
  while (i < 100000000) {
    reading <- (i %% 256) / 256
    total <- total + reading
    i <- i + 1
  }
  cat(sprintf("%.9f\n", total / 100000000))
}

average()
