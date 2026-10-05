! task 14 file_read — expected output: 2389704704
! build: gfortran -O3 -o prog 14_file_read.f90 (flang -O3 -o prog 14_file_read.f90)    run: ./prog
!
! One mebibyte per read, unformatted stream, so no syscall per byte.  The
! bytes are read into a signed one-byte array, and iand turns the negative
! half of that range back into the unsigned byte value.

program main
  use iso_fortran_env, only: error_unit
  implicit none
  integer, parameter :: chunk = 1048576
  integer(kind=1), allocatable :: buf(:)
  integer(kind=1) :: one
  integer(kind=8) :: total, done, i
  integer :: u, ios
  integer(kind=8) :: ss_t0, ss_t1, ss_rate

  call system_clock(ss_t0, ss_rate)
  ! The buffer comes from the heap so the program does not depend on a
  ! generous stack limit.
  allocate(buf(chunk))

  open(newunit=u, file='data.bin', access='stream', form='unformatted', &
       status='old', action='read')

  total = 0_8
  done = 0_8
  do
    ! The section, not the allocatable itself, is the input item, so no
    ! reallocation rule can ever change the buffer size under the loop.
    read(u, iostat=ios) buf(1:chunk)
    if (ios /= 0) exit
    do i = 1_8, int(chunk, kind=8)
      total = total + iand(int(buf(i), kind=8), 255_8)
    end do
    done = done + int(chunk, kind=8)
  end do

  ! A block shorter than the buffer sets the end-of-file status with the leading
  ! elements already transferred but no count, so the tail is read back one byte at a
  ! time from the last whole block. size= is not available here: the standard only
  ! allows it alongside advance=, which an unformatted stream read rejects. The 50 MiB
  ! fixture is a whole number of blocks, so this pass reads nothing.
  if (ios < 0 .and. done > 0_8) then
    close(u)
    open(newunit=u, file='data.bin', access='stream', form='unformatted', &
         status='old', action='read')
    read(u, pos=done + 1_8)
    do
      read(u, iostat=ios) one
      if (ios /= 0) exit
      total = total + iand(int(one, kind=8), 255_8)
    end do
  end if
  close(u)

  call system_clock(ss_t1)
  write(error_unit,'(a,i0)') 'TIME_MS=', (ss_t1 - ss_t0) * 1000_8 / ss_rate
  write(*,'(i0)') mod(total, 4294967296_8)
end program main
