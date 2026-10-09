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
void F614_2825 (EIF_REFERENCE Current)
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
	loc1 = RTLNS(eif_new_type(819, 0x01).id, 819, _OBJSIZ_1_1_0_3_0_0_0_0_);
	tr1 = RTMS_EX_H("Mismatch: ",10,1538098208);
	F820_4991(RTCW(loc1), tr1);
	loc2 = RTLNS(eif_new_type(76, 0x01).id, 76, _OBJSIZ_0_0_0_0_0_0_0_0_);
	tr1 = F703_3356(RTCV(F1_5(Current)));
	F820_5030(RTCW(loc1), tr1);
	F77_1090(RTCW(loc2), loc1);
	RTLE;
}

/* {MISMATCH_CORRECTOR}.mismatch_information */
static EIF_REFERENCE F614_2826_body (EIF_REFERENCE Current)
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
	RTOSP (2826);
#define Result RTOSR(2826)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(635, 0x01).id, 635, _OBJSIZ_9_3_0_7_0_0_0_0_);
	F636_3062(RTCW(tr1));
	Result = (EIF_REFERENCE) tr1;
	RTOSE (2826);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F614_2826 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(2826,F614_2826_body,(Current));
}

void EIF_Minit136 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
