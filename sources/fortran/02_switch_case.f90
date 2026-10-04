! task 02 switch_case — expected output: 7500000075000000
! build: gfortran -O3 -o prog 02_switch_case.f90 (flang -O3 -o prog 02_switch_case.f90)    run: ./prog
! timing: system_clock is the Fortran standard clock, read as a count and a count rate so
!         the difference converts to milliseconds exactly; TIME_MS is written to error_unit
!         (stderr) and stdout is unchanged.

program main
  use iso_fortran_env, only: error_unit
  implicit none
  integer(kind=8) :: acc, i
  integer(kind=8) :: ss_t0, ss_t1, ss_rate

  call system_clock(ss_t0, ss_rate)
  acc = 0_8
  do i = 0_8, 99999999_8
    select case (mod(i, 4_8))
    case (0_8)
      acc = acc + 1_8
    case (1_8)
      acc = acc + i
    case (2_8)
      acc = acc + 2_8*i
    case (3_8)
      acc = acc + 3_8*i
    end select
  end do

  call system_clock(ss_t1)
  write(error_unit,'(a,i0)') 'TIME_MS=', (ss_t1 - ss_t0) * 1000_8 / ss_rate
  write(*,'(i0)') acc
end program main
