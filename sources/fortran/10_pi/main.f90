! task 10 pi — expected output: 44889
! build: gfortran -O3 -o prog main.f90 (flang -O3 -o prog main.f90)    run: ./prog
!
! Fortran has no arbitrary-precision integers, so Gibbons' unbounded spigot
! runs on hand-written big integers: little-endian sign-magnitude arrays of
! 64-bit limbs in base 10^9.  Only a multiply by a small integer, add,
! subtract, compare and a division whose quotient is known to be small are
! needed.  The spigot emits pi's digits one at a time; the sum of the first
! 10000 of them, the leading 3 included, is printed instead of the digits.

module bignum
  implicit none
  integer, parameter :: BASE = 1000000000_8
  ! Emitting 10000 digits peaks around 20000 limbs of base 10^9, so 32768
  ! limbs leave room to spare.
  integer, parameter :: CAP = 32768

  type :: bnum
    integer(kind=8), allocatable :: d(:)
    integer :: n
    integer :: s
  end type bnum

contains

  subroutine binit(a)
    ! The limbs live on the heap.  A fixed-size array component would make
    ! every bnum automatic storage, and ten of them would be megabytes of
    ! stack, which a 2 MiB stack cannot hold.
    type(bnum), intent(inout) :: a

    allocate(a%d(CAP))
    a%n = 0
    a%s = 1
  end subroutine binit

  subroutine bset(r, v)
    ! r = v, with |v| < BASE
    type(bnum), intent(inout) :: r
    integer(kind=8), intent(in) :: v

    if (v == 0_8) then
      r%n = 0
      r%s = 1
    else if (v > 0_8) then
      r%n = 1
      r%d(1) = v
      r%s = 1
    else
      r%n = 1
      r%d(1) = -v
      r%s = -1
    end if
  end subroutine bset

  subroutine bcopy(r, a)
    type(bnum), intent(inout) :: r
    type(bnum), intent(in) :: a
    integer :: i

    do i = 1, a%n
      r%d(i) = a%d(i)
    end do
    r%n = a%n
    r%s = a%s
  end subroutine bcopy

  subroutine bneg(r, a)
    type(bnum), intent(inout) :: r
    type(bnum), intent(in) :: a
    integer :: i

    do i = 1, a%n
      r%d(i) = a%d(i)
    end do
    r%n = a%n
    if (r%n == 0) then
      r%s = 1
    else
      r%s = -a%s
    end if
  end subroutine bneg

  subroutine bmul(r, a, m)
    ! r = a*m, m a non-negative small integer
    type(bnum), intent(inout) :: r
    type(bnum), intent(in) :: a
    integer(kind=8), intent(in) :: m
    integer(kind=8) :: carry, prod
    integer :: i

    if (m == 0_8 .or. a%n == 0) then
      r%n = 0
      r%s = 1
      return
    end if
    carry = 0_8
    do i = 1, a%n
      prod = a%d(i)*m + carry
      r%d(i) = mod(prod, BASE)
      carry = prod/BASE
    end do
    r%n = a%n
    do while (carry > 0_8)
      r%n = r%n + 1
      r%d(r%n) = mod(carry, BASE)
      carry = carry/BASE
    end do
    r%s = a%s
  end subroutine bmul

  subroutine madd(r, a, b)
    ! r = |a| + |b|
    type(bnum), intent(inout) :: r
    type(bnum), intent(in) :: a, b
    integer(kind=8) :: carry, t
    integer :: i, nc

    nc = max(a%n, b%n)
    carry = 0_8
    do i = 1, nc
      t = carry
      if (i <= a%n) t = t + a%d(i)
      if (i <= b%n) t = t + b%d(i)
      r%d(i) = mod(t, BASE)
      carry = t/BASE
    end do
    if (carry > 0_8) then
      nc = nc + 1
      r%d(nc) = carry
    end if
    r%n = nc
    r%s = 1
  end subroutine madd

  subroutine msub(r, a, b)
    ! r = |a| - |b|, which needs |a| >= |b|
    type(bnum), intent(inout) :: r
    type(bnum), intent(in) :: a, b
    integer(kind=8) :: borrow, t
    integer :: i

    borrow = 0_8
    do i = 1, a%n
      t = a%d(i) - borrow
      if (i <= b%n) t = t - b%d(i)
      if (t < 0_8) then
        t = t + BASE
        borrow = 1_8
      else
        borrow = 0_8
      end if
      r%d(i) = t
    end do
    r%n = a%n
    do while (r%n > 0)
      if (r%d(r%n) /= 0_8) exit
      r%n = r%n - 1
    end do
    r%s = 1
  end subroutine msub

  integer function mcmp(a, b)
    ! compares the magnitudes |a| and |b|
    type(bnum), intent(in) :: a, b
    integer :: i

    if (a%n /= b%n) then
      if (a%n > b%n) then
        mcmp = 1
      else
        mcmp = -1
      end if
      return
    end if
    mcmp = 0
    do i = a%n, 1, -1
      if (a%d(i) > b%d(i)) then
        mcmp = 1
        return
      else if (a%d(i) < b%d(i)) then
        mcmp = -1
        return
      end if
    end do
  end function mcmp

  integer function bcmp(a, b)
    ! compares a and b
    type(bnum), intent(in) :: a, b
    integer :: sa, sb

    sa = a%s
    if (a%n == 0) sa = 0
    sb = b%s
    if (b%n == 0) sb = 0
    if (sa /= sb) then
      if (sa > sb) then
        bcmp = 1
      else
        bcmp = -1
      end if
      return
    end if
    if (sa == 0) then
      bcmp = 0
      return
    end if
    bcmp = mcmp(a, b)*sa
  end function bcmp

  subroutine badd(r, a, b)
    ! r = a + b
    type(bnum), intent(inout) :: r
    type(bnum), intent(in) :: a, b

    if (a%n == 0) then
      call bcopy(r, b)
      return
    end if
    if (b%n == 0) then
      call bcopy(r, a)
      return
    end if
    if (a%s == b%s) then
      call madd(r, a, b)
      r%s = a%s
      return
    end if
    if (mcmp(a, b) >= 0) then
      call msub(r, a, b)
      if (r%n == 0) then
        r%s = 1
      else
        r%s = a%s
      end if
    else
      call msub(r, b, a)
      if (r%n == 0) then
        r%s = 1
      else
        r%s = b%s
      end if
    end if
  end subroutine badd

  subroutine bsub(r, a, b)
    ! r = a - b
    type(bnum), intent(inout) :: r
    type(bnum), intent(in) :: a, b

    if (b%n == 0) then
      call bcopy(r, a)
      return
    end if
    if (a%n == 0) then
      call bneg(r, b)
      return
    end if
    if (a%s /= b%s) then
      call madd(r, a, b)
      r%s = a%s
      return
    end if
    if (mcmp(a, b) >= 0) then
      call msub(r, a, b)
      if (r%n == 0) then
        r%s = 1
      else
        r%s = a%s
      end if
    else
      call msub(r, b, a)
      if (r%n == 0) then
        r%s = 1
      else
        r%s = -a%s
      end if
    end if
  end subroutine bsub

  integer(kind=8) function bdivq(a, b, tmp)
    ! floor(a/b) for a >= 0 and b > 0.  Every quotient the spigot asks for is
    ! below 100, so the answer is estimated from the leading limbs and then
    ! corrected with trial multiples built from the multiply-by-small routine.
    type(bnum), intent(in) :: a, b
    type(bnum), intent(inout) :: tmp
    integer(kind=8) :: q

    if (a%n < b%n) then
      bdivq = 0_8
      return
    end if
    if (a%n == b%n) then
      q = a%d(a%n)/b%d(b%n)
    else
      q = (a%d(a%n)*BASE + a%d(a%n - 1))/b%d(b%n)
    end if
    if (q > 127_8) q = 127_8
    do while (q > 0_8)
      call bmul(tmp, b, q)
      if (bcmp(tmp, a) <= 0) exit
      q = q - 1_8
    end do
    do
      call bmul(tmp, b, q + 1_8)
      if (bcmp(tmp, a) > 0) exit
      q = q + 1_8
    end do
    bdivq = q
  end function bdivq

