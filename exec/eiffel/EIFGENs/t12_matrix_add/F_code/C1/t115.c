/*
 * Code for class T12_MATRIX_ADD
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "t115.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {T12_MATRIX_ADD}.ss_now_ms */
EIF_INTEGER_64 F28_512 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_INTEGER_32 ti4_1;
	EIF_INTEGER_32 ti4_2;
	EIF_INTEGER_32 ti4_3;
	EIF_INTEGER_32 ti4_4;
	EIF_INTEGER_64 Result = ((EIF_INTEGER_64) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,arg1);
	RTLIU(1);
	
	RTGC;
	ti4_1 = F57_818(RTCW(arg1));
	ti4_2 = F57_819(RTCW(arg1));
	ti4_3 = F57_820(RTCW(arg1));
	ti4_4 = F57_824(RTCW(arg1));
	Result = (EIF_INTEGER_64) (EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) (ti4_1 * ((EIF_INTEGER_32) 60L)) + ti4_2) * ((EIF_INTEGER_32) 60L)) + ti4_3) * ((EIF_INTEGER_32) 1000L)) + ti4_4);
	RTLE;
	return Result;
}

/* {T12_MATRIX_ADD}.ss_start */
void F28_513 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNSMART(eif_new_type(829, 1).id);
	F830_5296(RTCW(tr1));
	RTAR(Current, tr1);
	*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
	RTLE;
}

/* {T12_MATRIX_ADD}.ss_report */
void F28_514 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE loc1 = (EIF_REFERENCE) 0;
	EIF_INTEGER_64 loc2 = (EIF_INTEGER_64) 0;
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE tr2 = NULL;
	EIF_INTEGER_64 ti8_1;
	RTLD;
	
	RTLI(4);
	RTLR(0,loc1);
	RTLR(1,Current);
	RTLR(2,tr1);
	RTLR(3,tr2);
	RTLIU(4);
	
	RTGC;
	loc1 = RTLNS(eif_new_type(829, 0x01).id, 829, _OBJSIZ_0_0_0_1_0_0_0_1_);
	F830_5296(RTCW(loc1));
	loc2 = F28_512(Current, loc1);
	ti8_1 = F28_512(Current, *(EIF_REFERENCE *)(Current));
	loc2 = (EIF_INTEGER_64) (EIF_INTEGER_64) (loc2 - ti8_1);
	if ((EIF_BOOLEAN) (loc2 < (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L))) {
		loc2 += (EIF_INTEGER_64) ((EIF_INTEGER_32) 86400000L);
	}
	tr1 = RTOSCF(426,F26_426, (RTCV(RTOSCF(24,F1_24, (Current)))));
	tr2 = RTMS_EX_H("TIME_MS=",8,2005121085);
	F820_5093(RTCW(tr1), tr2);
	tr1 = RTOSCF(426,F26_426, (RTCV(RTOSCF(24,F1_24, (Current)))));
	F518_2550(RTCW(tr1), loc2);
	tr1 = RTOSCF(426,F26_426, (RTCV(RTOSCF(24,F1_24, (Current)))));
	F820_5101(RTCW(tr1));
	RTLE;
}

