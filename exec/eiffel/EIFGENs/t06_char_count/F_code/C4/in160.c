/*
 * Code for class INTEGER_32
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "in160.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {INTEGER_32}.is_less */
EIF_BOOLEAN F712_3780 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(711, 0x00).id, 711, _OBJSIZ_0_0_0_1_0_0_0_0_);
	*(EIF_INTEGER_32 *)tr1 = arg1;
	Result = F710_3717(Current, tr1);
	RTLE;
	return Result;
}

/* {INTEGER_32}.plus */
EIF_INTEGER_32 F712_3781 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(711, 0x00).id, 711, _OBJSIZ_0_0_0_1_0_0_0_0_);
	*(EIF_INTEGER_32 *)tr1 = arg1;
	tr1 = F710_3727(Current, tr1);
	Result = *(EIF_INTEGER_32 *)(tr1);
	RTLE;
	return Result;
}

/* {INTEGER_32}.minus */
EIF_INTEGER_32 F712_3782 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(711, 0x00).id, 711, _OBJSIZ_0_0_0_1_0_0_0_0_);
	*(EIF_INTEGER_32 *)tr1 = arg1;
	tr1 = F710_3728(Current, tr1);
	Result = *(EIF_INTEGER_32 *)(tr1);
	RTLE;
	return Result;
}

/* {INTEGER_32}.product */
EIF_INTEGER_32 F712_3783 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(711, 0x00).id, 711, _OBJSIZ_0_0_0_1_0_0_0_0_);
	*(EIF_INTEGER_32 *)tr1 = arg1;
	tr1 = F710_3729(Current, tr1);
	Result = *(EIF_INTEGER_32 *)(tr1);
	RTLE;
	return Result;
}

/* {INTEGER_32}.quotient */
EIF_REAL_64 F712_3784 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_REAL_64 Result = ((EIF_REAL_64) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(711, 0x00).id, 711, _OBJSIZ_0_0_0_1_0_0_0_0_);
	*(EIF_INTEGER_32 *)tr1 = arg1;
	Result = F710_3730(Current, tr1);
	RTLE;
	return Result;
}

/* {INTEGER_32}.opposite */
EIF_INTEGER_32 F712_3786 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return *(EIF_INTEGER_32 *)F710_3732(Current);
}

/* {INTEGER_32}.integer_quotient */
EIF_INTEGER_32 F712_3787 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(711, 0x00).id, 711, _OBJSIZ_0_0_0_1_0_0_0_0_);
	*(EIF_INTEGER_32 *)tr1 = arg1;
	tr1 = F710_3733(Current, tr1);
	Result = *(EIF_INTEGER_32 *)(tr1);
	RTLE;
	return Result;
}

/* {INTEGER_32}.integer_remainder */
EIF_INTEGER_32 F712_3788 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(711, 0x00).id, 711, _OBJSIZ_0_0_0_1_0_0_0_0_);
	*(EIF_INTEGER_32 *)tr1 = arg1;
	tr1 = F710_3734(Current, tr1);
	Result = *(EIF_INTEGER_32 *)(tr1);
	RTLE;
	return Result;
}

/* {INTEGER_32}.as_natural_32 */
EIF_NATURAL_32 F712_3792 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_NATURAL_32) F710_3742(Current);
}

/* {INTEGER_32}.as_natural_64 */
EIF_NATURAL_64 F712_3793 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_NATURAL_64) F710_3743(Current);
}

/* {INTEGER_32}.as_integer_64 */
EIF_INTEGER_64 F712_3797 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_INTEGER_64) F710_3747(Current);
}

/* {INTEGER_32}.to_double */
EIF_REAL_64 F712_3799 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_REAL_64) F710_3758(Current);
}

/* {INTEGER_32}.to_character_8 */
EIF_CHARACTER_8 F712_3800 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_CHARACTER_8) F710_3766(Current);
}

/* {INTEGER_32}.bit_and */
EIF_INTEGER_32 F712_3802 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(711, 0x00).id, 711, _OBJSIZ_0_0_0_1_0_0_0_0_);
	*(EIF_INTEGER_32 *)tr1 = arg1;
	tr1 = F710_3768(Current, tr1);
	Result = *(EIF_INTEGER_32 *)(tr1);
	RTLE;
	return Result;
}

/* {INTEGER_32}.bit_or */
EIF_INTEGER_32 F712_3803 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(711, 0x00).id, 711, _OBJSIZ_0_0_0_1_0_0_0_0_);
	*(EIF_INTEGER_32 *)tr1 = arg1;
	tr1 = F710_3769(Current, tr1);
	Result = *(EIF_INTEGER_32 *)(tr1);
	RTLE;
	return Result;
}

/* {INTEGER_32}.bit_not */
EIF_INTEGER_32 F712_3805 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return *(EIF_INTEGER_32 *)F710_3771(Current);
}

/* {INTEGER_32}.bit_shift_left */
EIF_INTEGER_32 F712_3806 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	
	
	return *(EIF_INTEGER_32 *)F710_3773(Current, arg1);
}

/* {INTEGER_32}.bit_shift_right */
EIF_INTEGER_32 F712_3807 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	
	
	return *(EIF_INTEGER_32 *)F710_3774(Current, arg1);
}

void EIF_Minit160 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
