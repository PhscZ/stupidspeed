# task 13 matrix_mul — expected output: 599995000
# build: Rscript main.R    run: Rscript main.R
#
# Plain i, j, k triple loop in that order, no reordering and no library
# multiply. Flat numeric(n * n) vectors with the 1-based index i * n + j + 1.

matrix_mul <- function() {
  n <- 500
  A <- numeric(n * n)
  B <- numeric(n * n)
  i <- 0
  while (i < n) {
    j <- 0
    while (j < n) {
      k <- i * n + j + 1
      A[k] <- (i + j) %% 7
      B[k] <- (i * j) %% 5
      j <- j + 1
    }
    i <- i + 1
  }
  C <- numeric(n * n)
  i <- 0
  while (i < n) {
    j <- 0
    while (j < n) {
      s <- 0
      k <- 0
      while (k < n) {
        s <- s + A[i * n + k + 1] * B[k * n + j + 1]
        k <- k + 1
      }
      C[i * n + j + 1] <- s
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

matrix_mul()
