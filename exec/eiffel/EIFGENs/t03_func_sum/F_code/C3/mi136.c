/*
 * Code for class MISMATCH_CORRECTOR
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "mi136.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {MISMATCH_CORRECTOR}.correct_mismatch */
void F580_2809 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE loc1 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc2 = (EIF_REFERENCE) 0;
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
	RTLI(4);
	RTLR(0,loc1);
	RTLR(1,tr1);
	RTLR(2,loc2);
	RTLR(3,Current);
	RTLIU(4);
	
	RTGC;
	loc1 = RTLNS(eif_new_type(780, 0x01).id, 780, _OBJSIZ_1_1_0_3_0_0_0_0_);
	tr1 = RTMS_EX_H("Mismatch: ",10,1538098208);
	F781_4809(RTCW(loc1), tr1);
	loc2 = RTLNS(eif_new_type(75, 0x01).id, 75, _OBJSIZ_0_0_0_0_0_0_0_0_);
	tr1 = F667_3340(RTCV(F1_5(Current)));
	F781_4848(RTCW(loc1), tr1);
	F76_1074(RTCW(loc2), loc1);
	RTLE;
}

/* {MISMATCH_CORRECTOR}.mismatch_information */
static EIF_REFERENCE F580_2810_body (EIF_REFERENCE Current)
{
	GTCX
	RTEX;
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	

	RTLI(1);
	RTLR(0,tr1);
	RTLIU(1);
	
	RTEV;
	RTGC;
	RTOSP (2810);
#define Result RTOSR(2810)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(600, 0x01).id, 600, _OBJSIZ_9_3_0_7_0_0_0_0_);
	F601_3046(RTCW(tr1));
	Result = (EIF_REFERENCE) tr1;
	RTOSE (2810);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F580_2810 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(2810,F580_2810_body,(Current));
}

void EIF_Minit136 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
