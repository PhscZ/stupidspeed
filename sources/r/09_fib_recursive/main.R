# task 09 fib_recursive — expected output: 102334155
# build: Rscript main.R    run: Rscript main.R
#
# Naive recursion, no memoisation: about 331 million calls for fib(40). R's
# interpreter makes each call expensive, so this task is expected to be very
# slow and may hit the 300 s timeout; that is a legitimate result, not a bug.

fib <- function(n) {
  if (n < 2) return(n)
  fib(n - 1) + fib(n - 2)
}

cat(sprintf("%.0f\n", fib(40)))
