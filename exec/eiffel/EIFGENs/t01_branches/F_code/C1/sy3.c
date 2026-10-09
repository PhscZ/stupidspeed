/*
 * Code for class SYSTEM_ENCODINGS
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "sy3.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {SYSTEM_ENCODINGS}.console_encoding */
static EIF_REFERENCE F3_51_body (EIF_REFERENCE Current)
{
	GTCX
	RTEX;
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE tr2 = NULL;
	RTLD;
	

	RTLI(3);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLR(2,tr2);
	RTLIU(3);
	
	RTEV;
	RTGC;
	RTOSP (51);
#define Result RTOSR(51)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(1, 0x01).id, 1, _OBJSIZ_2_0_0_0_0_0_0_0_);
	tr2 = F35_581(RTCV(RTOSCF(56,F3_56, (Current))));
	F2_35(RTCW(tr1), tr2);
	Result = (EIF_REFERENCE) tr1;
	RTOSE (51);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F3_51 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(51,F3_51_body,(Current));
}

/* {SYSTEM_ENCODINGS}.utf8 */
static EIF_REFERENCE F3_52_body (EIF_REFERENCE Current)
{
	GTCX
	RTEX;
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE tr2 = NULL;
	RTLD;
	

	RTLI(3);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLR(2,tr2);
	RTLIU(3);
	
	RTEV;
	RTGC;
	RTOSP (52);
#define Result RTOSR(52)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(1, 0x01).id, 1, _OBJSIZ_2_0_0_0_0_0_0_0_);
	tr2 = RTOSCF(58,F4_58, (Current));
	F2_35(RTCW(tr1), tr2);
	Result = (EIF_REFERENCE) tr1;
	RTOSE (52);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F3_52 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(52,F3_52_body,(Current));
}

/* {SYSTEM_ENCODINGS}.utf32 */
static EIF_REFERENCE F3_54_body (EIF_REFERENCE Current)
{
	GTCX
	RTEX;
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE tr2 = NULL;
	RTLD;
	

	RTLI(3);
	RTLR(0,tr1);
	RTLR(1,Current);
	RTLR(2,tr2);
	RTLIU(3);
	
	RTEV;
	RTGC;
	RTOSP (54);
#define Result RTOSR(54)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(1, 0x01).id, 1, _OBJSIZ_2_0_0_0_0_0_0_0_);
	tr2 = RTOSCF(60,F4_60, (Current));
	F2_35(RTCW(tr1), tr2);
	Result = (EIF_REFERENCE) tr1;
	RTOSE (54);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F3_54 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(54,F3_54_body,(Current));
}

/* {SYSTEM_ENCODINGS}.system_encodings_i */
static EIF_REFERENCE F3_56_body (EIF_REFERENCE Current)
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
	RTOSP (56);
#define Result RTOSR(56)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(34, 0x01).id, 34, _OBJSIZ_0_0_0_0_0_0_0_0_);
	Result = (EIF_REFERENCE) tr1;
	RTOSE (56);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F3_56 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(56,F3_56_body,(Current));
}

void EIF_Minit3 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
