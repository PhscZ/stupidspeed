! task 12 matrix_add — expected output: 999000000
! build: gfortran -O3 -o prog 12_matrix_add.f90 (flang -O3 -o prog 12_matrix_add.f90)    run: ./prog
!
! Flat arrays with the index i*n + j + 1, because Fortran subscripts are
! 1-based and one contiguous array is what the memory bandwidth is about.

program main
  implicit none
  integer, parameter :: n = 1000
  integer(kind=8), allocatable :: a(:), b(:), c(:)
  integer(kind=8) :: total, i, j, idx

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

  write(*,'(i0)') total
end program main
