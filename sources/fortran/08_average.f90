! task 08 average — expected output: 0.498046875
! build: gfortran -O3 -o prog 08_average.f90 (flang -O3 -o prog 08_average.f90)    run: ./prog
! timing: system_clock is the Fortran standard clock, read as a count and a count rate so
!         the difference converts to milliseconds exactly; TIME_MS is written to error_unit
!         (stderr) and stdout is unchanged.
! note: the format is f11.9, not f0.9. gfortran's minimal-width F edit descriptor drops the
!       leading zero for values below 1 (it prints ".498046875"), which does not match the
!       expected line; an explicit width of 11 pins the leading zero.

program main
  use iso_fortran_env, only: error_unit
  implicit none
  integer(kind=8) :: i
  real(kind=8) :: total, reading
  integer(kind=8) :: ss_t0, ss_t1, ss_rate

  call system_clock(ss_t0, ss_rate)
  total = 0.0d0
  do i = 0_8, 99999999_8
    reading = real(mod(i, 256_8), kind=8)/256.0d0
    total = total + reading
  end do

  call system_clock(ss_t1)
  write(error_unit,'(a,i0)') 'TIME_MS=', (ss_t1 - ss_t0) * 1000_8 / ss_rate
  write(*,'(f11.9)') total/100000000.0d0
end program main
