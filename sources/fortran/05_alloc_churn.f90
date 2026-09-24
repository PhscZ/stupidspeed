! task 05 alloc_churn — expected output: 1274991808
! build: gfortran -O3 -o prog 05_alloc_churn.f90 (flang -O3 -o prog 05_alloc_churn.f90)    run: ./prog
!
! Fortran has no garbage collector, so the buffer a slot replaces is freed
! explicitly, and move_alloc hands the fresh buffer to the slot uncopied.

program main
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

  total = 0_8
  do i = 0_8, 9999999_8
    allocate(buf)
    buf(1:1) = achar(int(mod(i, 256_8)))
    total = total + int(iachar(buf(1:1)), kind=8)
    k = int(mod(i, 256_8)) + 1
    if (allocated(slots(k)%buf)) deallocate(slots(k)%buf)
    call move_alloc(buf, slots(k)%buf)
  end do

  write(*,'(i0)') total
end program main
