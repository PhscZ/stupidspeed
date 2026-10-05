/*
 * Code for class PLAIN_TEXT_FILE
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "pl134.h"
#include "eif_out.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {PLAIN_TEXT_FILE}.make_with_name */
void F519_2561 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
	RTLI(3);
	RTLR(0,arg1);
	RTLR(1,Current);
	RTLR(2,tr1);
	RTLIU(3);
	
	RTGC;
	F517_2280(Current, arg1);
	tr1 = RTLNSMART(eif_new_type(819, 1).id);
	F812_4619(RTCW(tr1));
	RTAR(Current, tr1);
	*(EIF_REFERENCE *)(Current + _REFACS_3_) = (EIF_REFERENCE) tr1;
	RTLE;
}

/* {PLAIN_TEXT_FILE}.put_integer_64 */
void F519_2568 (EIF_REFERENCE Current, EIF_INTEGER_64 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	tr1 = eif_out__i8_s1(arg1);
	F519_2585(Current, tr1);
	RTLE;
}

/* {PLAIN_TEXT_FILE}.put_string_general */
void F519_2585 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE loc1 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc2 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc3 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc4 = (EIF_REFERENCE) 0;
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE tr2 = NULL;
	EIF_BOOLEAN tb1;
	RTLD;
	
	RTLI(8);
	RTLR(0,loc4);
	RTLR(1,Current);
	RTLR(2,loc2);
	RTLR(3,tr1);
	RTLR(4,arg1);
	RTLR(5,loc1);
	RTLR(6,loc3);
	RTLR(7,tr2);
	RTLIU(8);
	
	RTGC;
	loc4 = F519_2606(Current);
	tr1 = RTLNS(eif_new_type(2, 0x01).id, 2, _OBJSIZ_0_0_0_0_0_0_0_0_);
	loc2 = RTOSCF(47,F3_47, (RTCW(tr1)));
	F4_56(RTCW(loc2), loc4, arg1);
	tb1 = F4_57(RTCW(loc2));
	if (tb1) {
		loc1 = F4_53(RTCW(loc2));
	} else {
		tr1 = RTLNS(eif_new_type(2, 0x01).id, 2, _OBJSIZ_0_0_0_0_0_0_0_0_);
		loc3 = RTOSCF(45,F3_45, (RTCW(tr1)));
		F4_56(RTCW(loc2), loc3, arg1);
		tb1 = F4_57(RTCW(loc2));
		if (tb1) {
			loc1 = F4_53(RTCW(loc2));
			tb1 = F4_59(RTCW(loc3), loc4);
			if ((EIF_BOOLEAN) !tb1) {
				F4_56(RTCW(loc3), loc4, loc1);
				tb1 = F4_57(RTCW(loc3));
				if (tb1) {
					loc1 = F4_53(RTCW(loc3));
				}
			}
		} else {
			tb1 = (FUNCTION_CAST(EIF_BOOLEAN, (EIF_REFERENCE)) R3479[Dtype(RTCW(arg1))-815])(arg1);
			if (tb1) {
				loc1 = F812_4672(RTCW(arg1));
			} else {
				tr2 = F812_4678(RTCW(arg1));
				tr1 = RTLNS(eif_new_type(10, 0x00).id, 10, _OBJSIZ_0_0_0_0_0_0_0_0_);
				loc1 = F11_251(RTCW(tr1), tr2);
			}
		}
	}
	F821_5111(Current, loc1);
	RTLE;
}

/* {PLAIN_TEXT_FILE}.encoding */
EIF_REFERENCE F519_2606 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE loc1 = (EIF_REFERENCE) 0;
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(4);
	RTLR(0,loc1);
	RTLR(1,Current);
	RTLR(2,tr1);
	RTLR(3,Result);
	RTLIU(4);
	
	RTGC;
	tr1 = *(EIF_REFERENCE *)(Current + _REFACS_4_);
	loc1 = tr1;
	if (EIF_TEST(loc1)) {
		RTLE;
		return (EIF_REFERENCE) loc1;
	} else {
		Result = RTOSCF(5085,F821_5085, (Current));
		RTAR(Current, Result);
		*(EIF_REFERENCE *)(Current + _REFACS_4_) = (EIF_REFERENCE) Result;
	}
	RTLE;
	return Result;
}

void EIF_Minit134 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
