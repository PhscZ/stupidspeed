/*
 * Code for class SYSTEM_ENCODINGS
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "sy4.h"

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
static EIF_REFERENCE F4_59_body (EIF_REFERENCE Current)
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
	RTOSP (59);
#define Result RTOSR(59)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(2, 0x01).id, 2, _OBJSIZ_2_0_0_0_0_0_0_0_);
	tr2 = F36_581(RTCV(RTOSCF(64,F4_64, (Current))));
	F3_43(RTCW(tr1), tr2);
	Result = (EIF_REFERENCE) tr1;
	RTOSE (59);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F4_59 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(59,F4_59_body,(Current));
}

/* {SYSTEM_ENCODINGS}.utf8 */
static EIF_REFERENCE F4_60_body (EIF_REFERENCE Current)
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
	RTOSP (60);
#define Result RTOSR(60)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(2, 0x01).id, 2, _OBJSIZ_2_0_0_0_0_0_0_0_);
	tr2 = RTOSCF(36,F2_36, (Current));
	F3_43(RTCW(tr1), tr2);
	Result = (EIF_REFERENCE) tr1;
	RTOSE (60);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F4_60 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(60,F4_60_body,(Current));
}

/* {SYSTEM_ENCODINGS}.utf32 */
static EIF_REFERENCE F4_62_body (EIF_REFERENCE Current)
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
	RTOSP (62);
#define Result RTOSR(62)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(2, 0x01).id, 2, _OBJSIZ_2_0_0_0_0_0_0_0_);
	tr2 = RTOSCF(38,F2_38, (Current));
	F3_43(RTCW(tr1), tr2);
	Result = (EIF_REFERENCE) tr1;
	RTOSE (62);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F4_62 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(62,F4_62_body,(Current));
}

/* {SYSTEM_ENCODINGS}.system_encodings_i */
static EIF_REFERENCE F4_64_body (EIF_REFERENCE Current)
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
	RTOSP (64);
#define Result RTOSR(64)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(35, 0x01).id, 35, _OBJSIZ_0_0_0_0_0_0_0_0_);
	Result = (EIF_REFERENCE) tr1;
	RTOSE (64);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F4_64 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(64,F4_64_body,(Current));
}

void EIF_Minit4 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
