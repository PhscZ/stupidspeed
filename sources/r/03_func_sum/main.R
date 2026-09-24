# task 03 func_sum — expected output: 100000000
# build: Rscript main.R    run: Rscript main.R
#
# R has no no-inline attribute, and it has no inliner either: a call to a
# closure is a real call through the closure every time, so a plain function
# is already a hundred million genuine calls.

add_one <- function(n) n + 1

func_sum <- function() {
  value <- 0
  i <- 0
  while (i < 100000000) {
    value <- add_one(value)
    i <- i + 1
  }
  cat(sprintf("%.0f\n", value))
}

func_sum()
