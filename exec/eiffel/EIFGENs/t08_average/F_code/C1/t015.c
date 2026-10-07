/*
 * Code for class T08_AVERAGE
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

/* {T08_AVERAGE}.ss_now_ms */
EIF_INTEGER_64 F27_512 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
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
	ti4_1 = F56_818(RTCW(arg1));
	ti4_2 = F56_819(RTCW(arg1));
	ti4_3 = F56_820(RTCW(arg1));
	ti4_4 = F56_824(RTCW(arg1));
	Result = (EIF_INTEGER_64) (EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) (ti4_1 * ((EIF_INTEGER_32) 60L)) + ti4_2) * ((EIF_INTEGER_32) 60L)) + ti4_3) * ((EIF_INTEGER_32) 1000L)) + ti4_4);
	RTLE;
	return Result;
}

/* {T08_AVERAGE}.ss_start */
void F27_513 (EIF_REFERENCE Current)
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
	F794_5296(RTCW(tr1));
	RTAR(Current, tr1);
	*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
	RTLE;
}

/* {T08_AVERAGE}.ss_report */
void F27_514 (EIF_REFERENCE Current)
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
	F794_5296(RTCW(loc1));
	loc2 = F27_512(Current, loc1);
	ti8_1 = F27_512(Current, *(EIF_REFERENCE *)(Current));
	loc2 = (EIF_INTEGER_64) (EIF_INTEGER_64) (loc2 - ti8_1);
	if ((EIF_BOOLEAN) (loc2 < (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L))) {
		loc2 += (EIF_INTEGER_64) ((EIF_INTEGER_32) 86400000L);
	}
	tr1 = RTOSCF(426,F25_426, (RTCV(RTOSCF(24,F1_24, (Current)))));
	tr2 = RTMS_EX_H("TIME_MS=",8,2005121085);
	F784_5093(RTCW(tr1), tr2);
	tr1 = RTOSCF(426,F25_426, (RTCV(RTOSCF(24,F1_24, (Current)))));
	F491_2550(RTCW(tr1), loc2);
	tr1 = RTOSCF(426,F25_426, (RTCV(RTOSCF(24,F1_24, (Current)))));
	F784_5101(RTCW(tr1));
	RTLE;
}

/* {T08_AVERAGE}.make */
void F27_515 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REAL_64 loc1 = (EIF_REAL_64) 0;
	EIF_INTEGER_64 loc2 = (EIF_INTEGER_64) 0;
	EIF_REFERENCE tr1 = NULL;
	EIF_REAL_64 tr8_1;
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTGC;
	F27_513(Current);
	loc2 = (EIF_INTEGER_64) (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L);
	for (;;) {
		if ((EIF_BOOLEAN) (loc2 >= (EIF_INTEGER_64) ((EIF_INTEGER_32) 100000000L))) break;
		tr8_1 = (EIF_REAL_64) (((EIF_INTEGER_64) (loc2 % (EIF_INTEGER_64) ((EIF_INTEGER_32) 256L))));
		loc1 += (EIF_REAL_64) ((EIF_REAL_64) (tr8_1) /  (EIF_REAL_64) ((EIF_REAL_64) 256.0));
		loc2 += (EIF_INTEGER_64) ((EIF_INTEGER_32) 1L);
	}
	F27_514(Current);
	tr1 = RTOSCF(24,F1_24, (Current));
	F25_463(RTCW(tr1), (EIF_REAL_64) ((EIF_REAL_64) (loc1) /  (EIF_REAL_64) ((EIF_REAL_64) 100000000.0)));
	F25_477(RTCV(RTOSCF(24,F1_24, (Current))));
	RTLE;
}

void EIF_Minit15 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
