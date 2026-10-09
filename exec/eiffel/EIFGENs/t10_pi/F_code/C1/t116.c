/*
 * Code for class T10_PI
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "t116.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {T10_PI}.ss_now_ms */
EIF_INTEGER_64 F29_530 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
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
	ti4_1 = F58_836(RTCW(arg1));
	ti4_2 = F58_837(RTCW(arg1));
	ti4_3 = F58_838(RTCW(arg1));
	ti4_4 = F58_842(RTCW(arg1));
	Result = (EIF_INTEGER_64) (EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) (ti4_1 * ((EIF_INTEGER_32) 60L)) + ti4_2) * ((EIF_INTEGER_32) 60L)) + ti4_3) * ((EIF_INTEGER_32) 1000L)) + ti4_4);
	RTLE;
	return Result;
}

/* {T10_PI}.ss_start */
void F29_531 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTGC;
	tr1 = RTLNSMART(eif_new_type(830, 1).id);
	F831_5314(RTCW(tr1));
	RTAR(Current, tr1);
	*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
	RTLE;
}

/* {T10_PI}.ss_report */
void F29_532 (EIF_REFERENCE Current)
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
	loc1 = RTLNS(eif_new_type(830, 0x01).id, 830, _OBJSIZ_0_0_0_1_0_0_0_1_);
	F831_5314(RTCW(loc1));
	loc2 = F29_530(Current, loc1);
	ti8_1 = F29_530(Current, *(EIF_REFERENCE *)(Current));
	loc2 = (EIF_INTEGER_64) (EIF_INTEGER_64) (loc2 - ti8_1);
	if ((EIF_BOOLEAN) (loc2 < (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L))) {
		loc2 += (EIF_INTEGER_64) ((EIF_INTEGER_32) 86400000L);
	}
	tr1 = RTOSCF(433,F27_433, (RTCV(RTOSCF(24,F1_24, (Current)))));
	tr2 = RTMS_EX_H("TIME_MS=",8,2005121085);
	F821_5111(RTCW(tr1), tr2);
	tr1 = RTOSCF(433,F27_433, (RTCV(RTOSCF(24,F1_24, (Current)))));
	F519_2568(RTCW(tr1), loc2);
	tr1 = RTOSCF(433,F27_433, (RTCV(RTOSCF(24,F1_24, (Current)))));
	F821_5119(RTCW(tr1));
	RTLE;
}

