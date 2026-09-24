! task 08 average — expected output: 0.498046875
! build: gfortran -O3 -o prog main.f90 (flang -O3 -o prog main.f90)    run: ./prog

program main
  implicit none
  integer(kind=8) :: i
  real(kind=8) :: total, reading

  total = 0.0d0
  do i = 0_8, 99999999_8
    reading = real(mod(i, 256_8), kind=8)/256.0d0
    total = total + reading
  end do

  write(*,'(f0.9)') total/100000000.0d0
end program main
