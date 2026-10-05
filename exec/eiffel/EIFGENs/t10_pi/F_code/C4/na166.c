/*
 * Code for class NATURAL_16_REF
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "na166.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {NATURAL_16_REF}.hash_code */
EIF_INTEGER_32 F753_4102 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_16 tu2_1;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tu2_1 = *(EIF_NATURAL_16 *)(Current+ _I16OFF_0_0_0_);
	Result = (EIF_INTEGER_32) tu2_1;
	RTLE;
	return Result;
}

/* {NATURAL_16_REF}.is_less */
EIF_BOOLEAN F753_4109 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_16 tu2_1;
	EIF_NATURAL_16 tu2_2;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,arg1);
	RTLIU(2);
	
	RTGC;
	tu2_1 = *(EIF_NATURAL_16 *)(Current+ _I16OFF_0_0_0_);
	tu2_2 = *(EIF_NATURAL_16 *)(RTCW(arg1)+ _I16OFF_0_0_0_);
	Result = (EIF_BOOLEAN) (EIF_BOOLEAN) (tu2_1 < tu2_2);
	RTLE;
	return Result;
}

/* {NATURAL_16_REF}.is_equal */
EIF_BOOLEAN F753_4110 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_16 tu2_1;
	EIF_NATURAL_16 tu2_2;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,arg1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tu2_1 = *(EIF_NATURAL_16 *)(RTCW(arg1)+ _I16OFF_0_0_0_);
	tu2_2 = *(EIF_NATURAL_16 *)(Current+ _I16OFF_0_0_0_);
	Result = (EIF_BOOLEAN) (EIF_BOOLEAN)(tu2_1 == tu2_2);
	RTLE;
	return Result;
}

/* {NATURAL_16_REF}.set_item */
void F753_4111 (EIF_REFERENCE Current, EIF_NATURAL_16 arg1)
{
	GTCX
	
	
	*(EIF_NATURAL_16 *)(Current+ _I16OFF_0_0_0_) = (EIF_NATURAL_16) arg1;
}

/* {NATURAL_16_REF}.integer_quotient */
EIF_REFERENCE F753_4124 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_16 tu2_1;
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
	tu2_1 = *(EIF_NATURAL_16 *)(RTCW(arg1)+ _I16OFF_0_0_0_);
	F753_4111(RTCW(Result), (EIF_NATURAL_16) (*(EIF_NATURAL_16 *)(Current+ _I16OFF_0_0_0_) / tu2_1));
	RTLE;
	return Result;
}

/* {NATURAL_16_REF}.integer_remainder */
EIF_REFERENCE F753_4125 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_16 tu2_1;
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
	tu2_1 = *(EIF_NATURAL_16 *)(RTCW(arg1)+ _I16OFF_0_0_0_);
	F753_4111(RTCW(Result), (EIF_NATURAL_16) (*(EIF_NATURAL_16 *)(Current+ _I16OFF_0_0_0_) % tu2_1));
	RTLE;
	return Result;
}

/* {NATURAL_16_REF}.as_natural_32 */
EIF_NATURAL_32 F753_4133 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_16 tu2_1;
	EIF_NATURAL_32 Result = ((EIF_NATURAL_32) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tu2_1 = *(EIF_NATURAL_16 *)(Current+ _I16OFF_0_0_0_);
	Result = (EIF_NATURAL_32) tu2_1;
	RTLE;
	return Result;
}

/* {NATURAL_16_REF}.as_natural_64 */
EIF_NATURAL_64 F753_4134 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_16 tu2_1;
	EIF_NATURAL_64 Result = ((EIF_NATURAL_64) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tu2_1 = *(EIF_NATURAL_16 *)(Current+ _I16OFF_0_0_0_);
	Result = (EIF_NATURAL_64) tu2_1;
	RTLE;
	return Result;
}

/* {NATURAL_16_REF}.as_integer_32 */
EIF_INTEGER_32 F753_4137 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_16 tu2_1;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tu2_1 = *(EIF_NATURAL_16 *)(Current+ _I16OFF_0_0_0_);
	Result = (EIF_INTEGER_32) tu2_1;
	RTLE;
	return Result;
}

/* {NATURAL_16_REF}.to_natural_32 */
EIF_NATURAL_32 F753_4141 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_NATURAL_32) (FUNCTION_CAST(EIF_NATURAL_32, (EIF_REFERENCE)) R3150[Dtype(Current)-753])(Current);
}

/* {NATURAL_16_REF}.to_natural_64 */
EIF_NATURAL_64 F753_4142 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_NATURAL_64) (FUNCTION_CAST(EIF_NATURAL_64, (EIF_REFERENCE)) R3151[Dtype(Current)-753])(Current);
}

/* {NATURAL_16_REF}.to_integer_32 */
EIF_INTEGER_32 F753_4145 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_INTEGER_32) (FUNCTION_CAST(EIF_INTEGER_32, (EIF_REFERENCE)) R3154[Dtype(Current)-753])(Current);
}

/* {NATURAL_16_REF}.to_character_32 */
EIF_CHARACTER_32 F753_4157 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_16 tu2_1;
	EIF_CHARACTER_32 Result = ((EIF_CHARACTER_32) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tu2_1 = *(EIF_NATURAL_16 *)(Current+ _I16OFF_0_0_0_);
	Result = (EIF_CHARACTER_32) tu2_1;
	RTLE;
	return Result;
}

void EIF_Minit166 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
