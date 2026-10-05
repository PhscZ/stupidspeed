/*
 * Code for class NATURAL_32_REF
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "na168.h"
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

/* {NATURAL_32_REF}.hash_code */
EIF_INTEGER_32 F720_4045 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_32 tu4_1;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tu4_1 = *(EIF_NATURAL_32 *)(Current+ _LNGOFF_0_0_0_0_);
	tu4_1 = eif_bit_and(tu4_1,(EIF_NATURAL_32) ((EIF_INTEGER_32) 2147483647L));
	Result = (EIF_INTEGER_32) tu4_1;
	RTLE;
	return Result;
}

/* {NATURAL_32_REF}.is_less */
EIF_BOOLEAN F720_4052 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_32 tu4_1;
	EIF_NATURAL_32 tu4_2;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,arg1);
	RTLIU(2);
	
	RTGC;
	tu4_1 = *(EIF_NATURAL_32 *)(Current+ _LNGOFF_0_0_0_0_);
	tu4_2 = *(EIF_NATURAL_32 *)(RTCW(arg1)+ _LNGOFF_0_0_0_0_);
	Result = (EIF_BOOLEAN) (EIF_BOOLEAN) (tu4_1 < tu4_2);
	RTLE;
	return Result;
}

/* {NATURAL_32_REF}.is_equal */
EIF_BOOLEAN F720_4053 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_32 tu4_1;
	EIF_NATURAL_32 tu4_2;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,arg1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tu4_1 = *(EIF_NATURAL_32 *)(RTCW(arg1)+ _LNGOFF_0_0_0_0_);
	tu4_2 = *(EIF_NATURAL_32 *)(Current+ _LNGOFF_0_0_0_0_);
	Result = (EIF_BOOLEAN) (EIF_BOOLEAN)(tu4_1 == tu4_2);
	RTLE;
	return Result;
}

/* {NATURAL_32_REF}.set_item */
void F720_4054 (EIF_REFERENCE Current, EIF_NATURAL_32 arg1)
{
	GTCX
	
	
	*(EIF_NATURAL_32 *)(Current+ _LNGOFF_0_0_0_0_) = (EIF_NATURAL_32) arg1;
}

/* {NATURAL_32_REF}.is_valid_character_8_code */
EIF_BOOLEAN F720_4059 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_32 tu4_1;
	EIF_NATURAL_32 tu4_2;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tu4_1 = *(EIF_NATURAL_32 *)(Current+ _LNGOFF_0_0_0_0_);
	tu4_2 = (EIF_NATURAL_32) ((EIF_INTEGER_32) 255L);
	Result = (EIF_BOOLEAN) (EIF_BOOLEAN) (tu4_1 <= tu4_2);
	RTLE;
	return Result;
}

/* {NATURAL_32_REF}.plus */
EIF_REFERENCE F720_4061 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_32 tu4_1;
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
	tu4_1 = *(EIF_NATURAL_32 *)(RTCW(arg1)+ _LNGOFF_0_0_0_0_);
	F720_4054(RTCW(Result), (EIF_NATURAL_32) (*(EIF_NATURAL_32 *)(Current+ _LNGOFF_0_0_0_0_) + tu4_1));
	RTLE;
	return Result;
}

/* {NATURAL_32_REF}.minus */
EIF_REFERENCE F720_4062 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_32 tu4_1;
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
	tu4_1 = *(EIF_NATURAL_32 *)(RTCW(arg1)+ _LNGOFF_0_0_0_0_);
	F720_4054(RTCW(Result), (EIF_NATURAL_32) (*(EIF_NATURAL_32 *)(Current+ _LNGOFF_0_0_0_0_) - tu4_1));
	RTLE;
	return Result;
}

/* {NATURAL_32_REF}.integer_quotient */
EIF_REFERENCE F720_4067 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_32 tu4_1;
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
	tu4_1 = *(EIF_NATURAL_32 *)(RTCW(arg1)+ _LNGOFF_0_0_0_0_);
	F720_4054(RTCW(Result), (EIF_NATURAL_32) (*(EIF_NATURAL_32 *)(Current+ _LNGOFF_0_0_0_0_) / tu4_1));
	RTLE;
	return Result;
}

/* {NATURAL_32_REF}.integer_remainder */
EIF_REFERENCE F720_4068 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_32 tu4_1;
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
	tu4_1 = *(EIF_NATURAL_32 *)(RTCW(arg1)+ _LNGOFF_0_0_0_0_);
	F720_4054(RTCW(Result), (EIF_NATURAL_32) (*(EIF_NATURAL_32 *)(Current+ _LNGOFF_0_0_0_0_) % tu4_1));
	RTLE;
	return Result;
}

/* {NATURAL_32_REF}.as_natural_8 */
EIF_NATURAL_8 F720_4073 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_32 tu4_1;
	EIF_NATURAL_8 Result = ((EIF_NATURAL_8) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tu4_1 = *(EIF_NATURAL_32 *)(Current+ _LNGOFF_0_0_0_0_);
	Result = (EIF_NATURAL_8) tu4_1;
	RTLE;
	return Result;
}

/* {NATURAL_32_REF}.as_natural_16 */
EIF_NATURAL_16 F720_4074 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_32 tu4_1;
	EIF_NATURAL_16 Result = ((EIF_NATURAL_16) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tu4_1 = *(EIF_NATURAL_32 *)(Current+ _LNGOFF_0_0_0_0_);
	Result = (EIF_NATURAL_16) tu4_1;
	RTLE;
	return Result;
}

