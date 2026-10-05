! task 04 array_sum — expected output: 499999500000
! build: gfortran -O3 -o prog 04_array_sum.f90 (flang -O3 -o prog 04_array_sum.f90)    run: ./prog
! timing: system_clock is the Fortran standard clock, read as a count and a count rate so
!         the difference converts to milliseconds exactly; TIME_MS is written to error_unit
!         (stderr) and stdout is unchanged.

program main
  use iso_fortran_env, only: error_unit
  implicit none
  integer, parameter :: n = 1000000
  integer(kind=8), allocatable :: a(:)
  integer(kind=8) :: total, i
  integer(kind=8) :: ss_t0, ss_t1, ss_rate

  call system_clock(ss_t0, ss_rate)
  allocate(a(0:n-1))
  do i = 0_8, int(n, kind=8) - 1_8
    a(i) = i
  end do

  total = 0_8
  do i = 0_8, int(n, kind=8) - 1_8
    total = total + a(i)
  end do

  call system_clock(ss_t1)
  write(error_unit,'(a,i0)') 'TIME_MS=', (ss_t1 - ss_t0) * 1000_8 / ss_rate
  write(*,'(i0)') total
end program main
