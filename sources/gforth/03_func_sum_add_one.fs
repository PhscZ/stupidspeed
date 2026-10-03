\ task 03 func_sum — helper, the second file, included by 03_func_sum.fs.
\ A separate file so the call is a genuine cross-file call. gforth has no inliner that
\ would fold a colon definition away, so the call is real either way; the split is the
\ row's cross-file convention.

: add_one  ( n -- n+1 )
  1 +
;
