/*
 * Code for class T09_FIB_RECURSIVE
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "t015.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {T09_FIB_RECURSIVE}.ss_now_ms */
EIF_INTEGER_64 F27_513 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
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
	ti4_1 = F55_794(RTCW(arg1));
	ti4_2 = F55_795(RTCW(arg1));
	ti4_3 = F55_796(RTCW(arg1));
	ti4_4 = F55_800(RTCW(arg1));
	Result = (EIF_INTEGER_64) (EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) (ti4_1 * ((EIF_INTEGER_32) 60L)) + ti4_2) * ((EIF_INTEGER_32) 60L)) + ti4_3) * ((EIF_INTEGER_32) 1000L)) + ti4_4);
	RTLE;
	return Result;
}

/* {T09_FIB_RECURSIVE}.ss_start */
void F27_514 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNSMART(eif_new_type(793, 1).id);
	F794_5298(RTCW(tr1));
	RTAR(Current, tr1);
	*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
	RTLE;
}

/* {T09_FIB_RECURSIVE}.ss_report */
void F27_515 (EIF_REFERENCE Current)
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
	loc1 = RTLNS(eif_new_type(793, 0x01).id, 793, _OBJSIZ_0_0_0_1_0_0_0_1_);
	F794_5298(RTCW(loc1));
	loc2 = F27_513(Current, loc1);
	ti8_1 = F27_513(Current, *(EIF_REFERENCE *)(Current));
	loc2 = (EIF_INTEGER_64) (EIF_INTEGER_64) (loc2 - ti8_1);
	if ((EIF_BOOLEAN) (loc2 < (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L))) {
		loc2 += (EIF_INTEGER_64) ((EIF_INTEGER_32) 86400000L);
	}
	tr1 = RTOSCF(426,F25_426, (RTCV(RTOSCF(24,F1_24, (Current)))));
	tr2 = RTMS_EX_H("TIME_MS=",8,2005121085);
	F784_5095(RTCW(tr1), tr2);
	tr1 = RTOSCF(426,F25_426, (RTCV(RTOSCF(24,F1_24, (Current)))));
	F491_2552(RTCW(tr1), loc2);
	tr1 = RTOSCF(426,F25_426, (RTCV(RTOSCF(24,F1_24, (Current)))));
	F784_5103(RTCW(tr1));
	RTLE;
}

/* {T09_FIB_RECURSIVE}.make */
void F27_516 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_64 ti8_1;
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTGC;
	F27_514(Current);
	ti8_1 = F27_517(Current, ((EIF_INTEGER_32) 40L));
	*(EIF_INTEGER_64 *)(Current+ _I64OFF_1_0_0_0_0_0_0_) = (EIF_INTEGER_64) ti8_1;
	F27_515(Current);
	tr1 = RTOSCF(24,F1_24, (Current));
	F25_469(RTCW(tr1), *(EIF_INTEGER_64 *)(Current+ _I64OFF_1_0_0_0_0_0_0_));
	F25_477(RTCV(RTOSCF(24,F1_24, (Current))));
	RTLE;
}

/* {T09_FIB_RECURSIVE}.fib */
EIF_INTEGER_64 F27_517 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_INTEGER_64 ti8_1;
	EIF_INTEGER_64 Result = ((EIF_INTEGER_64) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	if ((EIF_BOOLEAN) (arg1 < ((EIF_INTEGER_32) 2L))) {
		ti8_1 = (EIF_INTEGER_64) arg1;
		RTLE;
		return (EIF_INTEGER_64) ti8_1;
	} else {
		Result = F27_517(Current, (EIF_INTEGER_32) (arg1 - ((EIF_INTEGER_32) 1L)));
		ti8_1 = F27_517(Current, (EIF_INTEGER_32) (arg1 - ((EIF_INTEGER_32) 2L)));
		Result = (EIF_INTEGER_64) (EIF_INTEGER_64) (Result + ti8_1);
	}
	RTLE;
	return Result;
}

void EIF_Minit15 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
