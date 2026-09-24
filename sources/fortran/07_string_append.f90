! task 07 string_append — expected output: 1000000
! build: gfortran -O3 -o prog 07_string_append.f90 (flang -O3 -o prog 07_string_append.f90)    run: ./prog
!
! Plain character concatenation: Fortran strings are not growable, so each
! of the million appends allocates a new string and copies the old one.

program main
  implicit none
  character(len=:), allocatable :: text
  integer(kind=8) :: i

  text = ''
  do i = 1_8, 1000000_8
    text = text // 'x'
  end do

  write(*,'(i0)') len(text)
end program main