/* {T12_MATRIX_ADD}.make */
void F28_515 (EIF_REFERENCE Current)
{
	GTCX
	EIF_INTEGER_32 loc1 = (EIF_INTEGER_32) 0;
	EIF_REFERENCE loc2 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc3 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc4 = (EIF_REFERENCE) 0;
	EIF_INTEGER_64 loc5 = (EIF_INTEGER_64) 0;
	EIF_INTEGER_32 loc6 = (EIF_INTEGER_32) 0;
	EIF_INTEGER_32 loc7 = (EIF_INTEGER_32) 0;
	EIF_INTEGER_32 loc8 = (EIF_INTEGER_32) 0;
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_64 ti8_1;
	EIF_INTEGER_64 ti8_2;
	EIF_INTEGER_64 ti8_3;
	EIF_INTEGER_32 ti4_1;
	RTCFDT;
	RTLD;
	
	RTLI(5);
	RTLR(0,Current);
	RTLR(1,loc2);
	RTLR(2,loc3);
	RTLR(3,loc4);
	RTLR(4,tr1);
	RTLIU(5);
	
	RTGC;
	F28_513(Current);
	loc1 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 1000L);
	{
		static EIF_TYPE_INDEX typarr0[] = {0xFF01,651,750,0xFFFF};
		EIF_TYPE typres0;
		static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
		
		typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(dftype, typarr0)));
		loc2 = RTLNSP2(typres0.id,0,(EIF_INTEGER_32) (loc1 * loc1),sizeof(EIF_INTEGER_64), EIF_TRUE);
	}
	F652_3155(RTCW(loc2), (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L), (EIF_INTEGER_32) (loc1 * loc1));
	{
		static EIF_TYPE_INDEX typarr0[] = {0xFF01,651,750,0xFFFF};
		EIF_TYPE typres0;
		static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
		
		typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(dftype, typarr0)));
		loc3 = RTLNSP2(typres0.id,0,(EIF_INTEGER_32) (loc1 * loc1),sizeof(EIF_INTEGER_64), EIF_TRUE);
	}
	F652_3155(RTCW(loc3), (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L), (EIF_INTEGER_32) (loc1 * loc1));
	{
		static EIF_TYPE_INDEX typarr0[] = {0xFF01,651,750,0xFFFF};
		EIF_TYPE typres0;
		static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
		
		typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(dftype, typarr0)));
		loc4 = RTLNSP2(typres0.id,0,(EIF_INTEGER_32) (loc1 * loc1),sizeof(EIF_INTEGER_64), EIF_TRUE);
	}
	F652_3155(RTCW(loc4), (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L), (EIF_INTEGER_32) (loc1 * loc1));
	loc6 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 0L);
	for (;;) {
		if ((EIF_BOOLEAN) (loc6 >= loc1)) break;
		loc7 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 0L);
		for (;;) {
			if ((EIF_BOOLEAN) (loc7 >= loc1)) break;
			ti8_1 = (EIF_INTEGER_64) (EIF_INTEGER_32) (loc6 + loc7);
			/* INLINED CODE (SPECIAL.put) */
			*((EIF_INTEGER_64 *)RTCW(loc2) + ((EIF_INTEGER_32) ((EIF_INTEGER_32) (loc6 * loc1) + loc7))) = ti8_1;
			/* END INLINED CODE */
			;
			ti8_1 = (EIF_INTEGER_64) (EIF_INTEGER_32) (loc6 - loc7);
			/* INLINED CODE (SPECIAL.put) */
			*((EIF_INTEGER_64 *)RTCW(loc3) + ((EIF_INTEGER_32) ((EIF_INTEGER_32) (loc6 * loc1) + loc7))) = ti8_1;
			/* END INLINED CODE */
			;
			loc7++;
		}
		loc6++;
	}
	loc6 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 0L);
	for (;;) {
		if ((EIF_BOOLEAN) (loc6 >= loc1)) break;
		loc7 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 0L);
		for (;;) {
			if ((EIF_BOOLEAN) (loc7 >= loc1)) break;
			/* INLINED CODE (SPECIAL.item) */
			ti8_2 = *((EIF_INTEGER_64 *)RTCW(loc2) + ((EIF_INTEGER_32) ((EIF_INTEGER_32) (loc6 * loc1) + loc7)));
			/* END INLINED CODE */
			ti8_1 = ti8_2;
			/* INLINED CODE (SPECIAL.item) */
			ti8_3 = *((EIF_INTEGER_64 *)RTCW(loc3) + ((EIF_INTEGER_32) ((EIF_INTEGER_32) (loc6 * loc1) + loc7)));
			/* END INLINED CODE */
			ti8_2 = ti8_3;
			/* INLINED CODE (SPECIAL.put) */
			*((EIF_INTEGER_64 *)RTCW(loc4) + ((EIF_INTEGER_32) ((EIF_INTEGER_32) (loc6 * loc1) + loc7))) = (EIF_INTEGER_64) (ti8_1 + ti8_2);
			/* END INLINED CODE */
			;
			loc7++;
		}
		loc6++;
	}
	loc8 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 0L);
	for (;;) {
		if ((EIF_BOOLEAN) (loc8 >= (EIF_INTEGER_32) (loc1 * loc1))) break;
		/* INLINED CODE (SPECIAL.item) */
		ti8_2 = *((EIF_INTEGER_64 *)RTCW(loc4) + (loc8));
		/* END INLINED CODE */
		ti8_1 = ti8_2;
		loc5 += ti8_1;
		loc8++;
	}
	F28_514(Current);
	tr1 = RTOSCF(24,F1_24, (Current));
	F26_469(RTCW(tr1), loc5);
	F26_477(RTCV(RTOSCF(24,F1_24, (Current))));
	RTLE;
}

void EIF_Minit15 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
