! task 02 switch_case — expected output: 7500000075000000
! build: gfortran -O3 -o prog main.f90 (flang -O3 -o prog main.f90)    run: ./prog

program main
  implicit none
  integer(kind=8) :: acc, i

  acc = 0_8
  do i = 0_8, 99999999_8
    select case (mod(i, 4_8))
    case (0_8)
      acc = acc + 1_8
    case (1_8)
      acc = acc + i
    case (2_8)
      acc = acc + 2_8*i
    case (3_8)
      acc = acc + 3_8*i
    end select
  end do

  write(*,'(i0)') acc
end program main
