/*
 * Code for class MISMATCH_CORRECTOR
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "mi135.h"

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
void F613_2807 (EIF_REFERENCE Current)
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
	loc1 = RTLNS(eif_new_type(815, 0x01).id, 815, _OBJSIZ_1_1_0_3_0_0_0_0_);
	tr1 = RTMS_EX_H("Mismatch: ",10,1538098208);
	F816_4807(RTCW(loc1), tr1);
	loc2 = RTLNS(eif_new_type(75, 0x01).id, 75, _OBJSIZ_0_0_0_0_0_0_0_0_);
	tr1 = F702_3338(RTCV(F1_5(Current)));
	F816_4846(RTCW(loc1), tr1);
	F76_1072(RTCW(loc2), loc1);
	RTLE;
}

/* {MISMATCH_CORRECTOR}.mismatch_information */
static EIF_REFERENCE F613_2808_body (EIF_REFERENCE Current)
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
	RTOSP (2808);
#define Result RTOSR(2808)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(634, 0x01).id, 634, _OBJSIZ_9_3_0_7_0_0_0_0_);
	F635_3044(RTCW(tr1));
	Result = (EIF_REFERENCE) tr1;
	RTOSE (2808);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F613_2808 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(2808,F613_2808_body,(Current));
}

void EIF_Minit135 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
