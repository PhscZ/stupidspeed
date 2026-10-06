NB. task 08 average — expected output: 0.498046875
NB. build: none (interpreted)    run: jconsole.exe 08_average.ijs
NB. note: J's default print precision is 6 significant digits, so ": alone would
NB.       print 0.498047. The fit form (":!.12) raises the precision for this one
NB.       value and prints the exact double.
NB. note: every partial sum is a multiple of 1/256 and stays below 2^34, so all of
NB.       them are exact in a double and the total does not depend on the order of
NB.       the additions.
NB. note: while., not for_i. i. 100000000, for the reason in 01_branches.ijs.

t0 =: 6!:1 ''

average =: 3 : 0
  total =. 0.0
  i =. 0
  while. i < 100000000 do.
    reading =. (256 | i) % 256.0
    total =. total + reading
    i =. i + 1
  end.
  (":!.12) total % 100000000
)

res =: average''
t1 =: 6!:1 ''
stderr 'TIME_MS=', (": (t1 - t0) * 1000)

stdout res, LF
exit 0
