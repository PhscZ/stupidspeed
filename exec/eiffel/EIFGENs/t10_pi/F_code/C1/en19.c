/*
 * Code for class ENCODING_HELPER
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "en19.h"
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

/* {ENCODING_HELPER}.multi_byte_to_pointer */
EIF_REFERENCE F32_550 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(3);
	RTLR(0,tr1);
	RTLR(1,arg1);
	RTLR(2,Result);
	RTLIU(3);
	
	RTGC;
	tr1 = RTLNS(eif_new_type(127, 0x01).id, 127, _OBJSIZ_1_0_0_1_0_0_0_0_);
	F128_1457(RTCW(tr1), arg1);
	Result = *(EIF_REFERENCE *)(RTCW(tr1));
	RTLE;
	return Result;
}

/* {ENCODING_HELPER}.wide_string_to_pointer */
EIF_REFERENCE F32_551 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_INTEGER_32 loc1 = (EIF_INTEGER_32) 0;
	EIF_INTEGER_32 loc2 = (EIF_INTEGER_32) 0;
	EIF_NATURAL_32 tu4_1;
	EIF_NATURAL_16 tu2_1;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,arg1);
	RTLR(1,Result);
	RTLIU(2);
	
	RTGC;
	loc2 = *(EIF_INTEGER_32 *)(RTCW(arg1) + O3700[Dtype(arg1)-817]);
	Result = RTLNS(eif_new_type(117, 0x01).id, 117, _OBJSIZ_0_1_0_1_0_1_1_0_);
	F118_1219(RTCW(Result), (EIF_INTEGER_32) ((EIF_INTEGER_32) (loc2 + ((EIF_INTEGER_32) 1L)) * ((EIF_INTEGER_32) 2L)));
	loc1 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 0L);
	for (;;) {
		if ((EIF_BOOLEAN)(loc1 == loc2)) break;
		tu4_1 = (FUNCTION_CAST(EIF_NATURAL_32, (EIF_REFERENCE, EIF_INTEGER_32)) R3465[Dtype(RTCW(arg1))-815])(arg1, (EIF_INTEGER_32) (loc1 + ((EIF_INTEGER_32) 1L)));
		tu2_1 = (EIF_NATURAL_16) tu4_1;
		F118_1251(RTCW(Result), tu2_1, (EIF_INTEGER_32) (loc1 * ((EIF_INTEGER_32) 2L)));
		loc1++;
	}
	F118_1251(RTCW(Result), (EIF_NATURAL_16) ((EIF_INTEGER_32) 0L), (EIF_INTEGER_32) (loc1 * ((EIF_INTEGER_32) 2L)));
	RTLE;
	return Result;
}

/* {ENCODING_HELPER}.pointer_to_multi_byte */
EIF_REFERENCE F32_552 (EIF_REFERENCE Current, EIF_POINTER arg1, EIF_INTEGER_32 arg2)
{
	GTCX
	EIF_INTEGER_32 loc1 = (EIF_INTEGER_32) 0;
	EIF_REFERENCE loc2 = (EIF_REFERENCE) 0;
	EIF_NATURAL_32 tu4_1;
	EIF_NATURAL_8 tu1_1;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,loc2);
	RTLR(1,Result);
	RTLIU(2);
	
	RTGC;
	loc2 = RTLNS(eif_new_type(117, 0x01).id, 117, _OBJSIZ_0_1_0_1_0_1_1_0_);
	F118_1222(RTCW(loc2), arg1, arg2);
	Result = RTLNS(eif_new_type(816, 0x01).id, 816, _OBJSIZ_1_1_0_3_0_0_0_0_);
	F815_4749(RTCW(Result), arg2);
	loc1 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 0L);
	for (;;) {
		if ((EIF_BOOLEAN) (loc1 >= arg2)) break;
		tu1_1 = F118_1230(RTCW(loc2), loc1);
		tu4_1 = (EIF_NATURAL_32) tu1_1;
		F814_4719(RTCW(Result), tu4_1);
		loc1++;
	}
	RTLE;
	return Result;
}

