/*
 * Code for class T03_FUNC_SUM
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "t016.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {T03_FUNC_SUM}.ss_now_ms */
EIF_INTEGER_64 F28_514 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
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
	ti4_1 = F57_820(RTCW(arg1));
	ti4_2 = F57_821(RTCW(arg1));
	ti4_3 = F57_822(RTCW(arg1));
	ti4_4 = F57_826(RTCW(arg1));
	Result = (EIF_INTEGER_64) (EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) (ti4_1 * ((EIF_INTEGER_32) 60L)) + ti4_2) * ((EIF_INTEGER_32) 60L)) + ti4_3) * ((EIF_INTEGER_32) 1000L)) + ti4_4);
	RTLE;
	return Result;
}

/* {T03_FUNC_SUM}.ss_start */
void F28_515 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNSMART(eif_new_type(794, 1).id);
	F795_5298(RTCW(tr1));
	RTAR(Current, tr1);
	*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
	RTLE;
}

/* {T03_FUNC_SUM}.ss_report */
void F28_516 (EIF_REFERENCE Current)
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
	loc1 = RTLNS(eif_new_type(794, 0x01).id, 794, _OBJSIZ_0_0_0_1_0_0_0_1_);
	F795_5298(RTCW(loc1));
	loc2 = F28_514(Current, loc1);
	ti8_1 = F28_514(Current, *(EIF_REFERENCE *)(Current));
	loc2 = (EIF_INTEGER_64) (EIF_INTEGER_64) (loc2 - ti8_1);
	if ((EIF_BOOLEAN) (loc2 < (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L))) {
		loc2 += (EIF_INTEGER_64) ((EIF_INTEGER_32) 86400000L);
	}
	tr1 = RTOSCF(433,F26_433, (RTCV(RTOSCF(24,F1_24, (Current)))));
	tr2 = RTMS_EX_H("TIME_MS=",8,2005121085);
	F785_5095(RTCW(tr1), tr2);
	tr1 = RTOSCF(433,F26_433, (RTCV(RTOSCF(24,F1_24, (Current)))));
	F492_2552(RTCW(tr1), loc2);
	tr1 = RTOSCF(433,F26_433, (RTCV(RTOSCF(24,F1_24, (Current)))));
	F785_5103(RTCW(tr1));
	RTLE;
}

/* {T03_FUNC_SUM}.make */
void F28_517 (EIF_REFERENCE Current)
{
	GTCX
	EIF_INTEGER_64 loc1 = (EIF_INTEGER_64) 0;
	EIF_INTEGER_64 loc2 = (EIF_INTEGER_64) 0;
	EIF_REFERENCE loc3 = (EIF_REFERENCE) 0;
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_64 ti8_1;
	RTLD;
	
	RTLI(3);
	RTLR(0,Current);
	RTLR(1,loc3);
	RTLR(2,tr1);
	RTLIU(3);
	
	RTGC;
	F28_515(Current);
	loc3 = RTLNS(eif_new_type(26, 0x01).id, 26, _OBJSIZ_0_0_0_0_0_0_0_0_);
	loc2 = (EIF_INTEGER_64) (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L);
	for (;;) {
		if ((EIF_BOOLEAN) (loc2 >= (EIF_INTEGER_64) ((EIF_INTEGER_32) 100000000L))) break;
		ti8_1 = F27_512(RTCW(loc3), loc1);
		loc1 = (EIF_INTEGER_64) ti8_1;
		loc2 += (EIF_INTEGER_64) ((EIF_INTEGER_32) 1L);
	}
	F28_516(Current);
	tr1 = RTOSCF(24,F1_24, (Current));
	F26_476(RTCW(tr1), loc1);
	F26_484(RTCV(RTOSCF(24,F1_24, (Current))));
	RTLE;
}

void EIF_Minit16 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
