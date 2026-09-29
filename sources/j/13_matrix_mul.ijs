NB. task 13 matrix_mul — expected output: 599995000
NB. build: none (interpreted)    run: jconsole.exe 13_matrix_mul.ijs
NB. note: flat n*n integer lists and a plain i, j, k triple loop in that order,
NB.       exactly as sources/c/13_matrix_mul.c writes it; C is filled one element
NB.       at a time with in-place amend and the final total is an accumulating
NB.       loop. No +/ . * (matrix product) anywhere in the timed path.
NB. note: every index is parenthesised as ((i * n) + k) because J evaluates right
NB.       to left and i * n + k would be i * (n + k); see 12_matrix_add.ijs.

matrix_mul =: 3 : 0
  n =. 500
  elems =. n * n
  A =. elems $ 0
  B =. elems $ 0
  C =. elems $ 0
  i =. 0
  while. i < n do.
    j =. 0
    while. j < n do.
      A =. (7 | i + j) ((i * n) + j)} A
      B =. (5 | i * j) ((i * n) + j)} B
      j =. j + 1
    end.
    i =. i + 1
  end.
  i =. 0
  while. i < n do.
    j =. 0
    while. j < n do.
      sum =. 0
      k =. 0
      while. k < n do.
        sum =. sum + (((i * n) + k) { A) * ((k * n) + j) { B
        k =. k + 1
      end.
      C =. sum ((i * n) + j)} C
      j =. j + 1
    end.
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

stdout (matrix_mul''), LF
exit 0
