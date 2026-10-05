/*
 * Code for class UNICODE_CONVERSION
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "un208.h"
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

/* {UNICODE_CONVERSION}.is_code_page_valid */
EIF_BOOLEAN F795_5229 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_BOOLEAN tb1;
	EIF_BOOLEAN tb2;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(3);
	RTLR(0,arg1);
	RTLR(1,Current);
	RTLR(2,tr1);
	RTLIU(3);
	
	RTGC;
	tb1 = '\0';
	if ((EIF_BOOLEAN)(arg1 != NULL)) {
		tb2 = (FUNCTION_CAST(EIF_BOOLEAN, (EIF_REFERENCE)) R3515[Dtype(RTCW(arg1))-785])(arg1);
		tb1 = (EIF_BOOLEAN) !tb2;
	}
	if (tb1) {
		tr1 = RTOUCR(60,F795_5241, (Current));
		Result = F601_2988(RTCW(tr1), arg1);
	}
	RTLE;
	return Result;
}

/* {UNICODE_CONVERSION}.is_code_page_convertible */
EIF_BOOLEAN F795_5230 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_BOOLEAN tb1;
	EIF_BOOLEAN tb2;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(4);
	RTLR(0,arg1);
	RTLR(1,Current);
	RTLR(2,tr1);
	RTLR(3,arg2);
	RTLIU(4);
	
	RTGC;
	Result = '\0';
	tr1 = RTOUCR(49,F4_58, (Current));
	if ((EIF_BOOLEAN)(arg1 == tr1)) {
		tr1 = RTOUCR(51,F4_60, (Current));
		Result = (EIF_BOOLEAN)(arg2 == tr1);
	}
	if ((EIF_BOOLEAN) !Result) {
		tr1 = RTOUCR(49,F4_58, (Current));
		tb1 = F785_4812(RTCW(arg1), tr1);
		if (tb1) {
			Result = '\01';
			tr1 = RTOUCR(49,F4_58, (Current));
			tb1 = F785_4812(RTCW(arg2), tr1);
			if (!tb1) {
				tr1 = RTOUCR(51,F4_60, (Current));
				tb1 = F785_4812(RTCW(arg2), tr1);
				Result = tb1;
			}
		} else {
			tr1 = RTOUCR(51,F4_60, (Current));
			tb1 = F785_4812(RTCW(arg1), tr1);
			if (tb1) {
				Result = '\01';
				tb1 = '\01';
				tr1 = RTOUCR(51,F4_60, (Current));
				tb2 = F785_4812(RTCW(arg2), tr1);
				if (!tb2) {
					tr1 = RTOUCR(49,F4_58, (Current));
					tb2 = F785_4812(RTCW(arg2), tr1);
					tb1 = tb2;
				}
				if (!tb1) {
					tr1 = RTOUCR(50,F4_59, (Current));
					tb1 = F785_4812(RTCW(arg2), tr1);
					Result = tb1;
				}
			} else {
				tr1 = RTOUCR(50,F4_59, (Current));
				tb1 = F785_4812(RTCW(arg1), tr1);
				if (tb1) {
					Result = '\01';
					tr1 = RTOUCR(50,F4_59, (Current));
					tb1 = F785_4812(RTCW(arg2), tr1);
					if (!tb1) {
						tr1 = RTOUCR(51,F4_60, (Current));
						tb1 = F785_4812(RTCW(arg2), tr1);
						Result = tb1;
					}
				} else {
					tr1 = RTOUCR(48,F4_57, (Current));
					tb1 = F785_4812(RTCW(arg1), tr1);
					if (tb1) {
						tr1 = RTOUCR(48,F4_57, (Current));
						Result = F785_4812(RTCW(arg2), tr1);
					}
				}
			}
		}
	}
	RTLE;
	return Result;
}