end module bignum

program main
  use bignum
  implicit none
  type(bnum) :: q, r, t, t1, t2, t3, t4, t5, t6, t7
  integer(kind=8) :: k, l, n, nn, dg, total

  call binit(q)
  call binit(r)
  call binit(t)
  call binit(t1)
  call binit(t2)
  call binit(t3)
  call binit(t4)
  call binit(t5)
  call binit(t6)
  call binit(t7)

  call bset(q, 1_8)
  call bset(r, 0_8)
  call bset(t, 1_8)
  k = 1_8
  l = 3_8
  n = 3_8
  dg = 0_8
  total = 0_8

  do while (dg < 10000_8)
    ! the next digit n is ready once 4q + r - t < n*t
    call bmul(t1, q, 4_8)
    call badd(t2, t1, r)
    call bsub(t1, t2, t)
    call bmul(t2, t, n)
    if (bcmp(t1, t2) < 0) then
      ! emit n, then q <- 10q, r <- 10*(r - n*t), n <- 10*(3q + r)/t - 10n
      total = total + n
      dg = dg + 1_8
      call bmul(t1, q, 10_8)
      call bmul(t2, t, n)
      call bsub(t3, r, t2)
      call bmul(t4, t3, 10_8)
      call bmul(t2, q, 3_8)
      call badd(t3, t2, r)
      call bmul(t2, t3, 10_8)
      nn = bdivq(t2, t, t5) - 10_8*n
      call bcopy(q, t1)
      call bcopy(r, t4)
      n = nn
    else
      ! q <- q*k, r <- (2q + r)*l, t <- t*l, k <- k + 1, l <- l + 2,
      ! n <- (q*(7k + 2) + r*l)/(t*l)
      call bmul(t1, q, k)
      call bmul(t2, q, 2_8)
      call badd(t3, t2, r)
      call bmul(t2, t3, l)
      call bmul(t3, t, l)
      call bmul(t4, q, 7_8*k + 2_8)
      call bmul(t5, r, l)
      call badd(t6, t4, t5)
      nn = bdivq(t6, t3, t7)
      call bcopy(q, t1)
      call bcopy(r, t2)
      call bcopy(t, t3)
      k = k + 1_8
      l = l + 2_8
      n = nn
    end if
  end do

  write(*,'(i0)') total
end program main
