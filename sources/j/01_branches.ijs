NB. task 01 branches — expected output: 33333334 13333333 7619048 45714285
NB. build: none (interpreted)    run: jconsole.exe 01_branches.ijs
NB. note: while., not for_i. i. 100000000: for_i. materialises the 800 MB index
NB.       vector before the first iteration, the same trap the R row records.
NB. note: the four counters are machine integers (J's integer, 64-bit here), so the
NB.       counts are exact. They are printed one atom at a time: ": on the whole
NB.       list pads every number to a common width and would not match the line.

branches =: 3 : 0
  a =. 0
  b =. 0
  c =. 0
  d =. 0
  i =. 0
  while. i < 100000000 do.
    if. 0 = 3 | i do.
      a =. a + 1
    elseif. 0 = 5 | i do.
      b =. b + 1
    elseif. 0 = 7 | i do.
      c =. c + 1
    else.
      d =. d + 1
    end.
    i =. i + 1
  end.
  (": a) , ' ' , (": b) , ' ' , (": c) , ' ' , ": d
)

stdout (branches''), LF
exit 0
