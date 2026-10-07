/*
 * Code for class INTEGER_64_REF
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "in154.h"
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

/* {INTEGER_64_REF}.hash_code */
EIF_INTEGER_32 F705_3574 (EIF_REFERENCE Current)
{
	GTCX
	EIF_INTEGER_64 ti8_1;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	ti8_1 = *(EIF_INTEGER_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_);
	ti8_1 = eif_bit_and(ti8_1,(EIF_INTEGER_64) ((EIF_INTEGER_32) 2147483647L));
	Result = (EIF_INTEGER_32) ti8_1;
	RTLE;
	return Result;
}

/* {INTEGER_64_REF}.is_less */
EIF_BOOLEAN F705_3581 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_INTEGER_64 ti8_1;
	EIF_INTEGER_64 ti8_2;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,arg1);
	RTLIU(2);
	
	RTGC;
	ti8_1 = *(EIF_INTEGER_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_);
	ti8_2 = *(EIF_INTEGER_64 *)(RTCW(arg1)+ _I64OFF_0_0_0_0_0_0_0_);
	Result = (EIF_BOOLEAN) (EIF_BOOLEAN) (ti8_1 < ti8_2);
	RTLE;
	return Result;
}

/* {INTEGER_64_REF}.is_equal */
EIF_BOOLEAN F705_3582 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_INTEGER_64 ti8_1;
	EIF_INTEGER_64 ti8_2;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,arg1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	ti8_1 = *(EIF_INTEGER_64 *)(RTCW(arg1)+ _I64OFF_0_0_0_0_0_0_0_);
	ti8_2 = *(EIF_INTEGER_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_);
	Result = (EIF_BOOLEAN) (EIF_BOOLEAN)(ti8_1 == ti8_2);
	RTLE;
	return Result;
}

/* {INTEGER_64_REF}.set_item */
void F705_3583 (EIF_REFERENCE Current, EIF_INTEGER_64 arg1)
{
	GTCX
	
	
	*(EIF_INTEGER_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_) = (EIF_INTEGER_64) arg1;
}

/* {INTEGER_64_REF}.plus */
EIF_REFERENCE F705_3591 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_INTEGER_64 ti8_1;
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
	ti8_1 = *(EIF_INTEGER_64 *)(RTCW(arg1)+ _I64OFF_0_0_0_0_0_0_0_);
	F705_3583(RTCW(Result), (EIF_INTEGER_64) (*(EIF_INTEGER_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_) + ti8_1));
	RTLE;
	return Result;
}

/* {INTEGER_64_REF}.minus */
EIF_REFERENCE F705_3592 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_INTEGER_64 ti8_1;
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
	ti8_1 = *(EIF_INTEGER_64 *)(RTCW(arg1)+ _I64OFF_0_0_0_0_0_0_0_);
	F705_3583(RTCW(Result), (EIF_INTEGER_64) (*(EIF_INTEGER_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_) - ti8_1));
	RTLE;
	return Result;
}

/* {INTEGER_64_REF}.opposite */
EIF_REFERENCE F705_3596 (EIF_REFERENCE Current)
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
	F705_3583(RTCW(Result), (EIF_INTEGER_64) -*(EIF_INTEGER_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_));
	RTLE;
	return Result;
}

/* {INTEGER_64_REF}.integer_quotient */
EIF_REFERENCE F705_3597 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_INTEGER_64 ti8_1;
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
	ti8_1 = *(EIF_INTEGER_64 *)(RTCW(arg1)+ _I64OFF_0_0_0_0_0_0_0_);
	F705_3583(RTCW(Result), (EIF_INTEGER_64) (*(EIF_INTEGER_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_) / ti8_1));
	RTLE;
	return Result;
}

/* {INTEGER_64_REF}.integer_remainder */
EIF_REFERENCE F705_3598 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_INTEGER_64 ti8_1;
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
	ti8_1 = *(EIF_INTEGER_64 *)(RTCW(arg1)+ _I64OFF_0_0_0_0_0_0_0_);
	F705_3583(RTCW(Result), (EIF_INTEGER_64) (*(EIF_INTEGER_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_) % ti8_1));
	RTLE;
	return Result;
}

/* {INTEGER_64_REF}.as_natural_64 */
EIF_NATURAL_64 F705_3606 (EIF_REFERENCE Current)
{
	GTCX
	EIF_INTEGER_64 ti8_1;
	EIF_NATURAL_64 Result = ((EIF_NATURAL_64) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	ti8_1 = *(EIF_INTEGER_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_);
	Result = (EIF_NATURAL_64) ti8_1;
	RTLE;
	return Result;
}

/* {INTEGER_64_REF}.as_integer_32 */
EIF_INTEGER_32 F705_3609 (EIF_REFERENCE Current)
{
	GTCX
	EIF_INTEGER_64 ti8_1;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	ti8_1 = *(EIF_INTEGER_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_);
	Result = (EIF_INTEGER_32) ti8_1;
	RTLE;
	return Result;
}

/* {INTEGER_64_REF}.to_natural_64 */
EIF_NATURAL_64 F705_3614 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_NATURAL_64) (FUNCTION_CAST(EIF_NATURAL_64, (EIF_REFERENCE)) R2864[Dtype(Current)-705])(Current);
}

/* {INTEGER_64_REF}.to_integer_32 */
EIF_INTEGER_32 F705_3618 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_INTEGER_32) (FUNCTION_CAST(EIF_INTEGER_32, (EIF_REFERENCE)) R2867[Dtype(Current)-705])(Current);
}

/* {INTEGER_64_REF}.to_character_8 */
EIF_CHARACTER_8 F705_3629 (EIF_REFERENCE Current)
{
	GTCX
	EIF_INTEGER_64 ti8_1;
	EIF_CHARACTER_8 Result = ((EIF_CHARACTER_8) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	ti8_1 = *(EIF_INTEGER_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_);
	Result = (EIF_CHARACTER_8) ti8_1;
	RTLE;
	return Result;
}

/* {INTEGER_64_REF}.bit_and */
EIF_REFERENCE F705_3631 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_INTEGER_64 ti8_1;
	EIF_INTEGER_64 ti8_2;
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
	ti8_1 = *(EIF_INTEGER_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_);
	ti8_2 = *(EIF_INTEGER_64 *)(RTCW(arg1)+ _I64OFF_0_0_0_0_0_0_0_);
	ti8_1 = eif_bit_and(ti8_1,ti8_2);
	F705_3583(RTCW(Result), ti8_1);
	RTLE;
	return Result;
}

/* {INTEGER_64_REF}.out */
EIF_REFERENCE F705_3641 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,Result);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	Result = RTLNS(eif_new_type(783, 0x01).id, 783, _OBJSIZ_1_1_0_3_0_0_0_0_);
	F782_4900(RTCW(Result), ((EIF_INTEGER_32) 20L));
	F784_5019(RTCW(Result), *(EIF_INTEGER_64 *)(Current+ _I64OFF_0_0_0_0_0_0_0_));
	RTLE;
	return Result;
}

void EIF_Minit154 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
