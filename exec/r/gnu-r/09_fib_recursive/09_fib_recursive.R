# task 09 fib_recursive — expected output: 102334155
# build: Rscript 09_fib_recursive.R    run: Rscript 09_fib_recursive.R
#
# Naive recursion, no memoisation: about 331 million calls for fib(40). R's
# interpreter makes each call expensive, so this task is expected to be very
# slow; that is a legitimate result, not a bug.

t0 <- proc.time()[["elapsed"]]

fib <- function(n) {
  if (n < 2) return(n)
  fib(n - 1) + fib(n - 2)
}

v <- fib(40)
cat(sprintf("TIME_MS=%.3f\n", (proc.time()[["elapsed"]] - t0) * 1000), file = stderr())
cat(sprintf("%.0f\n", v))
