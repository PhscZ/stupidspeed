NB. task 10 pi — expected output: 4470
NB. build: none (interpreted)    run: jconsole.exe 10_pi.ijs
NB. note: Gibbons' unbounded spigot, the same state machine as sources/c/10_pi.c
NB.       (state q,r,t; k,l,n; test 4q+r < (n+1)t; sum the first 1000 emitted
NB.       digits), but on J's extended integers instead of hand-rolled limbs.
NB.       Extended precision has been GMP-backed since J9.4, so this is the
NB.       standard-library bignum the rules prefer where one exists.
NB. note: the 1x/0x literals put the state in extended precision; + - * < and the
NB.       integer divide x <.@% y are exact on it. Every intermediate is
NB.       parenthesised because J evaluates right to left: 7 * k + 2 would be
NB.       7*(k+2), not (7*k)+2.

t0 =: 6!:1 ''

pi =: 3 : 0
  q =. 1x
  r =. 0x
  t =. 1x
  k =. 1
  l =. 3
  n =. 3
  sum =. 0
  produced =. 0
  while. produced < 1000 do.
    u =. (4 * q) + r
    v =. t * (n + 1)
    if. u < v do.
      sum =. sum + n
      produced =. produced + 1
      u =. 10 * ((3 * q) + r)
      next =. (u <.@% t) - (10 * n)
      r =. 10 * (r - (n * t))
      q =. 10 * q
      n =. next
    else.
      u =. (q * ((7 * k) + 2)) + (r * l)
      v =. t * l
      next =. u <.@% v
      r =. ((2 * q) + r) * l
      q =. q * k
      t =. t * l
      k =. k + 1
      l =. l + 2
      n =. next
    end.
  end.
  ": sum
)

res =: pi''
t1 =: 6!:1 ''
stderr 'TIME_MS=', (": (t1 - t0) * 1000)

stdout res, LF
exit 0
