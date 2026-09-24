# task 02 switch_case — expected output: 7500000075000000
# build: Rscript 02_switch_case.R    run: Rscript 02_switch_case.R
#
# switch() is R's real multi-way branch, and only the selected alternative is
# evaluated, so this is a jump table and not an if-chain (that is task 01).

switch_case <- function() {
  acc <- 0
  i <- 0
  while (i < 100000000) {
    acc <- acc + switch(as.integer(i %% 4) + 1, 1, i, 2 * i, 3 * i)
    i <- i + 1
  }
  cat(sprintf("%.0f\n", acc))
}

switch_case()
