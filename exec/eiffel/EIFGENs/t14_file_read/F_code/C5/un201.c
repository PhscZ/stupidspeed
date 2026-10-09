/*
 * Code for class UNICODE_CONVERSION
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "un201.h"
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
EIF_BOOLEAN F787_5153 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
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
		tb2 = (FUNCTION_CAST(EIF_BOOLEAN, (EIF_REFERENCE)) R3462[Dtype(RTCW(arg1))-778])(arg1);
		tb1 = (EIF_BOOLEAN) !tb2;
	}
	if (tb1) {
		tr1 = RTOSCF(5165,F787_5165, (Current));
		Result = F594_2933(RTCW(tr1), arg1);
	}
	RTLE;
	return Result;
}

/* {UNICODE_CONVERSION}.is_code_page_convertible */
EIF_BOOLEAN F787_5154 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
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
	tr1 = RTOSCF(58,F4_58, (Current));
	if ((EIF_BOOLEAN)(arg1 == tr1)) {
		tr1 = RTOSCF(60,F4_60, (Current));
		Result = (EIF_BOOLEAN)(arg2 == tr1);
	}
	if ((EIF_BOOLEAN) !Result) {
		tr1 = RTOSCF(58,F4_58, (Current));
		tb1 = F781_4924(RTCW(arg1), tr1);
		if (tb1) {
			Result = '\01';
			tr1 = RTOSCF(58,F4_58, (Current));
			tb1 = F781_4924(RTCW(arg2), tr1);
			if (!tb1) {
				tr1 = RTOSCF(60,F4_60, (Current));
				tb1 = F781_4924(RTCW(arg2), tr1);
				Result = tb1;
			}
		} else {
			tr1 = RTOSCF(60,F4_60, (Current));
			tb1 = F781_4924(RTCW(arg1), tr1);
			if (tb1) {
				Result = '\01';
				tb1 = '\01';
				tr1 = RTOSCF(60,F4_60, (Current));
				tb2 = F781_4924(RTCW(arg2), tr1);
				if (!tb2) {
					tr1 = RTOSCF(58,F4_58, (Current));
					tb2 = F781_4924(RTCW(arg2), tr1);
					tb1 = tb2;
				}
				if (!tb1) {
					tr1 = RTOSCF(59,F4_59, (Current));
					tb1 = F781_4924(RTCW(arg2), tr1);
					Result = tb1;
				}
			} else {
				tr1 = RTOSCF(59,F4_59, (Current));
				tb1 = F781_4924(RTCW(arg1), tr1);
				if (tb1) {
					Result = '\01';
					tr1 = RTOSCF(59,F4_59, (Current));
					tb1 = F781_4924(RTCW(arg2), tr1);
					if (!tb1) {
						tr1 = RTOSCF(60,F4_60, (Current));
						tb1 = F781_4924(RTCW(arg2), tr1);
						Result = tb1;
					}
				} else {
					tr1 = RTOSCF(57,F4_57, (Current));
					tb1 = F781_4924(RTCW(arg1), tr1);
					if (tb1) {
						tr1 = RTOSCF(57,F4_57, (Current));
						Result = F781_4924(RTCW(arg2), tr1);
					}
				}
			}
		}
	}
	RTLE;
	return Result;
}

