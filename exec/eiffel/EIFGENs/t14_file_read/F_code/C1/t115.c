/*
 * Code for class T14_FILE_READ
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

/* {T14_FILE_READ}.ss_now_ms */
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
	ti4_1 = F55_792(RTCW(arg1));
	ti4_2 = F55_793(RTCW(arg1));
	ti4_3 = F55_794(RTCW(arg1));
	ti4_4 = F55_798(RTCW(arg1));
	Result = (EIF_INTEGER_64) (EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) (ti4_1 * ((EIF_INTEGER_32) 60L)) + ti4_2) * ((EIF_INTEGER_32) 60L)) + ti4_3) * ((EIF_INTEGER_32) 1000L)) + ti4_4);
	RTLE;
	return Result;
}

/* {T14_FILE_READ}.ss_start */
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

/* {T14_FILE_READ}.ss_report */
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
	tr1 = RTOSCF(433,F26_433, (RTCV(RTOSCF(24,F1_24, (Current)))));
	tr2 = RTMS_EX_H("TIME_MS=",8,2005121085);
	F784_5093(RTCW(tr1), tr2);
	tr1 = RTOSCF(433,F26_433, (RTCV(RTOSCF(24,F1_24, (Current)))));
	F491_2550(RTCW(tr1), loc2);
	tr1 = RTOSCF(433,F26_433, (RTCV(RTOSCF(24,F1_24, (Current)))));
	F784_5101(RTCW(tr1));
	RTLE;
}

/* {T14_FILE_READ}.make */
void F27_515 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE loc1 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc2 = (EIF_REFERENCE) 0;
	EIF_INTEGER_64 loc3 = (EIF_INTEGER_64) 0;
	EIF_INTEGER_32 loc4 = (EIF_INTEGER_32) 0;
	EIF_INTEGER_32 loc5 = (EIF_INTEGER_32) 0;
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_64 ti8_1;
	EIF_NATURAL_8 tu1_1;
	RTLD;
	
	RTLI(4);
	RTLR(0,Current);
	RTLR(1,loc2);
	RTLR(2,loc1);
	RTLR(3,tr1);
	RTLIU(4);
	
	RTGC;
	F27_513(Current);
	loc2 = RTLNS(eif_new_type(130, 0x01).id, 130, _OBJSIZ_0_1_0_1_0_1_1_0_);
	F131_1386(RTCW(loc2), ((EIF_INTEGER_32) 1048576L));
	loc1 = RTLNS(eif_new_type(489, 0x01).id, 489, _OBJSIZ_4_6_2_4_1_1_2_1_);
	tr1 = RTMS_EX_H("data.bin",8,459714670);
	F489_2264(RTCW(loc1), tr1);
	F490_2529(RTCW(loc1), loc2, ((EIF_INTEGER_32) 0L), ((EIF_INTEGER_32) 1048576L));
	loc4 = *(EIF_INTEGER_32 *)(RTCW(loc1)+ _LNGOFF_4_6_2_2_);
	for (;;) {
		if ((EIF_BOOLEAN) (loc4 <= ((EIF_INTEGER_32) 0L))) break;
		loc5 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 0L);
		for (;;) {
			if ((EIF_BOOLEAN) (loc5 >= loc4)) break;
			tu1_1 = F131_1397(RTCW(loc2), loc5);
			ti8_1 = (EIF_INTEGER_64) tu1_1;
			loc3 += ti8_1;
			loc5++;
		}
		F490_2529(RTCW(loc1), loc2, ((EIF_INTEGER_32) 0L), ((EIF_INTEGER_32) 1048576L));
		loc4 = *(EIF_INTEGER_32 *)(RTCW(loc1)+ _LNGOFF_4_6_2_2_);
	}
	F489_2349(RTCW(loc1));
	F27_514(Current);
	tr1 = RTOSCF(24,F1_24, (Current));
	F26_476(RTCW(tr1), (EIF_INTEGER_64) (loc3 % ((EIF_INTEGER_64) RTI64C(4294967296))));
	F26_484(RTCV(RTOSCF(24,F1_24, (Current))));
	RTLE;
}

void EIF_Minit15 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
