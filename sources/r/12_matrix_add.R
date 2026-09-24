# task 12 matrix_add — expected output: 999000000
# build: Rscript 12_matrix_add.R    run: Rscript 12_matrix_add.R
#
# Flat numeric(n * n) vectors with the 1-based index i * n + j + 1, which is
# the same layout as the i * n + j the other languages use.

matrix_add <- function() {
  n <- 1000
  A <- numeric(n * n)
  B <- numeric(n * n)
  i <- 0
  while (i < n) {
    j <- 0
    while (j < n) {
      k <- i * n + j + 1
      A[k] <- i + j
      B[k] <- i - j
      j <- j + 1
    }
    i <- i + 1
  }
  C <- numeric(n * n)
  i <- 0
  while (i < n) {
    j <- 0
    while (j < n) {
      k <- i * n + j + 1
      C[k] <- A[k] + B[k]
      j <- j + 1
    }
    i <- i + 1
  }
  total <- 0
  k <- 0
  while (k < n * n) {
    total <- total + C[k + 1]
    k <- k + 1
  }
  cat(sprintf("%.0f\n", total))
}

matrix_add()
