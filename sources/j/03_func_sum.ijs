NB. task 03 func_sum — expected output: 100000000
NB. build: none (interpreted)    run: jconsole.exe 03_func_sum.ijs
NB. note: the helper lives in AddOne.ijs and is loaded at run time with 0!:0,
NB.       which is J's "load this script" foreign. J is interpreted and has no
NB.       no-inline marker: explicit definitions are parsed line by line on every
NB.       execution, so there is nothing for a compiler to inline away. Measured,
NB.       the call is real -- 100000000 calls take 47.1 s here (0.47 us per
NB.       call), against 0.43 us per iteration for the same-count plain loop in
NB.       02_switch_case.ijs, and the difference is the interpretive call
NB.       overhead rather than a folded-away add. The README allows this
NB.       disclosure for interpreted rows.
NB. note: while., not for_i. i. 100000000, for the reason in 01_branches.ijs.

0!:0 <'AddOne.ijs'

func_sum =: 3 : 0
  value =. 0
  i =. 0
  while. i < 100000000 do.
    value =. add_one value
    i =. i + 1
  end.
  ": value
)

stdout (func_sum''), LF
exit 0