/* {ENCODING_HELPER}.pointer_to_wide_string */
EIF_REFERENCE F32_553 (EIF_REFERENCE Current, EIF_POINTER arg1, EIF_INTEGER_32 arg2)
{
	GTCX
	EIF_INTEGER_32 loc1 = (EIF_INTEGER_32) 0;
	EIF_REFERENCE loc2 = (EIF_REFERENCE) 0;
	EIF_INTEGER_32 loc3 = (EIF_INTEGER_32) 0;
	EIF_NATURAL_32 tu4_1;
	EIF_NATURAL_16 tu2_1;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,loc2);
	RTLR(1,Result);
	RTLIU(2);
	
	RTGC;
	loc2 = RTLNS(eif_new_type(117, 0x01).id, 117, _OBJSIZ_0_1_0_1_0_1_1_0_);
	F118_1222(RTCW(loc2), arg1, arg2);
	loc3 = (EIF_INTEGER_32) (EIF_INTEGER_32) ((EIF_INTEGER_32) (arg2 + ((EIF_INTEGER_32) 1L)) / ((EIF_INTEGER_32) 2L));
	Result = RTLNS(eif_new_type(819, 0x01).id, 819, _OBJSIZ_1_1_0_3_0_0_0_0_);
	F818_4915(RTCW(Result), loc3);
	loc1 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 0L);
	for (;;) {
		if ((EIF_BOOLEAN) (loc1 >= loc3)) break;
		if ((EIF_BOOLEAN) ((EIF_INTEGER_32) (loc1 * ((EIF_INTEGER_32) 2L)) <= arg2)) {
			tu2_1 = F118_1231(RTCW(loc2), (EIF_INTEGER_32) (loc1 * ((EIF_INTEGER_32) 2L)));
			tu4_1 = (EIF_NATURAL_32) tu2_1;
			F814_4719(RTCW(Result), tu4_1);
		}
		loc1++;
	}
	RTLE;
	return Result;
}

/* {ENCODING_HELPER}.string_32_to_multi_byte */
EIF_REFERENCE F32_555 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_INTEGER_32 loc1 = (EIF_INTEGER_32) 0;
	EIF_NATURAL_32 loc2 = (EIF_NATURAL_32) 0;
	EIF_INTEGER_32 loc3 = (EIF_INTEGER_32) 0;
	EIF_BOOLEAN loc4 = (EIF_BOOLEAN) 0;
	EIF_NATURAL_32 tu4_1;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(3);
	RTLR(0,arg1);
	RTLR(1,Result);
	RTLR(2,Current);
	RTLIU(3);
	
	RTGC;
	loc3 = *(EIF_INTEGER_32 *)(RTCW(arg1)+ _LNGOFF_1_1_0_2_);
	if ((EIF_BOOLEAN) (loc3 > ((EIF_INTEGER_32) 0L))) {
		Result = RTLNS(eif_new_type(816, 0x01).id, 816, _OBJSIZ_1_1_0_3_0_0_0_0_);
		F815_4749(RTCW(Result), (EIF_INTEGER_32) (loc3 * ((EIF_INTEGER_32) 4L)));
		loc1 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 1L);
		loc4 = RTOSCF(561,F32_561, (Current));
		for (;;) {
			if ((EIF_BOOLEAN) (loc1 > loc3)) break;
			loc2 = F820_4999(RTCW(arg1), loc1);
			if (loc4) {
				tu4_1 = eif_bit_and(loc2,(EIF_NATURAL_32) ((EIF_INTEGER_32) 255L));
				F814_4719(RTCW(Result), tu4_1);
				tu4_1 = eif_bit_and(loc2,(EIF_NATURAL_32) ((EIF_INTEGER_32) 65280L));
				tu4_1 = eif_bit_shift_right(tu4_1,((EIF_INTEGER_32) 8L));
				F814_4719(RTCW(Result), tu4_1);
				tu4_1 = eif_bit_and(loc2,(EIF_NATURAL_32) ((EIF_INTEGER_32) 16711680L));
				tu4_1 = eif_bit_shift_right(tu4_1,((EIF_INTEGER_32) 16L));
				F814_4719(RTCW(Result), tu4_1);
				tu4_1 = eif_bit_and(loc2,(EIF_NATURAL_32) ((EIF_INTEGER_64) RTI64C(4278190080)));
				tu4_1 = eif_bit_shift_right(tu4_1,((EIF_INTEGER_32) 24L));
				F814_4719(RTCW(Result), tu4_1);
			} else {
				tu4_1 = eif_bit_and(loc2,(EIF_NATURAL_32) ((EIF_INTEGER_64) RTI64C(4278190080)));
				tu4_1 = eif_bit_shift_right(tu4_1,((EIF_INTEGER_32) 24L));
				F814_4719(RTCW(Result), tu4_1);
				tu4_1 = eif_bit_and(loc2,(EIF_NATURAL_32) ((EIF_INTEGER_32) 16711680L));
				tu4_1 = eif_bit_shift_right(tu4_1,((EIF_INTEGER_32) 16L));
				F814_4719(RTCW(Result), tu4_1);
				tu4_1 = eif_bit_and(loc2,(EIF_NATURAL_32) ((EIF_INTEGER_32) 65280L));
				tu4_1 = eif_bit_shift_right(tu4_1,((EIF_INTEGER_32) 8L));
				F814_4719(RTCW(Result), tu4_1);
				tu4_1 = eif_bit_and(loc2,(EIF_NATURAL_32) ((EIF_INTEGER_32) 255L));
				F814_4719(RTCW(Result), tu4_1);
			}
			loc1++;
		}
	} else {
		Result = RTLNS(eif_new_type(816, 0x01).id, 816, _OBJSIZ_1_1_0_3_0_0_0_0_);
		F812_4619(RTCW(Result));
		RTLE;
		return (EIF_REFERENCE) Result;
	}
	RTLE;
	return Result;
}

