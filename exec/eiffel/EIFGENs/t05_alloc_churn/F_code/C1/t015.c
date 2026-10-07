/*
 * Code for class T05_ALLOC_CHURN
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

/* {T05_ALLOC_CHURN}.ss_now_ms */
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

/* {T05_ALLOC_CHURN}.ss_start */
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

/* {T05_ALLOC_CHURN}.ss_report */
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

/* {T05_ALLOC_CHURN}.make */
void F27_515 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE loc1 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc2 = (EIF_REFERENCE) 0;
	EIF_INTEGER_64 loc3 = (EIF_INTEGER_64) 0;
	EIF_INTEGER_64 loc4 = (EIF_INTEGER_64) 0;
	EIF_INTEGER_32 loc5 = (EIF_INTEGER_32) 0;
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_64 ti8_1;
	EIF_NATURAL_8 tu1_1;
	EIF_NATURAL_8 tu1_2;
	RTCFDT;
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
		static EIF_TYPE_INDEX typarr0[] = {0xFF01,516,607,729,0xFFFF};
		EIF_TYPE typres0;
		static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
		
		typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(dftype, typarr0)));
		loc1 = RTLNS(typres0.id, 516, _OBJSIZ_1_1_0_2_0_0_0_0_);
	}
	F517_2653(RTCW(loc1), NULL, ((EIF_INTEGER_32) 1L), ((EIF_INTEGER_32) 256L));
	loc4 = (EIF_INTEGER_64) (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L);
	for (;;) {
		if ((EIF_BOOLEAN) (loc4 >= (EIF_INTEGER_64) ((EIF_INTEGER_32) 10000000L))) break;
		{
			static EIF_TYPE_INDEX typarr0[] = {0xFF01,607,729,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(dftype, typarr0)));
			loc2 = RTLNSP2(typres0.id,0,((EIF_INTEGER_32) 64L),sizeof(EIF_NATURAL_8), EIF_TRUE);
		}
		F608_3155(RTCW(loc2), (EIF_NATURAL_8) ((EIF_INTEGER_32) 0L), ((EIF_INTEGER_32) 64L));
		tu1_1 = (EIF_NATURAL_8) ((EIF_INTEGER_64) (loc4 % (EIF_INTEGER_64) ((EIF_INTEGER_32) 256L)));
		/* INLINED CODE (SPECIAL.put) */
		*((EIF_NATURAL_8 *)RTCW(loc2) + (((EIF_INTEGER_32) 0L))) = tu1_1;
		/* END INLINED CODE */
		;
		/* INLINED CODE (SPECIAL.item) */
		tu1_2 = *((EIF_NATURAL_8 *)RTCW(loc2) + (((EIF_INTEGER_32) 0L)));
		/* END INLINED CODE */
		tu1_1 = tu1_2;
		ti8_1 = (EIF_INTEGER_64) tu1_1;
		loc3 += ti8_1;
		loc5 = (EIF_INTEGER_32) ((EIF_INTEGER_64) (loc4 % (EIF_INTEGER_64) ((EIF_INTEGER_32) 256L)));
		F517_2677(RTCW(loc1), loc2, (EIF_INTEGER_32) (loc5 + ((EIF_INTEGER_32) 1L)));
		loc4 += (EIF_INTEGER_64) ((EIF_INTEGER_32) 1L);
	}
	F27_514(Current);
	tr1 = RTOSCF(24,F1_24, (Current));
	F25_469(RTCW(tr1), loc3);
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
