! task 03 func_sum — expected output: 100000000
! build: gfortran -O3 -o prog main.f90 add_one.f90 (flang -O3 -o prog main.f90 add_one.f90)    run: ./prog
!
! add_one sits in its own file: cross-file inlining needs link-time
! optimization, which is off here, so the hundred million calls really happen.

program main
  implicit none
  integer(kind=8) :: value, i
  integer(kind=8), external :: add_one

  value = 0_8
  do i = 1_8, 100000000_8
    value = add_one(value)
  end do

  write(*,'(i0)') value
end program main