/* {ENCODING_HELPER}.string_16_to_stream */
EIF_REFERENCE F32_557 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE loc1 = (EIF_REFERENCE) 0;
	EIF_INTEGER_32 loc2 = (EIF_INTEGER_32) 0;
	EIF_INTEGER_32 loc3 = (EIF_INTEGER_32) 0;
	EIF_INTEGER_32 ti4_1;
	EIF_NATURAL_8 tu1_1;
	EIF_CHARACTER_8 tc1;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(4);
	RTLR(0,loc1);
	RTLR(1,arg1);
	RTLR(2,Current);
	RTLR(3,Result);
	RTLIU(4);
	
	RTGC;
	loc1 = F32_551(Current, arg1);
	Result = RTLNS(eif_new_type(816, 0x01).id, 816, _OBJSIZ_1_1_0_3_0_0_0_0_);
	ti4_1 = *(EIF_INTEGER_32 *)(RTCW(loc1)+ _LNGOFF_0_1_0_0_);
	F815_4749(RTCW(Result), ti4_1);
	loc2 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 0L);
	loc3 = *(EIF_INTEGER_32 *)(RTCW(loc1)+ _LNGOFF_0_1_0_0_);
	loc3 = (EIF_INTEGER_32) (EIF_INTEGER_32) (loc3 - ((EIF_INTEGER_32) 2L));
	for (;;) {
		if ((EIF_BOOLEAN)(loc2 == loc3)) break;
		tu1_1 = F118_1230(RTCW(loc1), loc2);
		tc1 = (EIF_CHARACTER_8) tu1_1;
		F817_4875(RTCW(Result), tc1);
		loc2++;
	}
	RTLE;
	return Result;
}

/* {ENCODING_HELPER}.string_general_to_stream */
EIF_REFERENCE F32_558 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_BOOLEAN tb1;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(4);
	RTLR(0,arg1);
	RTLR(1,tr1);
	RTLR(2,Current);
	RTLR(3,Result);
	RTLIU(4);
	
	RTGC;
	tb1 = (FUNCTION_CAST(EIF_BOOLEAN, (EIF_REFERENCE)) R3479[Dtype(RTCW(arg1))-815])(arg1);
	if (tb1) {
		tr1 = F812_4672(RTCW(arg1));
		RTLE;
		return (EIF_REFERENCE) tr1;
	} else {
		tr1 = F812_4678(RTCW(arg1));
		Result = F32_555(Current, tr1);
	}
	RTLE;
	return Result;
}

