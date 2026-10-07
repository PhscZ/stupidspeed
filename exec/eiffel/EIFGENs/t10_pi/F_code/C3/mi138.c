/*
 * Code for class MISMATCH_INFORMATION
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "mi138.h"
#include "../C13/ha634.h"
#include "../C3/mi138.h"
#include <eif_retrieve.h>

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
void F636_3062 (EIF_REFERENCE Current)
{
	GTCX
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	F630_2943(Current, ((EIF_INTEGER_32) 5L));
	RTOSCP(3072,F636_3072, (Current));
	RTLE;
}

/* {MISMATCH_INFORMATION}.internal_put */
void F636_3070 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_POINTER arg2)
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
	tr2 = RTLNS(eif_new_type(816, 0x01).id, 816, _OBJSIZ_1_1_0_3_0_0_0_0_);
	F815_4752(RTCW(tr2), arg2);
	F630_2989(Current, tr1, tr2);
	RTLE;
}

/* {MISMATCH_INFORMATION}.set_string_versions */
void F636_3071 (EIF_REFERENCE Current, EIF_POINTER arg1, EIF_POINTER arg2)
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
		loc1 = RTLNS(eif_new_type(815, 0x01).id, 815, _OBJSIZ_1_0_0_4_0_0_0_0_);
		F815_4752(RTCW(loc1), arg1);
		tb1 = F816_4818(RTCW(loc1));
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
		loc1 = RTLNS(eif_new_type(815, 0x01).id, 815, _OBJSIZ_1_0_0_4_0_0_0_0_);
		F815_4752(RTCW(loc1), arg2);
		tb1 = F816_4818(RTCW(loc1));
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
static void F636_3072_body (EIF_REFERENCE Current)
{
	GTCX
	RTEX;
	

	
	RTEV;
	RTOSP (3072);
	F636_3073(Current, Current, (EIF_POINTER) F630_2997, (EIF_POINTER) F636_3070, (EIF_POINTER) F636_3071);
	RTOSE (3072);
	RTEE;
#undef Result
}

void F636_3072 (EIF_REFERENCE Current)
{
	GTCX
	RTOSCP(3072,F636_3072_body,(Current));
}

/* {MISMATCH_INFORMATION}.set_mismatch_information_access */
void F636_3073 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_POINTER arg2, EIF_POINTER arg3, EIF_POINTER arg4)
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

void EIF_Minit138 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