/* {UNICODE_CONVERSION}.convert_to */
void F795_5234 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2, EIF_REFERENCE arg3)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE tr2 = NULL;
	EIF_BOOLEAN tb1;
	RTLD;
	
	RTLI(6);
	RTLR(0,Current);
	RTLR(1,arg1);
	RTLR(2,arg3);
	RTLR(3,arg2);
	RTLR(4,tr1);
	RTLR(5,tr2);
	RTLIU(6);
	
	RTGC;
	F793_5203(Current);
	tb1 = F785_4812(RTCW(arg1), arg3);
	if (tb1) {
		*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 1;
		tb1 = (FUNCTION_CAST(EIF_BOOLEAN, (EIF_REFERENCE)) R3512[Dtype(RTCW(arg2))-785])(arg2);
		if (tb1) {
			tr1 = F782_4709(RTCW(arg2));
			RTAR(Current, tr1);
			*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
		} else {
			tr1 = F782_4715(RTCW(arg2));
			RTAR(Current, tr1);
			*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
		}
	} else {
		tr1 = RTOUCR(49,F4_58, (Current));
		tb1 = F785_4812(RTCW(arg1), tr1);
		if (tb1) {
			tb1 = (FUNCTION_CAST(EIF_BOOLEAN, (EIF_REFERENCE)) R3514[Dtype(RTCW(arg2))-785])(arg2);
			if (tb1) {
				tr1 = F782_4709(RTCW(arg2));
			} else {
				tr2 = RTLNS(eif_new_type(10, 0x00).id, 10, _OBJSIZ_0_0_0_0_0_0_0_0_);
				tr1 = F11_253(RTCW(tr2), arg2);
			}
			tr1 = F795_5235(Current, tr1);
			RTAR(Current, tr1);
			*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
			*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 1;
		} else {
			tr1 = RTOUCR(51,F4_60, (Current));
			tb1 = F785_4812(RTCW(arg1), tr1);
			if (tb1) {
				tr1 = RTOUCR(49,F4_58, (Current));
				tb1 = F785_4812(RTCW(arg3), tr1);
				if (tb1) {
					tr1 = F782_4715(RTCW(arg2));
					tr1 = F795_5236(Current, tr1);
					RTAR(Current, tr1);
					*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
					*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 1;
				} else {
					tr1 = RTOUCR(50,F4_59, (Current));
					tb1 = F785_4812(RTCW(arg3), tr1);
					if (tb1) {
						tr1 = F782_4715(RTCW(arg2));
						tr1 = F795_5237(Current, tr1);
						RTAR(Current, tr1);
						*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
						*(EIF_BOOLEAN *)(Current+ _CHROFF_1_1_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 1;
						*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 1;
					}
				}
			} else {
				tr1 = RTOUCR(50,F4_59, (Current));
				tb1 = F785_4812(RTCW(arg1), tr1);
				if (tb1) {
					tr1 = RTOUCR(51,F4_60, (Current));
					tb1 = F785_4812(RTCW(arg3), tr1);
					if (tb1) {
						tr1 = F782_4715(RTCW(arg2));
						tr1 = F795_5238(Current, tr1);
						RTAR(Current, tr1);
						*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
						*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 1;
					}
				}
			}
		}
	}
	RTLE;
}

/* {UNICODE_CONVERSION}.utf8_to_utf32 */
EIF_REFERENCE F795_5235 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
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
	tr1 = RTLNS(eif_new_type(10, 0x00).id, 10, _OBJSIZ_0_0_0_0_0_0_0_0_);
	Result = F11_267(RTCW(tr1), arg1);
	RTLE;
	return Result;
}

/* {UNICODE_CONVERSION}.utf32_to_utf8 */
EIF_REFERENCE F795_5236 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
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
	tr1 = RTLNS(eif_new_type(10, 0x00).id, 10, _OBJSIZ_0_0_0_0_0_0_0_0_);
	Result = F11_253(RTCW(tr1), arg1);
	RTLE;
	return Result;
}

