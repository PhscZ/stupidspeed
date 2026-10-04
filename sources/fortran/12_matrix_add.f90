! task 12 matrix_add — expected output: 999000000
! build: gfortran -O3 -o prog 12_matrix_add.f90 (flang -O3 -o prog 12_matrix_add.f90)    run: ./prog
!
! Flat arrays with the index i*n + j + 1, because Fortran subscripts are
! 1-based and one contiguous array is what the memory bandwidth is about.
! timing: system_clock is the Fortran standard clock, read as a count and a count rate so
!         the difference converts to milliseconds exactly; TIME_MS is written to error_unit
!         (stderr) and stdout is unchanged.

program main
  use iso_fortran_env, only: error_unit
  implicit none
  integer, parameter :: n = 1000
  integer(kind=8), allocatable :: a(:), b(:), c(:)
  integer(kind=8) :: total, i, j, idx
  integer(kind=8) :: ss_t0, ss_t1, ss_rate

  call system_clock(ss_t0, ss_rate)
  allocate(a(n*n), b(n*n), c(n*n))
  do j = 0_8, int(n, kind=8) - 1_8
    do i = 0_8, int(n, kind=8) - 1_8
      a(i*n + j + 1_8) = i + j
      b(i*n + j + 1_8) = i - j
    end do
  end do

  do idx = 1_8, int(n, kind=8)*int(n, kind=8)
    c(idx) = a(idx) + b(idx)
  end do

  total = 0_8
  do idx = 1_8, int(n, kind=8)*int(n, kind=8)
    total = total + c(idx)
  end do

  call system_clock(ss_t1)
  write(error_unit,'(a,i0)') 'TIME_MS=', (ss_t1 - ss_t0) * 1000_8 / ss_rate
  write(*,'(i0)') total
end program main
