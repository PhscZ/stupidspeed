NB. task 02 switch_case — expected output: 7500000075000000
NB. build: none (interpreted)    run: jconsole.exe 02_switch_case.ijs
NB. note: while., not for_i. i. 100000000, for the reason in 01_branches.ijs.
NB. note: select./case. is J's switch. acc stays a machine integer; the total is
NB.       below 2^63, so it is exact and ": prints it in full.

t0 =: 6!:1 ''

switch_case =: 3 : 0
  acc =. 0
  i =. 0
  while. i < 100000000 do.
    select. 4 | i
    case. 0 do.
      acc =. acc + 1
    case. 1 do.
      acc =. acc + i
    case. 2 do.
      acc =. acc + 2 * i
    case. 3 do.
      acc =. acc + 3 * i
    end.
    i =. i + 1
  end.
  ": acc
)

res =: switch_case''
t1 =: 6!:1 ''
stderr 'TIME_MS=', (": (t1 - t0) * 1000)

stdout res, LF
exit 0
