! task 09 fib_recursive — expected output: 102334155
! build: gfortran -O3 -o prog 09_fib_recursive.f90 (flang -O3 -o prog 09_fib_recursive.f90)    run: ./prog
! timing: system_clock is the Fortran standard clock, read as a count and a count rate so
!         the difference converts to milliseconds exactly; TIME_MS is written to error_unit
!         (stderr) and stdout is unchanged.

program main
  use iso_fortran_env, only: error_unit
  implicit none
  integer(kind=8), external :: fib
  integer(kind=8) :: ss_t0, ss_t1, ss_rate, ss_r

  call system_clock(ss_t0, ss_rate)
  ss_r = fib(40_8)
  call system_clock(ss_t1)
  write(error_unit,'(a,i0)') 'TIME_MS=', (ss_t1 - ss_t0) * 1000_8 / ss_rate
  write(*,'(i0)') ss_r
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
