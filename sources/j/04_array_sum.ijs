NB. task 04 array_sum — expected output: 499999500000
NB. build: none (interpreted)    run: jconsole.exe 04_array_sum.ijs
NB. note: the array is allocated with reshape and filled one element at a time in
NB.       an explicit while. loop with in-place amend (arr =: i i} arr). J applies
NB.       the amend in place because the same name is on both sides, so no copy of
NB.       the million-element array is made per iteration. The sum is a plain
NB.       accumulating loop, not +/ arr.

array_sum =: 3 : 0
  arr =. 1000000 $ 0
  i =. 0
  while. i < 1000000 do.
    arr =. i i} arr
    i =. i + 1
  end.
  total =. 0
  i =. 0
  while. i < 1000000 do.
    total =. total + i { arr
    i =. i + 1
  end.
  ": total
)

stdout (array_sum''), LF
exit 0
