/*
 * Code for class MISMATCH_INFORMATION
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "mi143.h"
#include <eif_retrieve.h>
#include "../C6/ha276.h"
#include "../C3/mi143.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {MISMATCH_INFORMATION}.default_create */
void F607_3099 (EIF_REFERENCE Current)
{
	GTCX
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	F601_2980(Current, ((EIF_INTEGER_32) 5L));
	RTOUCP(24,F607_3109, (Current));
	RTLE;
}

/* {MISMATCH_INFORMATION}.internal_put */
void F607_3107 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_POINTER arg2)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE tr2 = NULL;
	RTLD;
	
	RTLI(4);
	RTLR(0,arg1);
	RTLR(1,tr1);
	RTLR(2,tr2);
	RTLR(3,Current);
	RTLIU(4);
	
	RTGC;
	tr1 = RTCCL(arg1);
	tr2 = RTLNS(eif_new_type(786, 0x01).id, 786, _OBJSIZ_1_1_0_3_0_0_0_0_);
	F785_4789(RTCW(tr2), arg2);
	F601_3026(Current, tr1, tr2);
	RTLE;
}

/* {MISMATCH_INFORMATION}.set_string_versions */
void F607_3108 (EIF_REFERENCE Current, EIF_POINTER arg1, EIF_POINTER arg2)
{
	GTCX
	EIF_REFERENCE loc1 = (EIF_REFERENCE) 0;
	EIF_POINTER tp1;
	EIF_BOOLEAN tb1;
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,loc1);
	RTLIU(2);
	
	RTGC;
	{
		/* INLINED CODE (ANY.default_pointer) */
		tp1 = (EIF_POINTER)  0;
		/* END INLINED CODE */
	}
	if ((EIF_BOOLEAN)(arg1 == tp1)) {
		*(EIF_REFERENCE *)(Current + _REFACS_7_) = (EIF_REFERENCE) NULL;
	} else {
		loc1 = RTLNS(eif_new_type(785, 0x01).id, 785, _OBJSIZ_1_0_0_4_0_0_0_0_);
		F785_4789(RTCW(loc1), arg1);
		tb1 = F786_4855(RTCW(loc1));
		if (tb1) {
			*(EIF_REFERENCE *)(Current + _REFACS_7_) = (EIF_REFERENCE) NULL;
		} else {
			RTAR(Current, loc1);
			*(EIF_REFERENCE *)(Current + _REFACS_7_) = (EIF_REFERENCE) loc1;
		}
	}
	{
		/* INLINED CODE (ANY.default_pointer) */
		tp1 = (EIF_POINTER)  0;
		/* END INLINED CODE */
	}
	if ((EIF_BOOLEAN)(arg2 == tp1)) {
		*(EIF_REFERENCE *)(Current + _REFACS_8_) = (EIF_REFERENCE) NULL;
	} else {
		loc1 = RTLNS(eif_new_type(785, 0x01).id, 785, _OBJSIZ_1_0_0_4_0_0_0_0_);
		F785_4789(RTCW(loc1), arg2);
		tb1 = F786_4855(RTCW(loc1));
		if (tb1) {
			*(EIF_REFERENCE *)(Current + _REFACS_8_) = (EIF_REFERENCE) NULL;
		} else {
			RTAR(Current, loc1);
			*(EIF_REFERENCE *)(Current + _REFACS_8_) = (EIF_REFERENCE) loc1;
		}
	}
	RTLE;
}

/* {MISMATCH_INFORMATION}.set_callback_pointers */
static void F607_3109_body (EIF_REFERENCE Current)
{
	GTCX
	RTEX;
	
	RTOUDV(24)

	
	RTEV;
	RTOTP;
	F607_3110(Current, Current, (EIF_POINTER) F601_3034, (EIF_POINTER) F607_3107, (EIF_POINTER) F607_3108);
	RTOTE;
	RTEE;
#undef Result
}

void F607_3109 (EIF_REFERENCE Current)
{
	GTCX
	RTOUCP(24,F607_3109_body,(Current));
}

/* {MISMATCH_INFORMATION}.set_mismatch_information_access */
void F607_3110 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_POINTER arg2, EIF_POINTER arg3, EIF_POINTER arg4)
{
	GTCX
	RTLD;
	
	RTLI(1);
	RTLR(0,arg1);
	RTLIU(1);
	
	{
		EIF_OBJECT larg1 = &arg1;
		EIF_POINTER larg2 = arg2;
		EIF_POINTER larg3 = arg3;
		EIF_POINTER larg4 = arg4;set_mismatch_information_access((EIF_OBJECT) larg1, (EIF_PROCEDURE) larg2, (EIF_PROCEDURE) larg3, (EIF_PROCEDURE) larg4);
		
	}
	RTLE;
}

void EIF_Minit143 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
