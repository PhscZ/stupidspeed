! task 11 parallel_sum — expected output: 7500000075000000
! build: gfortran -O3 -fopenmp -o prog 11_parallel_sum.f90 (flang -O3 -fopenmp -o prog 11_parallel_sum.f90)    run: ./prog
!
! OpenMP is the threading route here: Fortran's standard library has none.
! The four chunks are the same work as task 02, so the two are comparable.
! timing: system_clock is the Fortran standard clock, read as a count and a count rate so
!         the difference converts to milliseconds exactly; TIME_MS is written to error_unit
!         (stderr) and stdout is unchanged. The counter brackets the parallel region.

program main
  use iso_fortran_env, only: error_unit
  implicit none
  integer(kind=8) :: t, i, acc, total
  integer(kind=8) :: ss_t0, ss_t1, ss_rate

  call system_clock(ss_t0, ss_rate)
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

  call system_clock(ss_t1)
  write(error_unit,'(a,i0)') 'TIME_MS=', (ss_t1 - ss_t0) * 1000_8 / ss_rate
  write(*,'(i0)') total
end program main
