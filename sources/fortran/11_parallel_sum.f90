! task 11 parallel_sum — expected output: 7500000075000000
! build: gfortran -O3 -fopenmp -o prog 11_parallel_sum.f90 (flang -O3 -fopenmp -o prog 11_parallel_sum.f90)    run: ./prog
!
! OpenMP is the threading route here: Fortran's standard library has none.
! The four chunks are the same work as task 02, so the two are comparable.

program main
  implicit none
  integer(kind=8) :: t, i, acc, total

  total = 0_8
  !$omp parallel do reduction(+:total) private(acc, i) schedule(static)
  do t = 0_8, 3_8
    acc = 0_8
    do i = t*25000000_8, (t + 1_8)*25000000_8 - 1_8
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
    total = total + acc
  end do
  !$omp end parallel do

  write(*,'(i0)') total
end program main
