! task 03 func_sum — expected output: 100000000
! build: gfortran -O3 -o prog 03_func_sum.f90 03_func_sum_add_one.f90 (flang -O3 -o prog 03_func_sum.f90 03_func_sum_add_one.f90)    run: ./prog

integer(kind=8) function add_one(n)
  implicit none
  integer(kind=8), intent(in) :: n

  add_one = n + 1_8
end function add_one
