! task 06 char_count — expected output: 10000000
! build: gfortran -O3 -o prog 06_char_count.f90 (flang -O3 -o prog 06_char_count.f90)    run: ./prog
!
! The hundred megabyte text is built in one operation with repeat, never by
! appending in a loop, so the build is not part of the measurement.

program main
  implicit none
  character(len=10), parameter :: block = 'abcdefghij'
  character(len=:), allocatable :: text
  character(len=1) :: ch
  integer(kind=8) :: count, i, n

  text = repeat(block, 10000000)
  n = int(len(text), kind=8)

  count = 0_8
  do i = 1_8, n
    ch = text(i:i)
    if (ch == 'h') count = count + 1_8
  end do

  write(*,'(i0)') count
end program main
