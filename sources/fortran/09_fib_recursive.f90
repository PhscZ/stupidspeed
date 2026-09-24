! task 09 fib_recursive — expected output: 102334155
! build: gfortran -O3 -o prog 09_fib_recursive.f90 (flang -O3 -o prog 09_fib_recursive.f90)    run: ./prog

program main
  implicit none
  integer(kind=8), external :: fib

  write(*,'(i0)') fib(40_8)
end program main

recursive function fib(n) result(r)
  implicit none
  integer(kind=8), intent(in) :: n
  integer(kind=8) :: r

  if (n < 2_8) then
    r = n
  else
    r = fib(n - 1_8) + fib(n - 2_8)
  end if
end function fib
