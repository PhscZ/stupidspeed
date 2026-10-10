! task 06 char_count — expected output: 10000000
! build: gfortran -O3 -o prog 06_char_count.f90 (flang -O3 -o prog 06_char_count.f90)    run: ./prog
!
! The hundred megabyte text is built in one operation with repeat, never by
! appending in a loop, so the build is not part of the measurement.
! timing: system_clock is the Fortran standard clock, read as a count and a count rate so
!         the difference converts to milliseconds exactly; TIME_MS is written to error_unit
!         (stderr) and stdout is unchanged.

program main
  use iso_fortran_env, only: error_unit
  implicit none
  character(len=10), parameter :: block = 'abcdefghij'
  character(len=:), allocatable :: text
  character(len=1) :: ch
  integer(kind=8) :: count, i, n
  integer(kind=8) :: ss_t0, ss_t1, ss_rate

  call system_clock(ss_t0, ss_rate)
  text = repeat(block, 10000000)
  n = int(len(text), kind=8)

  count = 0_8
  do i = 1_8, n
    ch = text(i:i)
    if (ch == 'h') count = count + 1_8
  end do

  call system_clock(ss_t1)
  write(error_unit,'(a,i0)') 'TIME_MS=', (ss_t1 - ss_t0) * 1000_8 / ss_rate
  write(*,'(i0)') count
end program main