/* {UNICODE_CONVERSION}.utf32_to_utf16 */
EIF_REFERENCE F795_5237 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_NATURAL_32 loc1 = (EIF_NATURAL_32) 0;
	EIF_INTEGER_32 loc2 = (EIF_INTEGER_32) 0;
	EIF_INTEGER_32 loc3 = (EIF_INTEGER_32) 0;
	EIF_INTEGER_32 ti4_1;
	EIF_NATURAL_32 tu4_1;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,arg1);
	RTLR(1,Result);
	RTLIU(2);
	
	RTGC;
	Result = RTLNS(eif_new_type(789, 0x01).id, 789, _OBJSIZ_1_1_0_3_0_0_0_0_);
	ti4_1 = *(EIF_INTEGER_32 *)(RTCW(arg1) + O3735[Dtype(arg1)-787]);
	F788_4952(RTCW(Result), (EIF_INTEGER_32) (ti4_1 * ((EIF_INTEGER_32) 2L)));
	loc2 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 1L);
	loc3 = *(EIF_INTEGER_32 *)(RTCW(arg1) + O3735[Dtype(arg1)-787]);
	for (;;) {
		if ((EIF_BOOLEAN) (loc2 > loc3)) break;
		tu4_1 = (FUNCTION_CAST(EIF_NATURAL_32, (EIF_REFERENCE, EIF_INTEGER_32)) R3500[Dtype(RTCW(arg1))-785])(arg1, loc2);
		loc1 = eif_bit_and(tu4_1,(EIF_NATURAL_32) ((EIF_INTEGER_32) 1048575L));
		if ((EIF_BOOLEAN) (loc1 > (EIF_NATURAL_32) ((EIF_INTEGER_32) 65535L))) {
			loc1 -= (EIF_NATURAL_32) ((EIF_INTEGER_32) 65536L);
			tu4_1 = eif_bit_shift_right(loc1,((EIF_INTEGER_32) 10L));
			tu4_1 = eif_bit_or(tu4_1,(EIF_NATURAL_32) ((EIF_INTEGER_32) 55296L));
			F784_4756(RTCW(Result), tu4_1);
			tu4_1 = eif_bit_and(loc1,(EIF_NATURAL_32) ((EIF_INTEGER_32) 1023L));
			tu4_1 = eif_bit_or(tu4_1,(EIF_NATURAL_32) ((EIF_INTEGER_32) 56320L));
			F784_4756(RTCW(Result), tu4_1);
		} else {
			F784_4756(RTCW(Result), loc1);
		}
		loc2++;
	}
	RTLE;
	return Result;
}

/* {UNICODE_CONVERSION}.utf16_to_utf32 */
EIF_REFERENCE F795_5238 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_INTEGER_32 loc1 = (EIF_INTEGER_32) 0;
	EIF_INTEGER_32 loc2 = (EIF_INTEGER_32) 0;
	EIF_NATURAL_32 loc3 = (EIF_NATURAL_32) 0;
	EIF_NATURAL_32 loc4 = (EIF_NATURAL_32) 0;
	EIF_NATURAL_32 loc5 = (EIF_NATURAL_32) 0;
	EIF_NATURAL_32 tu4_1;
	EIF_NATURAL_32 tu4_2;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,arg1);
	RTLR(1,Result);
	RTLIU(2);
	
	RTGC;
	loc2 = *(EIF_INTEGER_32 *)(RTCW(arg1) + O3735[Dtype(arg1)-787]);
	Result = RTLNS(eif_new_type(789, 0x01).id, 789, _OBJSIZ_1_1_0_3_0_0_0_0_);
	F788_4952(RTCW(Result), loc2);
	loc1 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 1L);
	for (;;) {
		if ((EIF_BOOLEAN) (loc1 > loc2)) break;
		loc3 = (FUNCTION_CAST(EIF_NATURAL_32, (EIF_REFERENCE, EIF_INTEGER_32)) R3500[Dtype(RTCW(arg1))-785])(arg1, loc1);
		loc1++;
		loc4 = eif_bit_and(loc3,(EIF_NATURAL_32) ((EIF_INTEGER_32) 65535L));
		if ((EIF_BOOLEAN) (loc1 <= loc2)) {
			tu4_1 = (FUNCTION_CAST(EIF_NATURAL_32, (EIF_REFERENCE, EIF_INTEGER_32)) R3500[Dtype(RTCW(arg1))-785])(arg1, loc1);
			loc5 = eif_bit_and(tu4_1,(EIF_NATURAL_32) ((EIF_INTEGER_32) 65535L));
		}
		if ((EIF_BOOLEAN) ((EIF_BOOLEAN) ((EIF_BOOLEAN) ((EIF_BOOLEAN) ((EIF_BOOLEAN) (loc4 >= (EIF_NATURAL_32) ((EIF_INTEGER_32) 55296L)) && (EIF_BOOLEAN) (loc4 <= (EIF_NATURAL_32) ((EIF_INTEGER_32) 56319L))) && (EIF_BOOLEAN) (loc1 <= loc2)) && (EIF_BOOLEAN) (loc5 >= (EIF_NATURAL_32) ((EIF_INTEGER_32) 56320L))) && (EIF_BOOLEAN) (loc5 <= (EIF_NATURAL_32) ((EIF_INTEGER_32) 57343L)))) {
			tu4_1 = eif_bit_and(loc4,(EIF_NATURAL_32) ((EIF_INTEGER_32) 1023L));
			tu4_1 = eif_bit_shift_left(tu4_1,((EIF_INTEGER_32) 10L));
			tu4_2 = eif_bit_and(loc5,(EIF_NATURAL_32) ((EIF_INTEGER_32) 1023L));
			F784_4756(RTCW(Result), (EIF_NATURAL_32) ((EIF_NATURAL_32) (tu4_1 + tu4_2) + (EIF_NATURAL_32) ((EIF_INTEGER_32) 65536L)));
			loc1++;
		} else {
			F784_4756(RTCW(Result), loc4);
		}
	}
	RTLE;
	return Result;
}

