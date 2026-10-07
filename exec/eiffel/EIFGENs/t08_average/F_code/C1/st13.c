/*
 * Code for class STD_FILES
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "st13.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {STD_FILES}.output */
static EIF_REFERENCE F25_425_body (EIF_REFERENCE Current)
{
	GTCX
	RTEX;
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE tr2 = NULL;
	RTLD;
	

	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,tr2);
	RTLIU(2);
	
	RTEV;
	RTGC;
	RTOSP (425);
#define Result RTOSR(425)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(783, 0x01).id, 783, _OBJSIZ_5_7_2_4_1_1_2_1_);
	tr2 = RTMS_EX_H("stdout",6,1912016244);
	F784_5065(RTCW(tr1), tr2);
	Result = (EIF_REFERENCE) tr1;
	RTOSE (425);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F25_425 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(425,F25_425_body,(Current));
}

/* {STD_FILES}.error */
static EIF_REFERENCE F25_426_body (EIF_REFERENCE Current)
{
	GTCX
	RTEX;
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE tr2 = NULL;
	RTLD;
	

	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,tr2);
	RTLIU(2);
	
	RTEV;
	RTGC;
	RTOSP (426);
#define Result RTOSR(426)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(783, 0x01).id, 783, _OBJSIZ_5_7_2_4_1_1_2_1_);
	tr2 = RTMS_EX_H("stderr",6,1911360114);
	F784_5066(RTCW(tr1), tr2);
	Result = (EIF_REFERENCE) tr1;
	RTOSE (426);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F25_426 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(426,F25_426_body,(Current));
}

/* {STD_FILES}.standard_default */
EIF_REFERENCE F25_428 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,Result);
	RTLIU(2);
	
	RTGC;
	Result = *(EIF_REFERENCE *)(Current);
	if ((EIF_BOOLEAN)(Result == NULL)) {
		Result = RTOSCF(425,F25_425, (Current));
		RTLE;
		return (EIF_REFERENCE) Result;
	}
	RTLE;
	return Result;
}

/* {STD_FILES}.set_output_default */
void F25_452 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTGC;
	tr1 = RTOSCF(425,F25_425, (Current));
	RTAR(Current, tr1);
	*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
	RTLE;
}

/* {STD_FILES}.put_real_64 */
void F25_463 (EIF_REFERENCE Current, EIF_REAL_64 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTGC;
	tr1 = F25_428(Current);
	F784_5097(RTCW(tr1), arg1);
	RTLE;
}

/* {STD_FILES}.put_new_line */
void F25_477 (EIF_REFERENCE Current)
{
	GTCX
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	F784_5101(RTCV(F25_428(Current)));
	RTLE;
}

void EIF_Minit13 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
