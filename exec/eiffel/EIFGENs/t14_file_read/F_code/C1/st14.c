/*
 * Code for class STD_FILES
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "st14.h"

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
static EIF_REFERENCE F26_432_body (EIF_REFERENCE Current)
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
	RTOSP (432);
#define Result RTOSR(432)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(783, 0x01).id, 783, _OBJSIZ_5_7_2_4_1_1_2_1_);
	tr2 = RTMS_EX_H("stdout",6,1912016244);
	F784_5065(RTCW(tr1), tr2);
	Result = (EIF_REFERENCE) tr1;
	RTOSE (432);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F26_432 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(432,F26_432_body,(Current));
}

/* {STD_FILES}.error */
static EIF_REFERENCE F26_433_body (EIF_REFERENCE Current)
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
	RTOSP (433);
#define Result RTOSR(433)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(783, 0x01).id, 783, _OBJSIZ_5_7_2_4_1_1_2_1_);
	tr2 = RTMS_EX_H("stderr",6,1911360114);
	F784_5066(RTCW(tr1), tr2);
	Result = (EIF_REFERENCE) tr1;
	RTOSE (433);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F26_433 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(433,F26_433_body,(Current));
}

/* {STD_FILES}.standard_default */
EIF_REFERENCE F26_435 (EIF_REFERENCE Current)
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
		Result = RTOSCF(432,F26_432, (Current));
		RTLE;
		return (EIF_REFERENCE) Result;
	}
	RTLE;
	return Result;
}

/* {STD_FILES}.set_output_default */
void F26_459 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTGC;
	tr1 = RTOSCF(432,F26_432, (Current));
	RTAR(Current, tr1);
	*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
	RTLE;
}

/* {STD_FILES}.put_integer_64 */
void F26_476 (EIF_REFERENCE Current, EIF_INTEGER_64 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTGC;
	tr1 = F26_435(Current);
	F491_2550(RTCW(tr1), arg1);
	RTLE;
}

/* {STD_FILES}.put_new_line */
void F26_484 (EIF_REFERENCE Current)
{
	GTCX
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	F784_5101(RTCV(F26_435(Current)));
	RTLE;
}

void EIF_Minit14 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