/* {UNICODE_CONVERSION}.unicode_encodings */
static EIF_REFERENCE F795_5241_body (EIF_REFERENCE Current)
{
	GTCX
	RTEX;
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE tr2 = NULL;
	RTLD;
	
#define Result RTOTRR
	RTOUDR(60)

	RTLI(3);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLR(2,tr2);
	RTLIU(3);
	
	RTEV;
	RTGC;
	RTOTP;
	{
		static EIF_TYPE_INDEX typarr0[] = {0xFF01,604,0xFF01,784,0xFFFF};
		EIF_TYPE typres0;
		static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
		
		typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
		tr1 = RTLNS(typres0.id, 604, _OBJSIZ_7_4_0_7_0_0_0_0_);
	}
	F601_2980(RTCW(tr1), ((EIF_INTEGER_32) 8L));
	Result = (EIF_REFERENCE) tr1;
	tr1 = RTOUCR(48,F4_57, (Current));
	tr2 = RTOUCR(48,F4_57, (Current));
	F601_3026(RTCW(Result), tr1, tr2);
	tr1 = RTOUCR(49,F4_58, (Current));
	tr2 = RTOUCR(49,F4_58, (Current));
	F601_3026(RTCW(Result), tr1, tr2);
	tr1 = RTOUCR(50,F4_59, (Current));
	tr2 = RTOUCR(50,F4_59, (Current));
	F601_3026(RTCW(Result), tr1, tr2);
	tr1 = RTOUCR(52,F4_61, (Current));
	tr2 = RTOUCR(52,F4_61, (Current));
	F601_3026(RTCW(Result), tr1, tr2);
	tr1 = RTOUCR(51,F4_60, (Current));
	tr2 = RTOUCR(51,F4_60, (Current));
	F601_3026(RTCW(Result), tr1, tr2);
	tr1 = RTOUCR(53,F4_62, (Current));
	tr2 = RTOUCR(53,F4_62, (Current));
	F601_3026(RTCW(Result), tr1, tr2);
	tr1 = RTOUCR(54,F4_63, (Current));
	tr2 = RTOUCR(54,F4_63, (Current));
	F601_3026(RTCW(Result), tr1, tr2);
	tr1 = RTOUCR(55,F4_64, (Current));
	tr2 = RTOUCR(55,F4_64, (Current));
	F601_3026(RTCW(Result), tr1, tr2);
	RTOTE;
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F795_5241 (EIF_REFERENCE Current)
{
	GTCX
	return RTOUCR(60,F795_5241_body,(Current));
}

void EIF_Minit208 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
