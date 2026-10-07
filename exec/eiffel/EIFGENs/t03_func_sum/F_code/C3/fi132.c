/*
 * Code for class FILE
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "fi132.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {FILE}.make_with_name */
void F490_2264 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_POINTER tp1;
	EIF_POINTER tp2;
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
	RTLI(3);
	RTLR(0,arg1);
	RTLR(1,Current);
	RTLR(2,tr1);
	RTLIU(3);
	
	RTGC;
	F490_2427(Current, arg1);
	*(EIF_INTEGER_32 *)(Current+ _LNGOFF_5_7_2_3_) = (EIF_INTEGER_32) ((EIF_INTEGER_32) 0L);
	{
		/* INLINED CODE (ANY.default_pointer) */
		tp1 = (EIF_POINTER)  0;
		/* END INLINED CODE */
	}
	tp2 = tp1;
	*(EIF_POINTER *)(Current+ _PTROFF_5_7_2_4_1_0_) = (EIF_POINTER) tp2;
	tr1 = RTLNSMART(eif_new_type(783, 1).id);
	F776_4603(RTCW(tr1));
	RTAR(Current, tr1);
	*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
	RTLE;
}

/* {FILE}.set_name */
void F490_2427 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
	RTLI(3);
	RTLR(0,Current);
	RTLR(1,arg1);
	RTLR(2,tr1);
	RTLIU(3);
	
	RTGC;
	RTAR(Current, arg1);
	*(EIF_REFERENCE *)(Current + _REFACS_1_) = (EIF_REFERENCE) arg1;
	tr1 = RTOSCF(2433,F490_2433, (Current));
	tr1 = F156_1911(RTCW(tr1), arg1, *(EIF_REFERENCE *)(Current + _REFACS_2_));
	RTAR(Current, tr1);
	*(EIF_REFERENCE *)(Current + _REFACS_2_) = (EIF_REFERENCE) tr1;
	RTLE;
}

/* {FILE}.buffered_file_info */
static EIF_REFERENCE F490_2433_body (EIF_REFERENCE Current)
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
	RTOSP (2433);
#define Result RTOSR(2433)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(155, 0x01).id, 155, _OBJSIZ_3_2_0_0_0_0_0_0_);
	F156_1894(RTCW(tr1));
	Result = (EIF_REFERENCE) tr1;
	RTOSE (2433);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F490_2433 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(2433,F490_2433_body,(Current));
}

/* {FILE}.set_write_mode */
void F490_2491 (EIF_REFERENCE Current)
{
	GTCX
	
	
	*(EIF_INTEGER_32 *)(Current+ _LNGOFF_5_7_2_3_) = (EIF_INTEGER_32) ((EIF_INTEGER_32) 2L);
}

void EIF_Minit132 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
