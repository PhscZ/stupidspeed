/*
 * Code for class NATURAL_8_REF
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "na174.h"
#include "eif_misc.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {NATURAL_8_REF}.hash_code */
EIF_INTEGER_32 F725_4250 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_8 tu1_1;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tu1_1 = *(EIF_NATURAL_8 *)(Current+ _CHROFF_0_0_);
	Result = (EIF_INTEGER_32) tu1_1;
	RTLE;
	return Result;
}

/* {NATURAL_8_REF}.is_less */
EIF_BOOLEAN F725_4257 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_8 tu1_1;
	EIF_NATURAL_8 tu1_2;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,arg1);
	RTLIU(2);
	
	RTGC;
	tu1_1 = *(EIF_NATURAL_8 *)(Current+ _CHROFF_0_0_);
	tu1_2 = *(EIF_NATURAL_8 *)(RTCW(arg1)+ _CHROFF_0_0_);
	Result = (EIF_BOOLEAN) (EIF_BOOLEAN) (tu1_1 < tu1_2);
	RTLE;
	return Result;
}

/* {NATURAL_8_REF}.is_equal */
EIF_BOOLEAN F725_4258 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_8 tu1_1;
	EIF_NATURAL_8 tu1_2;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,arg1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tu1_1 = *(EIF_NATURAL_8 *)(RTCW(arg1)+ _CHROFF_0_0_);
	tu1_2 = *(EIF_NATURAL_8 *)(Current+ _CHROFF_0_0_);
	Result = (EIF_BOOLEAN) (EIF_BOOLEAN)(tu1_1 == tu1_2);
	RTLE;
	return Result;
}

/* {NATURAL_8_REF}.set_item */
void F725_4259 (EIF_REFERENCE Current, EIF_NATURAL_8 arg1)
{
	GTCX
	
	
	*(EIF_NATURAL_8 *)(Current+ _CHROFF_0_0_) = (EIF_NATURAL_8) arg1;
}

/* {NATURAL_8_REF}.minus */
EIF_REFERENCE F725_4267 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_8 tu1_1;
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
	tu1_1 = *(EIF_NATURAL_8 *)(RTCW(arg1)+ _CHROFF_0_0_);
	F725_4259(RTCW(Result), (EIF_NATURAL_8) (*(EIF_NATURAL_8 *)(Current+ _CHROFF_0_0_) - tu1_1));
	RTLE;
	return Result;
}

/* {NATURAL_8_REF}.integer_quotient */
EIF_REFERENCE F725_4272 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_8 tu1_1;
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
	tu1_1 = *(EIF_NATURAL_8 *)(RTCW(arg1)+ _CHROFF_0_0_);
	F725_4259(RTCW(Result), (EIF_NATURAL_8) (*(EIF_NATURAL_8 *)(Current+ _CHROFF_0_0_) / tu1_1));
	RTLE;
	return Result;
}

/* {NATURAL_8_REF}.integer_remainder */
EIF_REFERENCE F725_4273 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_8 tu1_1;
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
	tu1_1 = *(EIF_NATURAL_8 *)(RTCW(arg1)+ _CHROFF_0_0_);
	F725_4259(RTCW(Result), (EIF_NATURAL_8) (*(EIF_NATURAL_8 *)(Current+ _CHROFF_0_0_) % tu1_1));
	RTLE;
	return Result;
}

/* {NATURAL_8_REF}.as_natural_32 */
EIF_NATURAL_32 F725_4281 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_8 tu1_1;
	EIF_NATURAL_32 Result = ((EIF_NATURAL_32) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tu1_1 = *(EIF_NATURAL_8 *)(Current+ _CHROFF_0_0_);
	Result = (EIF_NATURAL_32) tu1_1;
	RTLE;
	return Result;
}

/* {NATURAL_8_REF}.as_natural_64 */
EIF_NATURAL_64 F725_4282 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_8 tu1_1;
	EIF_NATURAL_64 Result = ((EIF_NATURAL_64) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tu1_1 = *(EIF_NATURAL_8 *)(Current+ _CHROFF_0_0_);
	Result = (EIF_NATURAL_64) tu1_1;
	RTLE;
	return Result;
}

