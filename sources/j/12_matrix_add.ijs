NB. task 12 matrix_add — expected output: 999000000
NB. build: none (interpreted)    run: jconsole.exe 12_matrix_add.ijs
NB. note: the matrices are flat million-element integer lists, filled and read one
NB.       element at a time in explicit nested while. loops with in-place amend
NB.       (A =: value ((i * n) + j)} A). The addition is an element-wise loop and
NB.       the final total is an accumulating loop, never +/ C.
NB. note: J evaluates right to left, so the index is written ((i * n) + j): the
NB.       unparenthesised i * n + j is i * (n + j). Every index in this row and in
NB.       13_matrix_mul.ijs is parenthesised for that reason.

__t0 =: 6!:1 ''

matrix_add =: 3 : 0
  n =. 1000
  elems =. n * n
  A =. elems $ 0
  B =. elems $ 0
  C =. elems $ 0
  i =. 0
  while. i < n do.
    j =. 0
    while. j < n do.
      A =. (i + j) ((i * n) + j)} A
      B =. (i - j) ((i * n) + j)} B
      j =. j + 1
    end.
    i =. i + 1
  end.
  i =. 0
  while. i < elems do.
    C =. ((i { A) + i { B) i} C
    i =. i + 1
  end.
  total =. 0
  i =. 0
  while. i < elems do.
    total =. total + i { C
    i =. i + 1
  end.
  ": total
)

__t1 =: 6!:1 ''
stderr 'TIME_MS=', (": (__t1 - __t0) * 1000)

stdout (matrix_add''), LF
exit 0
