! task 05 alloc_churn — expected output: 1274991808
! build: gfortran -O3 -o prog 05_alloc_churn.f90 (flang -O3 -o prog 05_alloc_churn.f90)    run: ./prog
!
! Fortran has no garbage collector, so the buffer a slot replaces is freed
! explicitly, and move_alloc hands the fresh buffer to the slot uncopied.
! timing: system_clock is the Fortran standard clock, read as a count and a count rate so
!         the difference converts to milliseconds exactly; TIME_MS is written to error_unit
!         (stderr) and stdout is unchanged.

program main
  use iso_fortran_env, only: error_unit
  implicit none
  integer, parameter :: nbytes = 64
  integer, parameter :: nslots = 256
  type :: slot_t
    character(len=nbytes), allocatable :: buf
  end type slot_t
  type(slot_t) :: slots(nslots)
  character(len=nbytes), allocatable :: buf
  integer(kind=8) :: total, i
  integer :: k
  integer(kind=8) :: ss_t0, ss_t1, ss_rate

  call system_clock(ss_t0, ss_rate)
  total = 0_8
  do i = 0_8, 9999999_8
    allocate(buf)
    buf(1:1) = achar(int(mod(i, 256_8)))
    total = total + int(iachar(buf(1:1)), kind=8)
    k = int(mod(i, 256_8)) + 1
    if (allocated(slots(k)%buf)) deallocate(slots(k)%buf)
    call move_alloc(buf, slots(k)%buf)
  end do

  call system_clock(ss_t1)
  write(error_unit,'(a,i0)') 'TIME_MS=', (ss_t1 - ss_t0) * 1000_8 / ss_rate
  write(*,'(i0)') total
end program main
