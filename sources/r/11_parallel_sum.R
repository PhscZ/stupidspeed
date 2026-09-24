# task 11 parallel_sum — expected output: 7500000075000000
# build: Rscript 11_parallel_sum.R    run: Rscript 11_parallel_sum.R
#
# R has no threads: plain R code never runs on two threads. The bundled
# parallel package's PSOCK cluster is the mechanism the benchmark sanctions
# here, so this is four separate R processes over sockets, not four threads.
# PSOCK workers start with an empty environment, so N is exported to them.

N <- 25000000

cl <- parallel::makeCluster(4, type = "PSOCK")
parallel::clusterExport(cl, varlist = c("N"))
parts <- parallel::parSapply(cl, 0:3, function(t) {
  acc <- 0
  i <- t * N
  end <- i + N
  while (i < end) {
    acc <- acc + switch(as.integer(i %% 4) + 1, 1, i, 2 * i, 3 * i)
    i <- i + 1
  }
  acc
})
parallel::stopCluster(cl)

cat(sprintf("%.0f\n", sum(parts)))
