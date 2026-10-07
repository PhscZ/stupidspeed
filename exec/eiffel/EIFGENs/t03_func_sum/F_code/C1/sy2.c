/*
 * Code for class SYSTEM_ENCODINGS
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "sy2.h"

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
static EIF_REFERENCE F2_36_body (EIF_REFERENCE Current)
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
	RTOSP (36);
#define Result RTOSR(36)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(2, 0x01).id, 2, _OBJSIZ_2_0_0_0_0_0_0_0_);
	tr2 = F36_583(RTCV(RTOSCF(41,F2_41, (Current))));
	F3_42(RTCW(tr1), tr2);
	Result = (EIF_REFERENCE) tr1;
	RTOSE (36);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F2_36 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(36,F2_36_body,(Current));
}

/* {SYSTEM_ENCODINGS}.utf8 */
static EIF_REFERENCE F2_37_body (EIF_REFERENCE Current)
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
	RTOSP (37);
#define Result RTOSR(37)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(2, 0x01).id, 2, _OBJSIZ_2_0_0_0_0_0_0_0_);
	tr2 = RTOSCF(58,F4_58, (Current));
	F3_42(RTCW(tr1), tr2);
	Result = (EIF_REFERENCE) tr1;
	RTOSE (37);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F2_37 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(37,F2_37_body,(Current));
}

/* {SYSTEM_ENCODINGS}.utf32 */
static EIF_REFERENCE F2_39_body (EIF_REFERENCE Current)
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
	RTOSP (39);
#define Result RTOSR(39)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(2, 0x01).id, 2, _OBJSIZ_2_0_0_0_0_0_0_0_);
	tr2 = RTOSCF(60,F4_60, (Current));
	F3_42(RTCW(tr1), tr2);
	Result = (EIF_REFERENCE) tr1;
	RTOSE (39);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F2_39 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(39,F2_39_body,(Current));
}

/* {SYSTEM_ENCODINGS}.system_encodings_i */
static EIF_REFERENCE F2_41_body (EIF_REFERENCE Current)
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
	RTOSP (41);
#define Result RTOSR(41)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(35, 0x01).id, 35, _OBJSIZ_0_0_0_0_0_0_0_0_);
	Result = (EIF_REFERENCE) tr1;
	RTOSE (41);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F2_41 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(41,F2_41_body,(Current));
}

void EIF_Minit2 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