/* {UNICODE_CONVERSION}.convert_to */
void F787_5158 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2, EIF_REFERENCE arg3)
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
	F785_5127(Current);
	tb1 = F781_4924(RTCW(arg1), arg3);
	if (tb1) {
		*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 1;
		tb1 = (FUNCTION_CAST(EIF_BOOLEAN, (EIF_REFERENCE)) R3459[Dtype(RTCW(arg2))-778])(arg2);
		if (tb1) {
			tr1 = F775_4654(RTCW(arg2));
			RTAR(Current, tr1);
			*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
		} else {
			tr1 = F775_4660(RTCW(arg2));
			RTAR(Current, tr1);
			*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
		}
	} else {
		tr1 = RTOSCF(58,F4_58, (Current));
		tb1 = F781_4924(RTCW(arg1), tr1);
		if (tb1) {
			tb1 = (FUNCTION_CAST(EIF_BOOLEAN, (EIF_REFERENCE)) R3461[Dtype(RTCW(arg2))-778])(arg2);
			if (tb1) {
				tr1 = F775_4654(RTCW(arg2));
			} else {
				tr2 = RTLNS(eif_new_type(10, 0x00).id, 10, _OBJSIZ_0_0_0_0_0_0_0_0_);
				tr1 = F11_253(RTCW(tr2), arg2);
			}
			tr1 = F787_5159(Current, tr1);
			RTAR(Current, tr1);
			*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
			*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 1;
		} else {
			tr1 = RTOSCF(60,F4_60, (Current));
			tb1 = F781_4924(RTCW(arg1), tr1);
			if (tb1) {
				tr1 = RTOSCF(58,F4_58, (Current));
				tb1 = F781_4924(RTCW(arg3), tr1);
				if (tb1) {
					tr1 = F775_4660(RTCW(arg2));
					tr1 = F787_5160(Current, tr1);
					RTAR(Current, tr1);
					*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
					*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 1;
				} else {
					tr1 = RTOSCF(59,F4_59, (Current));
					tb1 = F781_4924(RTCW(arg3), tr1);
					if (tb1) {
						tr1 = F775_4660(RTCW(arg2));
						tr1 = F787_5161(Current, tr1);
						RTAR(Current, tr1);
						*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
						*(EIF_BOOLEAN *)(Current+ _CHROFF_1_1_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 1;
						*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 1;
					}
				}
			} else {
				tr1 = RTOSCF(59,F4_59, (Current));
				tb1 = F781_4924(RTCW(arg1), tr1);
				if (tb1) {
					tr1 = RTOSCF(60,F4_60, (Current));
					tb1 = F781_4924(RTCW(arg3), tr1);
					if (tb1) {
						tr1 = F775_4660(RTCW(arg2));
						tr1 = F787_5162(Current, tr1);
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
EIF_REFERENCE F787_5159 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
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
EIF_REFERENCE F787_5160 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
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
EIF_REFERENCE F787_5161 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
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
	Result = RTLNS(eif_new_type(779, 0x01).id, 779, _OBJSIZ_1_1_0_3_0_0_0_0_);
	ti4_1 = *(EIF_INTEGER_32 *)(RTCW(arg1) + O3603[Dtype(arg1)-777]);
	F778_4731(RTCW(Result), (EIF_INTEGER_32) (ti4_1 * ((EIF_INTEGER_32) 2L)));
	loc2 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 1L);
	loc3 = *(EIF_INTEGER_32 *)(RTCW(arg1) + O3603[Dtype(arg1)-777]);
	for (;;) {
		if ((EIF_BOOLEAN) (loc2 > loc3)) break;
		tu4_1 = (FUNCTION_CAST(EIF_NATURAL_32, (EIF_REFERENCE, EIF_INTEGER_32)) R3447[Dtype(RTCW(arg1))-778])(arg1, loc2);
		loc1 = eif_bit_and(tu4_1,(EIF_NATURAL_32) ((EIF_INTEGER_32) 1048575L));
		if ((EIF_BOOLEAN) (loc1 > (EIF_NATURAL_32) ((EIF_INTEGER_32) 65535L))) {
			loc1 -= (EIF_NATURAL_32) ((EIF_INTEGER_32) 65536L);
			tu4_1 = eif_bit_shift_right(loc1,((EIF_INTEGER_32) 10L));
			tu4_1 = eif_bit_or(tu4_1,(EIF_NATURAL_32) ((EIF_INTEGER_32) 55296L));
			F777_4701(RTCW(Result), tu4_1);
			tu4_1 = eif_bit_and(loc1,(EIF_NATURAL_32) ((EIF_INTEGER_32) 1023L));
			tu4_1 = eif_bit_or(tu4_1,(EIF_NATURAL_32) ((EIF_INTEGER_32) 56320L));
			F777_4701(RTCW(Result), tu4_1);
		} else {
			F777_4701(RTCW(Result), loc1);
		}
		loc2++;
	}
	RTLE;
	return Result;
}

/* {UNICODE_CONVERSION}.utf16_to_utf32 */
EIF_REFERENCE F787_5162 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
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
	loc2 = *(EIF_INTEGER_32 *)(RTCW(arg1) + O3603[Dtype(arg1)-777]);
	Result = RTLNS(eif_new_type(779, 0x01).id, 779, _OBJSIZ_1_1_0_3_0_0_0_0_);
	F778_4731(RTCW(Result), loc2);
	loc1 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 1L);
	for (;;) {
		if ((EIF_BOOLEAN) (loc1 > loc2)) break;
		loc3 = (FUNCTION_CAST(EIF_NATURAL_32, (EIF_REFERENCE, EIF_INTEGER_32)) R3447[Dtype(RTCW(arg1))-778])(arg1, loc1);
		loc1++;
		loc4 = eif_bit_and(loc3,(EIF_NATURAL_32) ((EIF_INTEGER_32) 65535L));
		if ((EIF_BOOLEAN) (loc1 <= loc2)) {
			tu4_1 = (FUNCTION_CAST(EIF_NATURAL_32, (EIF_REFERENCE, EIF_INTEGER_32)) R3447[Dtype(RTCW(arg1))-778])(arg1, loc1);
			loc5 = eif_bit_and(tu4_1,(EIF_NATURAL_32) ((EIF_INTEGER_32) 65535L));
		}
		if ((EIF_BOOLEAN) ((EIF_BOOLEAN) ((EIF_BOOLEAN) ((EIF_BOOLEAN) ((EIF_BOOLEAN) (loc4 >= (EIF_NATURAL_32) ((EIF_INTEGER_32) 55296L)) && (EIF_BOOLEAN) (loc4 <= (EIF_NATURAL_32) ((EIF_INTEGER_32) 56319L))) && (EIF_BOOLEAN) (loc1 <= loc2)) && (EIF_BOOLEAN) (loc5 >= (EIF_NATURAL_32) ((EIF_INTEGER_32) 56320L))) && (EIF_BOOLEAN) (loc5 <= (EIF_NATURAL_32) ((EIF_INTEGER_32) 57343L)))) {
			tu4_1 = eif_bit_and(loc4,(EIF_NATURAL_32) ((EIF_INTEGER_32) 1023L));
			tu4_1 = eif_bit_shift_left(tu4_1,((EIF_INTEGER_32) 10L));
			tu4_2 = eif_bit_and(loc5,(EIF_NATURAL_32) ((EIF_INTEGER_32) 1023L));
			F777_4701(RTCW(Result), (EIF_NATURAL_32) ((EIF_NATURAL_32) (tu4_1 + tu4_2) + (EIF_NATURAL_32) ((EIF_INTEGER_32) 65536L)));
			loc1++;
		} else {
			F777_4701(RTCW(Result), loc4);
		}
	}
	RTLE;
	return Result;
}

/* {UNICODE_CONVERSION}.unicode_encodings */
static EIF_REFERENCE F787_5165_body (EIF_REFERENCE Current)
{
	GTCX
	RTEX;
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE tr2 = NULL;
	RTLD;
	

	RTLI(3);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLR(2,tr2);
	RTLIU(3);
	
	RTEV;
	RTGC;
	RTOSP (5165);
#define Result RTOSR(5165)
	RTOC_NEW(Result);
	{
		static EIF_TYPE_INDEX typarr0[] = {0xFF01,597,0xFF01,780,0xFFFF};
		EIF_TYPE typres0;
		static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
		
		typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
		tr1 = RTLNS(typres0.id, 597, _OBJSIZ_7_4_0_7_0_0_0_0_);
	}
	F594_2925(RTCW(tr1), ((EIF_INTEGER_32) 8L));
	Result = (EIF_REFERENCE) tr1;
	tr1 = RTOSCF(57,F4_57, (Current));
	tr2 = RTOSCF(57,F4_57, (Current));
	F594_2971(RTCW(Result), tr1, tr2);
	tr1 = RTOSCF(58,F4_58, (Current));
	tr2 = RTOSCF(58,F4_58, (Current));
	F594_2971(RTCW(Result), tr1, tr2);
	tr1 = RTOSCF(59,F4_59, (Current));
	tr2 = RTOSCF(59,F4_59, (Current));
	F594_2971(RTCW(Result), tr1, tr2);
	tr1 = RTOSCF(61,F4_61, (Current));
	tr2 = RTOSCF(61,F4_61, (Current));
	F594_2971(RTCW(Result), tr1, tr2);
	tr1 = RTOSCF(60,F4_60, (Current));
	tr2 = RTOSCF(60,F4_60, (Current));
	F594_2971(RTCW(Result), tr1, tr2);
	tr1 = RTOSCF(62,F4_62, (Current));
	tr2 = RTOSCF(62,F4_62, (Current));
	F594_2971(RTCW(Result), tr1, tr2);
	tr1 = RTOSCF(63,F4_63, (Current));
	tr2 = RTOSCF(63,F4_63, (Current));
	F594_2971(RTCW(Result), tr1, tr2);
	tr1 = RTOSCF(64,F4_64, (Current));
	tr2 = RTOSCF(64,F4_64, (Current));
	F594_2971(RTCW(Result), tr1, tr2);
	RTOSE (5165);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F787_5165 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(5165,F787_5165_body,(Current));
}

void EIF_Minit201 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
