/*
 * Code for class INTEGER_16_REF
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "in162.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {INTEGER_16_REF}.hash_code */
EIF_INTEGER_32 F713_3809 (EIF_REFERENCE Current)
{
	GTCX
	EIF_INTEGER_32 ti4_1;
	EIF_INTEGER_16 ti2_1;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	ti2_1 = *(EIF_INTEGER_16 *)(Current+ _I16OFF_0_0_0_);
	ti4_1 = (EIF_INTEGER_32) ti2_1;
	Result = (EIF_INTEGER_32) (0x7FFFFFFF & (EIF_INTEGER_32) ((rt_int_ptr) (ti4_1)));
	RTLE;
	return Result;
}

/* {INTEGER_16_REF}.is_less */
EIF_BOOLEAN F713_3816 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_INTEGER_16 ti2_1;
	EIF_INTEGER_16 ti2_2;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,arg1);
	RTLIU(2);
	
	RTGC;
	ti2_1 = *(EIF_INTEGER_16 *)(Current+ _I16OFF_0_0_0_);
	ti2_2 = *(EIF_INTEGER_16 *)(RTCW(arg1)+ _I16OFF_0_0_0_);
	Result = (EIF_BOOLEAN) (EIF_BOOLEAN) (ti2_1 < ti2_2);
	RTLE;
	return Result;
}

/* {INTEGER_16_REF}.is_equal */
EIF_BOOLEAN F713_3817 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_INTEGER_16 ti2_1;
	EIF_INTEGER_16 ti2_2;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,arg1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	ti2_1 = *(EIF_INTEGER_16 *)(RTCW(arg1)+ _I16OFF_0_0_0_);
	ti2_2 = *(EIF_INTEGER_16 *)(Current+ _I16OFF_0_0_0_);
	Result = (EIF_BOOLEAN) (EIF_BOOLEAN)(ti2_1 == ti2_2);
	RTLE;
	return Result;
}

/* {INTEGER_16_REF}.set_item */
void F713_3818 (EIF_REFERENCE Current, EIF_INTEGER_16 arg1)
{
	GTCX
	
	
	*(EIF_INTEGER_16 *)(Current+ _I16OFF_0_0_0_) = (EIF_INTEGER_16) arg1;
}

/* {INTEGER_16_REF}.opposite */
EIF_REFERENCE F713_3831 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,Result);
	RTLIU(2);
	
	RTGC;
	Result = RTLNSMART(Dftype(Current));
	F1_29(RTCW(Result));
	F713_3818(RTCW(Result), (EIF_INTEGER_16) -*(EIF_INTEGER_16 *)(Current+ _I16OFF_0_0_0_));
	RTLE;
	return Result;
}

/* {INTEGER_16_REF}.integer_quotient */
EIF_REFERENCE F713_3832 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_INTEGER_16 ti2_1;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(3);
	RTLR(0,Current);
	RTLR(1,Result);
	RTLR(2,arg1);
	RTLIU(3);
	
	RTGC;
	Result = RTLNSMART(Dftype(Current));
	F1_29(RTCW(Result));
	ti2_1 = *(EIF_INTEGER_16 *)(RTCW(arg1)+ _I16OFF_0_0_0_);
	F713_3818(RTCW(Result), (EIF_INTEGER_16) (*(EIF_INTEGER_16 *)(Current+ _I16OFF_0_0_0_) / ti2_1));
	RTLE;
	return Result;
}

/* {INTEGER_16_REF}.integer_remainder */
EIF_REFERENCE F713_3833 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_INTEGER_16 ti2_1;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(3);
	RTLR(0,Current);
	RTLR(1,Result);
	RTLR(2,arg1);
	RTLIU(3);
	
	RTGC;
	Result = RTLNSMART(Dftype(Current));
	F1_29(RTCW(Result));
	ti2_1 = *(EIF_INTEGER_16 *)(RTCW(arg1)+ _I16OFF_0_0_0_);
	F713_3818(RTCW(Result), (EIF_INTEGER_16) (*(EIF_INTEGER_16 *)(Current+ _I16OFF_0_0_0_) % ti2_1));
	RTLE;
	return Result;
}

/* {INTEGER_16_REF}.as_natural_64 */
EIF_NATURAL_64 F713_3842 (EIF_REFERENCE Current)
{
	GTCX
	EIF_INTEGER_16 ti2_1;
	EIF_NATURAL_64 Result = ((EIF_NATURAL_64) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	ti2_1 = *(EIF_INTEGER_16 *)(Current+ _I16OFF_0_0_0_);
	Result = (EIF_NATURAL_64) ti2_1;
	RTLE;
	return Result;
}

/* {INTEGER_16_REF}.as_integer_32 */
EIF_INTEGER_32 F713_3845 (EIF_REFERENCE Current)
{
	GTCX
	EIF_INTEGER_16 ti2_1;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	ti2_1 = *(EIF_INTEGER_16 *)(Current+ _I16OFF_0_0_0_);
	Result = (EIF_INTEGER_32) ti2_1;
	RTLE;
	return Result;
}

/* {INTEGER_16_REF}.to_natural_64 */
EIF_NATURAL_64 F713_3850 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_NATURAL_64) (FUNCTION_CAST(EIF_NATURAL_64, (EIF_REFERENCE)) R3007[Dtype(Current)-713])(Current);
}

/* {INTEGER_16_REF}.to_integer */
EIF_INTEGER_32 F713_3852 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_INTEGER_32) (FUNCTION_CAST(EIF_INTEGER_32, (EIF_REFERENCE)) R3010[Dtype(Current)-713])(Current);
}

void EIF_Minit162 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
