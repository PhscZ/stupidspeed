! task 01 branches — expected output: 33333334 13333333 7619048 45714285
! build: gfortran -O3 -o prog 01_branches.f90 (flang -O3 -o prog 01_branches.f90)    run: ./prog
! timing: system_clock is the Fortran standard clock, read as a count and a count rate so
!         the difference converts to milliseconds exactly; TIME_MS is written to error_unit
!         (stderr) and stdout is unchanged.

program main
  use iso_fortran_env, only: error_unit
  implicit none
  integer(kind=8) :: a, b, c, d, i
  integer(kind=8) :: ss_t0, ss_t1, ss_rate

  call system_clock(ss_t0, ss_rate)
  a = 0_8
  b = 0_8
  c = 0_8
  d = 0_8
  do i = 0_8, 99999999_8
    if (mod(i, 3_8) == 0_8) then
      a = a + 1_8
    else if (mod(i, 5_8) == 0_8) then
      b = b + 1_8
    else if (mod(i, 7_8) == 0_8) then
      c = c + 1_8
    else
      d = d + 1_8
    end if
  end do

  call system_clock(ss_t1)
  write(error_unit,'(a,i0)') 'TIME_MS=', (ss_t1 - ss_t0) * 1000_8 / ss_rate
  write(*,'(i0,1x,i0,1x,i0,1x,i0)') a, b, c, d
end program main
