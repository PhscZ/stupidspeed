/*
 * Code for class NATURAL_64_REF
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

/* {NATURAL_64_REF}.hash_code */
EIF_INTEGER_32 F761_4139 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_64 tu8_1;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tu8_1 = *(EIF_NATURAL_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_);
	tu8_1 = eif_bit_and(tu8_1,(EIF_NATURAL_64) ((EIF_INTEGER_32) 2147483647L));
	Result = (EIF_INTEGER_32) tu8_1;
	RTLE;
	return Result;
}

/* {NATURAL_64_REF}.is_less */
EIF_BOOLEAN F761_4146 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_64 tu8_1;
	EIF_NATURAL_64 tu8_2;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,arg1);
	RTLIU(2);
	
	RTGC;
	tu8_1 = *(EIF_NATURAL_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_);
	tu8_2 = *(EIF_NATURAL_64 *)(RTCW(arg1)+ _I64OFF_0_0_0_0_0_0_0_);
	Result = (EIF_BOOLEAN) (EIF_BOOLEAN) (tu8_1 < tu8_2);
	RTLE;
	return Result;
}

/* {NATURAL_64_REF}.is_equal */
EIF_BOOLEAN F761_4147 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_64 tu8_1;
	EIF_NATURAL_64 tu8_2;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,arg1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tu8_1 = *(EIF_NATURAL_64 *)(RTCW(arg1)+ _I64OFF_0_0_0_0_0_0_0_);
	tu8_2 = *(EIF_NATURAL_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_);
	Result = (EIF_BOOLEAN) (EIF_BOOLEAN)(tu8_1 == tu8_2);
	RTLE;
	return Result;
}

/* {NATURAL_64_REF}.set_item */
void F761_4148 (EIF_REFERENCE Current, EIF_NATURAL_64 arg1)
{
	GTCX
	
	
	*(EIF_NATURAL_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_) = (EIF_NATURAL_64) arg1;
}

/* {NATURAL_64_REF}.plus */
EIF_REFERENCE F761_4155 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_64 tu8_1;
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
	tu8_1 = *(EIF_NATURAL_64 *)(RTCW(arg1)+ _I64OFF_0_0_0_0_0_0_0_);
	F761_4148(RTCW(Result), (EIF_NATURAL_64) (*(EIF_NATURAL_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_) + tu8_1));
	RTLE;
	return Result;
}

/* {NATURAL_64_REF}.product */
EIF_REFERENCE F761_4157 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_64 tu8_1;
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
	tu8_1 = *(EIF_NATURAL_64 *)(RTCW(arg1)+ _I64OFF_0_0_0_0_0_0_0_);
	F761_4148(RTCW(Result), (EIF_NATURAL_64) (*(EIF_NATURAL_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_) * tu8_1));
	RTLE;
	return Result;
}

/* {NATURAL_64_REF}.integer_quotient */
EIF_REFERENCE F761_4161 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_64 tu8_1;
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
	tu8_1 = *(EIF_NATURAL_64 *)(RTCW(arg1)+ _I64OFF_0_0_0_0_0_0_0_);
	F761_4148(RTCW(Result), (EIF_NATURAL_64) (*(EIF_NATURAL_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_) / tu8_1));
	RTLE;
	return Result;
}

/* {NATURAL_64_REF}.integer_remainder */
EIF_REFERENCE F761_4162 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_64 tu8_1;
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
	tu8_1 = *(EIF_NATURAL_64 *)(RTCW(arg1)+ _I64OFF_0_0_0_0_0_0_0_);
	F761_4148(RTCW(Result), (EIF_NATURAL_64) (*(EIF_NATURAL_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_) % tu8_1));
	RTLE;
	return Result;
}

/* {NATURAL_64_REF}.as_natural_32 */
EIF_NATURAL_32 F761_4169 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_64 tu8_1;
	EIF_NATURAL_32 Result = ((EIF_NATURAL_32) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tu8_1 = *(EIF_NATURAL_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_);
	Result = (EIF_NATURAL_32) tu8_1;
	RTLE;
	return Result;
}

/* {NATURAL_64_REF}.as_integer_32 */
EIF_INTEGER_32 F761_4173 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_64 tu8_1;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tu8_1 = *(EIF_NATURAL_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_);
	Result = (EIF_INTEGER_32) tu8_1;
	RTLE;
	return Result;
}

/* {NATURAL_64_REF}.to_natural_64 */
EIF_NATURAL_64 F761_4178 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_NATURAL_64) *(EIF_NATURAL_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_);
}

/* {NATURAL_64_REF}.to_integer_32 */
EIF_INTEGER_32 F761_4181 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_INTEGER_32) (FUNCTION_CAST(EIF_INTEGER_32, (EIF_REFERENCE)) R3188[Dtype(Current)-761])(Current);
}

/* {NATURAL_64_REF}.bit_and */
EIF_REFERENCE F761_4194 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_64 tu8_1;
	EIF_NATURAL_64 tu8_2;
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
	tu8_1 = *(EIF_NATURAL_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_);
	tu8_2 = *(EIF_NATURAL_64 *)(RTCW(arg1)+ _I64OFF_0_0_0_0_0_0_0_);
	tu8_1 = eif_bit_and(tu8_1,tu8_2);
	F761_4148(RTCW(Result), tu8_1);
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
