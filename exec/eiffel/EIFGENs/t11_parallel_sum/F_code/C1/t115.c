/*
 * Code for class T11_PARALLEL_SUM
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

/* {T11_PARALLEL_SUM}.ss_now_ms */
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
	ti4_1 = F62_857(RTCW(arg1));
	ti4_2 = F62_858(RTCW(arg1));
	ti4_3 = F62_859(RTCW(arg1));
	ti4_4 = F62_863(RTCW(arg1));
	Result = (EIF_INTEGER_64) (EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) ((EIF_INTEGER_32) (ti4_1 * ((EIF_INTEGER_32) 60L)) + ti4_2) * ((EIF_INTEGER_32) 60L)) + ti4_3) * ((EIF_INTEGER_32) 1000L)) + ti4_4);
	RTLE;
	return Result;
}

/* {T11_PARALLEL_SUM}.ss_start */
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
	tr1 = RTLNSMART(eif_new_type(801, 1).id);
	F802_5372(RTCW(tr1));
	RTAR(Current, tr1);
	*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
	RTLE;
}

/* {T11_PARALLEL_SUM}.ss_report */
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
	loc1 = RTLNS(eif_new_type(801, 0x01).id, 801, _OBJSIZ_0_0_0_1_0_0_0_1_);
	F802_5372(RTCW(loc1));
	loc2 = F27_512(Current, loc1);
	ti8_1 = F27_512(Current, *(EIF_REFERENCE *)(Current));
	loc2 = (EIF_INTEGER_64) (EIF_INTEGER_64) (loc2 - ti8_1);
	if ((EIF_BOOLEAN) (loc2 < (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L))) {
		loc2 += (EIF_INTEGER_64) ((EIF_INTEGER_32) 86400000L);
	}
	tr1 = RTOUCR(0,F25_426, (RTCV(RTOUCR(1,F1_24, (Current)))));
	tr2 = RTMS_EX_H("TIME_MS=",8,2005121085);
	F792_5169(RTCW(tr1), tr2);
	tr1 = RTOUCR(0,F25_426, (RTCV(RTOUCR(1,F1_24, (Current)))));
	F498_2605(RTCW(tr1), loc2);
	tr1 = RTOUCR(0,F25_426, (RTCV(RTOUCR(1,F1_24, (Current)))));
	F792_5177(RTCW(tr1));
	RTLE;
}

/* {T11_PARALLEL_SUM}.make */
void F27_515 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE loc1 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc2 = (EIF_REFERENCE) 0;
	EIF_INTEGER_64 loc3 = (EIF_INTEGER_64) 0;
	EIF_INTEGER_32 loc4 = (EIF_INTEGER_32) 0;
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_64 ti8_1;
	RTLD;
	
	RTLI(4);
	RTLR(0,Current);
	RTLR(1,loc1);
	RTLR(2,loc2);
	RTLR(3,tr1);
	RTLIU(4);
	
	RTGC;
	F27_513(Current);
	{
		static EIF_TYPE_INDEX typarr0[] = {0xFF01,523,0xFF01,56,0xFFFF};
		EIF_TYPE typres0;
		static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
		
		typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
		loc1 = RTLNS(typres0.id, 523, _OBJSIZ_1_1_0_2_0_0_0_0_);
	}
	F524_2709(RTCW(loc1), ((EIF_INTEGER_32) 1L), ((EIF_INTEGER_32) 4L));
	loc4 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 0L);
	for (;;) {
		if ((EIF_BOOLEAN) (loc4 >= ((EIF_INTEGER_32) 4L))) break;
		loc2 = RTLNS(eif_new_type(56, 0x01).id, 56, _OBJSIZ_1_1_0_1_0_1_1_0_);
		F57_808(RTCW(loc2), loc4);
		F524_2732(RTCW(loc1), loc2, (EIF_INTEGER_32) (loc4 + ((EIF_INTEGER_32) 1L)));
		F56_789(RTCW(loc2));
		loc4++;
	}
	loc4 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 0L);
	for (;;) {
		if ((EIF_BOOLEAN) (loc4 >= ((EIF_INTEGER_32) 4L))) break;
		tr1 = F524_2713(RTCW(loc1), (EIF_INTEGER_32) (loc4 + ((EIF_INTEGER_32) 1L)));
		F56_797(RTCW(tr1));
		loc4++;
	}
	loc4 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 0L);
	for (;;) {
		if ((EIF_BOOLEAN) (loc4 >= ((EIF_INTEGER_32) 4L))) break;
		tr1 = F524_2713(RTCW(loc1), (EIF_INTEGER_32) (loc4 + ((EIF_INTEGER_32) 1L)));
		ti8_1 = *(EIF_INTEGER_64 *)(RTCW(tr1)+ _I64OFF_1_1_0_1_0_1_0_);
		loc3 += ti8_1;
		loc4++;
	}
	F27_514(Current);
	tr1 = RTOUCR(1,F1_24, (Current));
	F25_469(RTCW(tr1), loc3);
	F25_477(RTCV(RTOUCR(1,F1_24, (Current))));
	RTLE;
}

void EIF_Minit15 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
