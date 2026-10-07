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
void F579_2807 (EIF_REFERENCE Current)
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
	loc1 = RTLNS(eif_new_type(782, 0x01).id, 782, _OBJSIZ_1_1_0_3_0_0_0_0_);
	tr1 = RTMS_EX_H("Mismatch: ",10,1538098208);
	F783_4973(RTCW(loc1), tr1);
	loc2 = RTLNS(eif_new_type(74, 0x01).id, 74, _OBJSIZ_0_0_0_0_0_0_0_0_);
	tr1 = F666_3338(RTCV(F1_5(Current)));
	F783_5012(RTCW(loc1), tr1);
	F75_1072(RTCW(loc2), loc1);
	RTLE;
}

/* {MISMATCH_CORRECTOR}.mismatch_information */
static EIF_REFERENCE F579_2808_body (EIF_REFERENCE Current)
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
	tr1 = RTLNS(eif_new_type(599, 0x01).id, 599, _OBJSIZ_9_3_0_7_0_0_0_0_);
	F600_3044(RTCW(tr1));
	Result = (EIF_REFERENCE) tr1;
	RTOSE (2808);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F579_2808 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(2808,F579_2808_body,(Current));
}

void EIF_Minit135 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