/* {T10_PI}.make */
void F29_533 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE loc1 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc2 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc3 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc4 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc5 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc6 = (EIF_REFERENCE) 0;
	EIF_INTEGER_64 loc7 = (EIF_INTEGER_64) 0;
	EIF_INTEGER_64 loc8 = (EIF_INTEGER_64) 0;
	EIF_INTEGER_64 loc9 = (EIF_INTEGER_64) 0;
	EIF_INTEGER_64 loc10 = (EIF_INTEGER_64) 0;
	EIF_INTEGER_64 loc11 = (EIF_INTEGER_64) 0;
	EIF_INTEGER_32 loc12 = (EIF_INTEGER_32) 0;
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_32 ti4_1;
	RTLD;
	
	RTLI(8);
	RTLR(0,Current);
	RTLR(1,loc1);
	RTLR(2,loc2);
	RTLR(3,loc3);
	RTLR(4,loc4);
	RTLR(5,loc5);
	RTLR(6,loc6);
	RTLR(7,tr1);
	RTLIU(8);
	
	RTGC;
	F29_531(Current);
	loc1 = RTLNS(eif_new_type(27, 0x01).id, 27, _OBJSIZ_1_1_0_2_0_0_0_0_);
	F28_511(RTCW(loc1));
	loc2 = RTLNS(eif_new_type(27, 0x01).id, 27, _OBJSIZ_1_1_0_2_0_0_0_0_);
	F28_511(RTCW(loc2));
	loc3 = RTLNS(eif_new_type(27, 0x01).id, 27, _OBJSIZ_1_1_0_2_0_0_0_0_);
	F28_511(RTCW(loc3));
	loc4 = RTLNS(eif_new_type(27, 0x01).id, 27, _OBJSIZ_1_1_0_2_0_0_0_0_);
	F28_511(RTCW(loc4));
	loc5 = RTLNS(eif_new_type(27, 0x01).id, 27, _OBJSIZ_1_1_0_2_0_0_0_0_);
	F28_511(RTCW(loc5));
	loc6 = RTLNS(eif_new_type(27, 0x01).id, 27, _OBJSIZ_1_1_0_2_0_0_0_0_);
	F28_511(RTCW(loc6));
	F28_514(RTCW(loc1), (EIF_INTEGER_64) ((EIF_INTEGER_32) 1L));
	F28_514(RTCW(loc2), (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L));
	F28_514(RTCW(loc3), (EIF_INTEGER_64) ((EIF_INTEGER_32) 1L));
	loc7 = (EIF_INTEGER_64) (EIF_INTEGER_64) ((EIF_INTEGER_32) 1L);
	loc8 = (EIF_INTEGER_64) (EIF_INTEGER_64) ((EIF_INTEGER_32) 3L);
	loc9 = (EIF_INTEGER_64) (EIF_INTEGER_64) ((EIF_INTEGER_32) 3L);
	loc12 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 0L);
	for (;;) {
		if ((EIF_BOOLEAN) (loc12 >= ((EIF_INTEGER_32) 1000L))) break;
		F28_518(RTCW(loc4), loc1, (EIF_INTEGER_64) ((EIF_INTEGER_32) 4L));
		F28_516(RTCW(loc4), loc4, loc2);
		F28_518(RTCW(loc5), loc3, (EIF_INTEGER_64) (loc9 + (EIF_INTEGER_64) ((EIF_INTEGER_32) 1L)));
		ti4_1 = F28_512(RTCW(loc4), loc5);
		if ((EIF_BOOLEAN) (ti4_1 < ((EIF_INTEGER_32) 0L))) {
			loc10 += loc9;
			loc12++;
			F28_518(RTCW(loc4), loc1, (EIF_INTEGER_64) ((EIF_INTEGER_32) 3L));
			F28_516(RTCW(loc4), loc4, loc2);
			F28_518(RTCW(loc4), loc4, (EIF_INTEGER_64) ((EIF_INTEGER_32) 10L));
			loc11 = F28_519(RTCW(loc4), loc3, loc6);
			loc11 = (EIF_INTEGER_64) (EIF_INTEGER_64) (loc11 - (EIF_INTEGER_64) ((EIF_INTEGER_64) ((EIF_INTEGER_32) 10L) * loc9));
			F28_518(RTCW(loc5), loc3, loc9);
			F28_517(RTCW(loc5), loc2, loc5);
			F28_518(RTCW(loc2), loc5, (EIF_INTEGER_64) ((EIF_INTEGER_32) 10L));
			F28_518(RTCW(loc1), loc1, (EIF_INTEGER_64) ((EIF_INTEGER_32) 10L));
			loc9 = (EIF_INTEGER_64) loc11;
		} else {
			F28_518(RTCW(loc4), loc1, (EIF_INTEGER_64) ((EIF_INTEGER_64) ((EIF_INTEGER_64) ((EIF_INTEGER_32) 7L) * loc7) + (EIF_INTEGER_64) ((EIF_INTEGER_32) 2L)));
			F28_518(RTCW(loc5), loc2, loc8);
			F28_516(RTCW(loc4), loc4, loc5);
			F28_518(RTCW(loc5), loc3, loc8);
			loc11 = F28_519(RTCW(loc4), loc5, loc6);
			F28_518(RTCW(loc4), loc1, (EIF_INTEGER_64) ((EIF_INTEGER_32) 2L));
			F28_516(RTCW(loc4), loc4, loc2);
			F28_518(RTCW(loc4), loc4, loc8);
			F28_515(RTCW(loc2), loc4);
			F28_518(RTCW(loc1), loc1, loc7);
			F28_518(RTCW(loc3), loc3, loc8);
			loc7 += (EIF_INTEGER_64) ((EIF_INTEGER_32) 1L);
			loc8 += (EIF_INTEGER_64) ((EIF_INTEGER_32) 2L);
			loc9 = (EIF_INTEGER_64) loc11;
		}
	}
	F29_532(Current);
	tr1 = RTOSCF(24,F1_24, (Current));
	F27_476(RTCW(tr1), loc10);
	F27_484(RTCV(RTOSCF(24,F1_24, (Current))));
	RTLE;
}

void EIF_Minit16 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
