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
static EIF_REFERENCE F3_44_body (EIF_REFERENCE Current)
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
	RTOSP (44);
#define Result RTOSR(44)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(3, 0x01).id, 3, _OBJSIZ_2_0_0_0_0_0_0_0_);
	tr2 = F37_599(RTCV(RTOSCF(49,F3_49, (Current))));
	F4_50(RTCW(tr1), tr2);
	Result = (EIF_REFERENCE) tr1;
	RTOSE (44);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F3_44 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(44,F3_44_body,(Current));
}

/* {SYSTEM_ENCODINGS}.utf8 */
static EIF_REFERENCE F3_45_body (EIF_REFERENCE Current)
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
	RTOSP (45);
#define Result RTOSR(45)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(3, 0x01).id, 3, _OBJSIZ_2_0_0_0_0_0_0_0_);
	tr2 = RTOSCF(36,F2_36, (Current));
	F4_50(RTCW(tr1), tr2);
	Result = (EIF_REFERENCE) tr1;
	RTOSE (45);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F3_45 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(45,F3_45_body,(Current));
}

/* {SYSTEM_ENCODINGS}.utf32 */
static EIF_REFERENCE F3_47_body (EIF_REFERENCE Current)
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
	RTOSP (47);
#define Result RTOSR(47)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(3, 0x01).id, 3, _OBJSIZ_2_0_0_0_0_0_0_0_);
	tr2 = RTOSCF(38,F2_38, (Current));
	F4_50(RTCW(tr1), tr2);
	Result = (EIF_REFERENCE) tr1;
	RTOSE (47);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F3_47 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(47,F3_47_body,(Current));
}

/* {SYSTEM_ENCODINGS}.system_encodings_i */
static EIF_REFERENCE F3_49_body (EIF_REFERENCE Current)
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
	RTOSP (49);
#define Result RTOSR(49)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(36, 0x01).id, 36, _OBJSIZ_0_0_0_0_0_0_0_0_);
	Result = (EIF_REFERENCE) tr1;
	RTOSE (49);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F3_49 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(49,F3_49_body,(Current));
}

void EIF_Minit3 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
