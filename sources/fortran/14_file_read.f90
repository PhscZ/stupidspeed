! task 14 file_read — expected output: 484442112
! build: gfortran -O3 -o prog 14_file_read.f90 (flang -O3 -o prog 14_file_read.f90)    run: ./prog
!
! One mebibyte per read, unformatted stream, so no syscall per byte.  The
! bytes are read into a signed one-byte array, and iand turns the negative
! half of that range back into the unsigned byte value.

program main
  implicit none
  integer, parameter :: chunk = 1048576
  integer(kind=1), allocatable :: buf(:)
  integer(kind=8) :: total, i
  integer :: u, ios

  ! The buffer comes from the heap so the program does not depend on a
  ! generous stack limit.
  allocate(buf(chunk))

  open(newunit=u, file='data.bin', access='stream', form='unformatted', &
       status='old', action='read')

  total = 0_8
  do
    ! The section, not the allocatable itself, is the input item, so no
    ! reallocation rule can ever change the buffer size under the loop.
    read(u, iostat=ios) buf(1:chunk)
    if (ios /= 0) exit
    do i = 1_8, int(chunk, kind=8)
      total = total + iand(int(buf(i), kind=8), 255_8)
    end do
  end do
  close(u)

  write(*,'(i0)') mod(total, 4294967296_8)
end program main