/* {NATURAL_32_REF}.as_natural_64 */
EIF_NATURAL_64 F720_4076 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_32 tu4_1;
	EIF_NATURAL_64 Result = ((EIF_NATURAL_64) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tu4_1 = *(EIF_NATURAL_32 *)(Current+ _LNGOFF_0_0_0_0_);
	Result = (EIF_NATURAL_64) tu4_1;
	RTLE;
	return Result;
}

/* {NATURAL_32_REF}.as_integer_32 */
EIF_INTEGER_32 F720_4079 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_32 tu4_1;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tu4_1 = *(EIF_NATURAL_32 *)(Current+ _LNGOFF_0_0_0_0_);
	Result = (EIF_INTEGER_32) tu4_1;
	RTLE;
	return Result;
}

/* {NATURAL_32_REF}.as_integer_64 */
EIF_INTEGER_64 F720_4080 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_32 tu4_1;
	EIF_INTEGER_64 Result = ((EIF_INTEGER_64) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tu4_1 = *(EIF_NATURAL_32 *)(Current+ _LNGOFF_0_0_0_0_);
	Result = (EIF_INTEGER_64) tu4_1;
	RTLE;
	return Result;
}

/* {NATURAL_32_REF}.to_natural_8 */
EIF_NATURAL_8 F720_4081 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_NATURAL_8) (FUNCTION_CAST(EIF_NATURAL_8, (EIF_REFERENCE)) R3130[Dtype(Current)-720])(Current);
}

/* {NATURAL_32_REF}.to_natural_16 */
EIF_NATURAL_16 F720_4082 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_NATURAL_16) (FUNCTION_CAST(EIF_NATURAL_16, (EIF_REFERENCE)) R3131[Dtype(Current)-720])(Current);
}

/* {NATURAL_32_REF}.to_natural_64 */
EIF_NATURAL_64 F720_4084 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_NATURAL_64) (FUNCTION_CAST(EIF_NATURAL_64, (EIF_REFERENCE)) R3133[Dtype(Current)-720])(Current);
}

/* {NATURAL_32_REF}.to_integer_32 */
EIF_INTEGER_32 F720_4087 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_INTEGER_32) (FUNCTION_CAST(EIF_INTEGER_32, (EIF_REFERENCE)) R3136[Dtype(Current)-720])(Current);
}

/* {NATURAL_32_REF}.to_integer_64 */
EIF_INTEGER_64 F720_4088 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_INTEGER_64) (FUNCTION_CAST(EIF_INTEGER_64, (EIF_REFERENCE)) R3137[Dtype(Current)-720])(Current);
}

/* {NATURAL_32_REF}.to_character_8 */
EIF_CHARACTER_8 F720_4098 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_32 tu4_1;
	EIF_CHARACTER_8 Result = ((EIF_CHARACTER_8) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tu4_1 = *(EIF_NATURAL_32 *)(Current+ _LNGOFF_0_0_0_0_);
	Result = (EIF_CHARACTER_8) tu4_1;
	RTLE;
	return Result;
}

/* {NATURAL_32_REF}.to_character_32 */
EIF_CHARACTER_32 F720_4099 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_32 tu4_1;
	EIF_CHARACTER_32 Result = ((EIF_CHARACTER_32) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tu4_1 = *(EIF_NATURAL_32 *)(Current+ _LNGOFF_0_0_0_0_);
	Result = (EIF_CHARACTER_32) tu4_1;
	RTLE;
	return Result;
}

/* {NATURAL_32_REF}.bit_and */
EIF_REFERENCE F720_4100 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_32 tu4_1;
	EIF_NATURAL_32 tu4_2;
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
	tu4_1 = *(EIF_NATURAL_32 *)(Current+ _LNGOFF_0_0_0_0_);
	tu4_2 = *(EIF_NATURAL_32 *)(RTCW(arg1)+ _LNGOFF_0_0_0_0_);
	tu4_1 = eif_bit_and(tu4_1,tu4_2);
	F720_4054(RTCW(Result), tu4_1);
	RTLE;
	return Result;
}

/* {NATURAL_32_REF}.bit_or */
EIF_REFERENCE F720_4101 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_32 tu4_1;
	EIF_NATURAL_32 tu4_2;
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
	tu4_1 = *(EIF_NATURAL_32 *)(Current+ _LNGOFF_0_0_0_0_);
	tu4_2 = *(EIF_NATURAL_32 *)(RTCW(arg1)+ _LNGOFF_0_0_0_0_);
	tu4_1 = eif_bit_or(tu4_1,tu4_2);
	F720_4054(RTCW(Result), tu4_1);
	RTLE;
	return Result;
}

/* {NATURAL_32_REF}.bit_shift_left */
EIF_REFERENCE F720_4105 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_NATURAL_32 tu4_1;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,Result);
	RTLIU(2);
	
	RTGC;
	Result = RTLNSMART(Dftype(Current));
	F1_29(RTCW(Result));
	tu4_1 = *(EIF_NATURAL_32 *)(Current+ _LNGOFF_0_0_0_0_);
	tu4_1 = eif_bit_shift_left(tu4_1,arg1);
	F720_4054(RTCW(Result), tu4_1);
	RTLE;
	return Result;
}

/* {NATURAL_32_REF}.bit_shift_right */
EIF_REFERENCE F720_4106 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_NATURAL_32 tu4_1;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,Result);
	RTLIU(2);
	
	RTGC;
	Result = RTLNSMART(Dftype(Current));
	F1_29(RTCW(Result));
	tu4_1 = *(EIF_NATURAL_32 *)(Current+ _LNGOFF_0_0_0_0_);
	tu4_1 = eif_bit_shift_right(tu4_1,arg1);
	F720_4054(RTCW(Result), tu4_1);
	RTLE;
	return Result;
}

void EIF_Minit168 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
