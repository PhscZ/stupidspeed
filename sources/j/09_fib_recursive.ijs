NB. task 09 fib_recursive — expected output: 102334155
NB. build: none (interpreted)    run: jconsole.exe 09_fib_recursive.ijs
NB. note: the naive double recursion is written literally. J does not compile
NB.       explicit definitions, so every one of the ~331 million calls is an
NB.       interpreted call; that is the honest shape of this cell and the reason
NB.       it is the slowest in the row.

__t0 =: 6!:1 ''

fib =: 3 : 0
  if. y < 2 do.
    y
  else.
    (fib y - 1) + fib y - 2
  end.
)

__t1 =: 6!:1 ''
stderr 'TIME_MS=', (": (__t1 - __t0) * 1000)

stdout (": fib 40), LF
exit 0