/* {ENCODING_HELPER}.string_32_switch_endian */
EIF_REFERENCE F32_559 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_32 loc1 = (EIF_NATURAL_32) 0;
	EIF_INTEGER_32 loc2 = (EIF_INTEGER_32) 0;
	EIF_INTEGER_32 loc3 = (EIF_INTEGER_32) 0;
	EIF_NATURAL_32 tu4_1;
	EIF_NATURAL_32 tu4_2;
	EIF_NATURAL_32 tu4_3;
	EIF_NATURAL_32 tu4_4;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,arg1);
	RTLR(1,Result);
	RTLIU(2);
	
	RTGC;
	loc3 = *(EIF_INTEGER_32 *)(RTCW(arg1)+ _LNGOFF_1_1_0_2_);
	Result = RTLNS(eif_new_type(819, 0x01).id, 819, _OBJSIZ_1_1_0_3_0_0_0_0_);
	F818_4915(RTCW(Result), loc3);
	loc2 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 1L);
	for (;;) {
		if ((EIF_BOOLEAN) (loc2 > loc3)) break;
		loc1 = F820_4999(RTCW(arg1), loc2);
		tu4_1 = eif_bit_and(loc1,(EIF_NATURAL_32) ((EIF_INTEGER_32) 255L));
		tu4_1 = eif_bit_shift_left(tu4_1,((EIF_INTEGER_32) 24L));
		tu4_1 = eif_bit_and(tu4_1,(EIF_NATURAL_32) ((EIF_INTEGER_64) RTI64C(4278190080)));
		tu4_2 = eif_bit_and(loc1,(EIF_NATURAL_32) ((EIF_INTEGER_32) 65280L));
		tu4_2 = eif_bit_shift_left(tu4_2,((EIF_INTEGER_32) 8L));
		tu4_3 = eif_bit_and(loc1,(EIF_NATURAL_32) ((EIF_INTEGER_32) 16711680L));
		tu4_3 = eif_bit_shift_right(tu4_3,((EIF_INTEGER_32) 8L));
		tu4_4 = eif_bit_and(loc1,(EIF_NATURAL_32) ((EIF_INTEGER_64) RTI64C(4278190080)));
		tu4_4 = eif_bit_shift_right(tu4_4,((EIF_INTEGER_32) 24L));
		tu4_4 = eif_bit_and(tu4_4,(EIF_NATURAL_32) ((EIF_INTEGER_32) 255L));
		F814_4719(RTCW(Result), (EIF_NATURAL_32) ((EIF_NATURAL_32) ((EIF_NATURAL_32) (tu4_1 + tu4_2) + tu4_3) + tu4_4));
		loc2++;
	}
	RTLE;
	return Result;
}

/* {ENCODING_HELPER}.string_16_switch_endian */
EIF_REFERENCE F32_560 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_32 loc1 = (EIF_NATURAL_32) 0;
	EIF_INTEGER_32 loc2 = (EIF_INTEGER_32) 0;
	EIF_INTEGER_32 loc3 = (EIF_INTEGER_32) 0;
	EIF_NATURAL_32 tu4_1;
	EIF_NATURAL_32 tu4_2;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,arg1);
	RTLR(1,Result);
	RTLIU(2);
	
	RTGC;
	loc3 = *(EIF_INTEGER_32 *)(RTCW(arg1)+ _LNGOFF_1_1_0_2_);
	Result = RTLNS(eif_new_type(819, 0x01).id, 819, _OBJSIZ_1_1_0_3_0_0_0_0_);
	F818_4915(RTCW(Result), loc3);
	loc2 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 1L);
	for (;;) {
		if ((EIF_BOOLEAN) (loc2 > loc3)) break;
		loc1 = F820_4999(RTCW(arg1), loc2);
		tu4_1 = eif_bit_and(loc1,(EIF_NATURAL_32) ((EIF_INTEGER_32) 255L));
		tu4_1 = eif_bit_shift_left(tu4_1,((EIF_INTEGER_32) 8L));
		tu4_1 = eif_bit_and(tu4_1,(EIF_NATURAL_32) ((EIF_INTEGER_32) 65280L));
		tu4_2 = eif_bit_and(loc1,(EIF_NATURAL_32) ((EIF_INTEGER_32) 65280L));
		tu4_2 = eif_bit_shift_right(tu4_2,((EIF_INTEGER_32) 8L));
		tu4_2 = eif_bit_and(tu4_2,(EIF_NATURAL_32) ((EIF_INTEGER_32) 255L));
		F814_4719(RTCW(Result), (EIF_NATURAL_32) (tu4_1 + tu4_2));
		loc2++;
	}
	RTLE;
	return Result;
}

/* {ENCODING_HELPER}.is_little_endian */
static EIF_BOOLEAN F32_561_body (EIF_REFERENCE Current)
{
	GTCX
	RTEX;
	EIF_REFERENCE tr1 = NULL;
	

	
	RTEV;
	RTOSP (561);
#define Result RTOSR(561)
	tr1 = RTLNS(eif_new_type(52, 0x01).id, 52, _OBJSIZ_0_0_0_0_0_0_0_0_);
	Result = RTOSCF(748,F53_748, (RTCW(tr1)));
	RTOSE (561);
	RTEE;
	return Result;
#undef Result
}

EIF_BOOLEAN F32_561 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(561,F32_561_body,(Current));
}

void EIF_Minit19 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
