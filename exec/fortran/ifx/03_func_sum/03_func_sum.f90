! task 03 func_sum — expected output: 100000000
! build: gfortran -O3 -o prog 03_func_sum.f90 03_func_sum_add_one.f90 (flang -O3 -o prog 03_func_sum.f90 03_func_sum_add_one.f90)    run: ./prog
!
! add_one sits in its own file: cross-file inlining needs link-time
! optimization, which is off here, so the hundred million calls really happen.
! timing: system_clock is the Fortran standard clock, read as a count and a count rate so
!         the difference converts to milliseconds exactly; TIME_MS is written to error_unit
!         (stderr) and stdout is unchanged.

program main
  use iso_fortran_env, only: error_unit
  implicit none
  integer(kind=8) :: value, i
  integer(kind=8), external :: add_one
  integer(kind=8) :: ss_t0, ss_t1, ss_rate

  call system_clock(ss_t0, ss_rate)
  value = 0_8
  do i = 1_8, 100000000_8
    value = add_one(value)
  end do

  call system_clock(ss_t1)
  write(error_unit,'(a,i0)') 'TIME_MS=', (ss_t1 - ss_t0) * 1000_8 / ss_rate
  write(*,'(i0)') value
end program main
