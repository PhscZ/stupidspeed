! task 15 file_write — expected output: 419430400
! build: gfortran -O3 -o prog 15_file_write.f90 (flang -O3 -o prog 15_file_write.f90)    run: ./prog
!
! One mebibyte per write, unformatted stream.  Fortran's standard library has
! no fsync binding, so flush (which pushes the buffer to the operating system)
! followed by close is the strongest durability the language offers.  The
! 50 MiB pass is repeated 8 times; each pass reopens out.bin with
! status='replace' (truncating it at offset 0) and flushes at the end of the
! pass.

program main
  use iso_fortran_env, only: error_unit
  implicit none
  integer, parameter :: chunk = 1048576
  integer(kind=1), allocatable :: buf(:)
  integer(kind=8) :: written
  integer :: u, i, j, v
  integer(kind=8) :: ss_t0, ss_t1, ss_rate

  call system_clock(ss_t0, ss_rate)
  ! The buffer comes from the heap so the program does not depend on a
  ! generous stack limit.
  allocate(buf(chunk))

  do i = 1, chunk
    v = mod(i - 1, 256)
    if (v >= 128) v = v - 256
    buf(i) = int(v, kind=1)
  end do

  written = 0_8
  do j = 1, 8
    open(newunit=u, file='out.bin', access='stream', form='unformatted', &
         status='replace', action='write')
    do i = 1, 50
      write(u) buf
      written = written + int(chunk, kind=8)
    end do
    flush(u)
    close(u)
  end do

  call system_clock(ss_t1)
  write(error_unit,'(a,i0)') 'TIME_MS=', (ss_t1 - ss_t0) * 1000_8 / ss_rate
  write(*,'(i0)') written
end program main
