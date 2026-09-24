! task 04 array_sum — expected output: 499999500000
! build: gfortran -O3 -o prog main.f90 (flang -O3 -o prog main.f90)    run: ./prog

program main
  implicit none
  integer, parameter :: n = 1000000
  integer(kind=8), allocatable :: a(:)
  integer(kind=8) :: total, i

  allocate(a(0:n-1))
  do i = 0_8, int(n, kind=8) - 1_8
    a(i) = i
  end do

  total = 0_8
  do i = 0_8, int(n, kind=8) - 1_8
    total = total + a(i)
  end do

  write(*,'(i0)') total
end program main
