! task 13 matrix_mul — expected output: 599995000
! build: gfortran -O3 -o prog 13_matrix_mul.f90 (flang -O3 -o prog 13_matrix_mul.f90)    run: ./prog
!
! Plain i,j,k triple loop in that order, no reordering and no library
! multiply, so the loop nest is the same one every language runs.
! timing: system_clock is the Fortran standard clock, read as a count and a count rate so
!         the difference converts to milliseconds exactly; TIME_MS is written to error_unit
!         (stderr) and stdout is unchanged.

program main
  use iso_fortran_env, only: error_unit
  implicit none
  integer, parameter :: n = 500
  integer(kind=8), allocatable :: a(:), b(:), c(:)
  integer(kind=8) :: total, i, j, k, s, idx
  integer(kind=8) :: ss_t0, ss_t1, ss_rate

  call system_clock(ss_t0, ss_rate)
  allocate(a(n*n), b(n*n), c(n*n))
  do j = 0_8, int(n, kind=8) - 1_8
    do i = 0_8, int(n, kind=8) - 1_8
      a(i*n + j + 1_8) = mod(i + j, 7_8)
      b(i*n + j + 1_8) = mod(i*j, 5_8)
    end do
  end do

  do i = 0_8, int(n, kind=8) - 1_8
    do j = 0_8, int(n, kind=8) - 1_8
      s = 0_8
      do k = 0_8, int(n, kind=8) - 1_8
        s = s + a(i*n + k + 1_8)*b(k*n + j + 1_8)
      end do
      c(i*n + j + 1_8) = s
    end do
  end do

  total = 0_8
  do idx = 1_8, int(n, kind=8)*int(n, kind=8)
    total = total + c(idx)
  end do

  call system_clock(ss_t1)
  write(error_unit,'(a,i0)') 'TIME_MS=', (ss_t1 - ss_t0) * 1000_8 / ss_rate
  write(*,'(i0)') total
end program main
