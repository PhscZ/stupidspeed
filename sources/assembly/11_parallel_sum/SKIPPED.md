# 11 parallel_sum — SKIPPED

Doing this task in raw assembly means issuing `clone` or `CreateThread` by hand and setting
up the child stacks and the memory the four workers share, which is not a traditional way to
write the task, so the benchmark records this cell as `SKIPPED`.
