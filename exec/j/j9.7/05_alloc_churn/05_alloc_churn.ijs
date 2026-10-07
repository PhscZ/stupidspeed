NB. task 05 alloc_churn — expected output: 1274991808
NB. build: none (interpreted)    run: jconsole.exe 05_alloc_churn.ijs
NB. note: the buffer is a real 64-byte byte array (64 $ ' '), the analogue of the
NB.       Python row's bytearray(64); J's literal precision is one byte per atom.
NB.       byte 0 is written with (a. {~ 256|i) and read back with a. i. {. buf.
NB. note: the slots list is boxed, so the buffer is stored with (<buf) (256|i)} slots
NB.       and the previous occupant of that slot is dropped. The amend is in place
NB.       because the same name is on both sides.
NB. note: while., not for_i. i. 10000000, for the reason in 01_branches.ijs.

t0 =: 6!:1 ''

alloc_churn =: 3 : 0
  slots =. 256 $ a:
  total =. 0
  i =. 0
  while. i < 10000000 do.
    buf =. 64 $ ' '
    buf =. (a. {~ 256 | i) 0} buf
    total =. total + a. i. {. buf
    slots =. (<buf) (256 | i)} slots
    i =. i + 1
  end.
  ": total
)

res =: alloc_churn''
t1 =: 6!:1 ''
stderr 'TIME_MS=', (": (t1 - t0) * 1000)

stdout res, LF
exit 0
