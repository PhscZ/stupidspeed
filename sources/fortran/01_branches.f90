! task 01 branches — expected output: 33333334 13333333 7619048 45714285
! build: gfortran -O3 -o prog 01_branches.f90 (flang -O3 -o prog 01_branches.f90)    run: ./prog

program main
  implicit none
  integer(kind=8) :: a, b, c, d, i

  a = 0_8
  b = 0_8
  c = 0_8
  d = 0_8
  do i = 0_8, 99999999_8
    if (mod(i, 3_8) == 0_8) then
      a = a + 1_8
    else if (mod(i, 5_8) == 0_8) then
      b = b + 1_8
    else if (mod(i, 7_8) == 0_8) then
      c = c + 1_8
    else
      d = d + 1_8
    end if
  end do

  write(*,'(i0,1x,i0,1x,i0,1x,i0)') a, b, c, d
end program main