/* {NATURAL_8_REF}.as_integer_8 */
EIF_INTEGER_8 F725_4283 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_8 tu1_1;
	EIF_INTEGER_8 Result = ((EIF_INTEGER_8) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tu1_1 = *(EIF_NATURAL_8 *)(Current+ _CHROFF_0_0_);
	Result = (EIF_INTEGER_8) tu1_1;
	RTLE;
	return Result;
}

/* {NATURAL_8_REF}.as_integer_32 */
EIF_INTEGER_32 F725_4285 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_8 tu1_1;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tu1_1 = *(EIF_NATURAL_8 *)(Current+ _CHROFF_0_0_);
	Result = (EIF_INTEGER_32) tu1_1;
	RTLE;
	return Result;
}

/* {NATURAL_8_REF}.to_natural_32 */
EIF_NATURAL_32 F725_4289 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_NATURAL_32) (FUNCTION_CAST(EIF_NATURAL_32, (EIF_REFERENCE)) R3241[Dtype(Current)-725])(Current);
}

/* {NATURAL_8_REF}.to_natural_64 */
EIF_NATURAL_64 F725_4290 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_NATURAL_64) (FUNCTION_CAST(EIF_NATURAL_64, (EIF_REFERENCE)) R3242[Dtype(Current)-725])(Current);
}

/* {NATURAL_8_REF}.to_integer_8 */
EIF_INTEGER_8 F725_4291 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_INTEGER_8) (FUNCTION_CAST(EIF_INTEGER_8, (EIF_REFERENCE)) R3243[Dtype(Current)-725])(Current);
}

/* {NATURAL_8_REF}.to_integer_32 */
EIF_INTEGER_32 F725_4293 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_INTEGER_32) (FUNCTION_CAST(EIF_INTEGER_32, (EIF_REFERENCE)) R3245[Dtype(Current)-725])(Current);
}

/* {NATURAL_8_REF}.to_character_8 */
EIF_CHARACTER_8 F725_4304 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_8 tu1_1;
	EIF_CHARACTER_8 Result = ((EIF_CHARACTER_8) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tu1_1 = *(EIF_NATURAL_8 *)(Current+ _CHROFF_0_0_);
	Result = (EIF_CHARACTER_8) tu1_1;
	RTLE;
	return Result;
}

/* {NATURAL_8_REF}.bit_and */
EIF_REFERENCE F725_4306 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_8 tu1_1;
	EIF_NATURAL_8 tu1_2;
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
	tu1_1 = *(EIF_NATURAL_8 *)(Current+ _CHROFF_0_0_);
	tu1_2 = *(EIF_NATURAL_8 *)(RTCW(arg1)+ _CHROFF_0_0_);
	tu1_1 = eif_bit_and(tu1_1,tu1_2);
	F725_4259(RTCW(Result), tu1_1);
	RTLE;
	return Result;
}

/* {NATURAL_8_REF}.bit_or */
EIF_REFERENCE F725_4307 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_8 tu1_1;
	EIF_NATURAL_8 tu1_2;
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
	tu1_1 = *(EIF_NATURAL_8 *)(Current+ _CHROFF_0_0_);
	tu1_2 = *(EIF_NATURAL_8 *)(RTCW(arg1)+ _CHROFF_0_0_);
	tu1_1 = eif_bit_or(tu1_1,tu1_2);
	F725_4259(RTCW(Result), tu1_1);
	RTLE;
	return Result;
}

/* {NATURAL_8_REF}.bit_not */
EIF_REFERENCE F725_4309 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_8 tu1_1;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,Result);
	RTLIU(2);
	
	RTGC;
	Result = RTLNSMART(Dftype(Current));
	F1_29(RTCW(Result));
	tu1_1 = *(EIF_NATURAL_8 *)(Current+ _CHROFF_0_0_);
	tu1_1 = eif_bit_not(tu1_1);
	F725_4259(RTCW(Result), tu1_1);
	RTLE;
	return Result;
}

/* {NATURAL_8_REF}.bit_shift_left */
EIF_REFERENCE F725_4311 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_NATURAL_8 tu1_1;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,Result);
	RTLIU(2);
	
	RTGC;
	Result = RTLNSMART(Dftype(Current));
	F1_29(RTCW(Result));
	tu1_1 = *(EIF_NATURAL_8 *)(Current+ _CHROFF_0_0_);
	tu1_1 = eif_bit_shift_left(tu1_1,arg1);
	F725_4259(RTCW(Result), tu1_1);
	RTLE;
	return Result;
}

void EIF_Minit174 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
