! task 15 file_write — expected output: 104857600
! build: gfortran -O3 -o prog main.f90 (flang -O3 -o prog main.f90)    run: ./prog
!
! One mebibyte per write, unformatted stream.  Fortran's standard library has
! no fsync binding, so flush (which pushes the buffer to the operating system)
! followed by close is the strongest durability the language offers.

program main
  implicit none
  integer, parameter :: chunk = 1048576
  integer(kind=1), allocatable :: buf(:)
  integer(kind=8) :: written
  integer :: u, i, v

  ! The buffer comes from the heap so the program does not depend on a
  ! generous stack limit.
  allocate(buf(chunk))

  do i = 1, chunk
    v = mod(i - 1, 256)
    if (v >= 128) v = v - 256
    buf(i) = int(v, kind=1)
  end do

  open(newunit=u, file='out.bin', access='stream', form='unformatted', &
       status='replace', action='write')

  written = 0_8
  do i = 1, 100
    write(u) buf
    written = written + int(chunk, kind=8)
  end do
  flush(u)
  close(u)

  write(*,'(i0)') written
end program main
