!mod$ v1 sum:1378b0e664bb2202
module bignum
integer(4),parameter::base=1000000000_4
integer(4),parameter::cap=32768_4
type::bnum
integer(8),allocatable::d(:)
integer(4)::n
integer(4)::s
end type
contains
subroutine binit(a)
type(bnum),intent(inout)::a
end
subroutine bset(r,v)
type(bnum),intent(inout)::r
integer(8),intent(in)::v
end
subroutine bcopy(r,a)
type(bnum),intent(inout)::r
type(bnum),intent(in)::a
end
subroutine bneg(r,a)
type(bnum),intent(inout)::r
type(bnum),intent(in)::a
end
subroutine bmul(r,a,m)
type(bnum),intent(inout)::r
type(bnum),intent(in)::a
integer(8),intent(in)::m
end
subroutine madd(r,a,b)
type(bnum),intent(inout)::r
type(bnum),intent(in)::a
type(bnum),intent(in)::b
end
subroutine msub(r,a,b)
type(bnum),intent(inout)::r
type(bnum),intent(in)::a
type(bnum),intent(in)::b
end
function mcmp(a,b)
type(bnum),intent(in)::a
type(bnum),intent(in)::b
integer(4)::mcmp
end
function bcmp(a,b)
type(bnum),intent(in)::a
type(bnum),intent(in)::b
integer(4)::bcmp
end
subroutine badd(r,a,b)
type(bnum),intent(inout)::r
type(bnum),intent(in)::a
type(bnum),intent(in)::b
end
subroutine bsub(r,a,b)
type(bnum),intent(inout)::r
type(bnum),intent(in)::a
type(bnum),intent(in)::b
end
function bdivq(a,b,tmp)
type(bnum),intent(in)::a
type(bnum),intent(in)::b
type(bnum),intent(inout)::tmp
integer(8)::bdivq
end
end
