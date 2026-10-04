! task 07 string_append — expected output: 250000
! build: gfortran -O3 -o prog 07_string_append.f90 (flang -O3 -o prog 07_string_append.f90)    run: ./prog
!
! Plain character concatenation: Fortran strings are not growable, so each
! of the 250000 appends allocates a new string and copies the old one.
! timing: system_clock is the Fortran standard clock, read as a count and a count rate so
!         the difference converts to milliseconds exactly; TIME_MS is written to error_unit
!         (stderr) and stdout is unchanged.

program main
  use iso_fortran_env, only: error_unit
  implicit none
  character(len=:), allocatable :: text
  integer(kind=8) :: i
  integer(kind=8) :: ss_t0, ss_t1, ss_rate

  call system_clock(ss_t0, ss_rate)
  text = ''
  do i = 1_8, 250000_8
    text = text // 'x'
  end do

  call system_clock(ss_t1)
  write(error_unit,'(a,i0)') 'TIME_MS=', (ss_t1 - ss_t0) * 1000_8 / ss_rate
  write(*,'(i0)') len(text)
end program main
