/*
 * Code for class ENCODING
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "en3.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {ENCODING}.make */
void F3_42 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
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
	*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) arg1;
	tr1 = RTOUCR(56,F3_56, (Current));
	RTAR(Current, tr1);
	*(EIF_REFERENCE *)(Current + _REFACS_1_) = (EIF_REFERENCE) tr1;
	RTLE;
}

/* {ENCODING}.last_converted_stream */
EIF_REFERENCE F3_44 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(3);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLR(2,Result);
	RTLIU(3);
	
	RTGC;
	tr1 = *(EIF_REFERENCE *)(Current + _REFACS_1_);
	Result = F793_5204(RTCW(tr1));
	RTLE;
	return Result;
}

/* {ENCODING}.last_converted_string_8 */
EIF_REFERENCE F3_45 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_REFERENCE) F3_44(Current);
}

/* {ENCODING}.convert_to */
void F3_48 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	GTCX
	EIF_BOOLEAN loc1 = (EIF_BOOLEAN) 0;
	EIF_REFERENCE loc2 = (EIF_REFERENCE) 0;
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE tr2 = NULL;
	EIF_BOOLEAN tb1;
	EIF_BOOLEAN tb2;
	EIF_BOOLEAN tb3;
	RTLD;
	
	RTLI(6);
	RTLR(0,loc2);
	RTLR(1,Current);
	RTLR(2,arg1);
	RTLR(3,tr1);
	RTLR(4,arg2);
	RTLR(5,tr2);
	RTLIU(6);
	
	RTGC;
	loc2 = RTOUCR(57,F3_55, (Current));
	tr1 = *(EIF_REFERENCE *)(RTCW(arg1));
	tb1 = (FUNCTION_CAST(EIF_BOOLEAN, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE)) R3828[Dtype(RTCW(loc2))-793])(loc2, *(EIF_REFERENCE *)(Current), tr1);
	if (tb1) {
		RTAR(Current, loc2);
		*(EIF_REFERENCE *)(Current + _REFACS_1_) = (EIF_REFERENCE) loc2;
		loc1 = (EIF_BOOLEAN) (EIF_BOOLEAN) 1;
	} else {
		tr1 = RTOUCR(56,F3_56, (Current));
		RTAR(Current, tr1);
		*(EIF_REFERENCE *)(Current + _REFACS_1_) = (EIF_REFERENCE) tr1;
	}
	tr1 = *(EIF_REFERENCE *)(Current + _REFACS_1_);
	F793_5203(RTCW(tr1));
	if (loc1) {
		tr1 = *(EIF_REFERENCE *)(Current + _REFACS_1_);
		tr2 = *(EIF_REFERENCE *)(RTCW(arg1));
		(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE)) R3821[Dtype(RTCW(tr1))-793])(tr1, *(EIF_REFERENCE *)(Current), arg2, tr2);
	} else {
		tb1 = '\0';
		tb2 = '\0';
		tb3 = F3_52(RTCW(arg1));
		if (tb3) {
			tb2 = F3_52(Current);
		}
		if (tb2) {
			tb1 = F3_53(Current, arg1);
		}
		if (tb1) {
			tr1 = *(EIF_REFERENCE *)(Current + _REFACS_1_);
			tr2 = *(EIF_REFERENCE *)(RTCW(arg1));
			(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE)) R3821[Dtype(RTCW(tr1))-793])(tr1, *(EIF_REFERENCE *)(Current), arg2, tr2);
		}
	}
	RTLE;
}

/* {ENCODING}.last_conversion_successful */
EIF_BOOLEAN F3_49 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTGC;
	tr1 = *(EIF_REFERENCE *)(Current + _REFACS_1_);
	Result = *(EIF_BOOLEAN *)(RTCW(tr1)+ _CHROFF_1_0_);
	RTLE;
	return Result;
}

/* {ENCODING}.same_as */
EIF_BOOLEAN F3_51 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE tr2 = NULL;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(4);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLR(2,arg1);
	RTLR(3,tr2);
	RTLIU(4);
	
	RTGC;
	tr1 = *(EIF_REFERENCE *)(Current);
	tr2 = *(EIF_REFERENCE *)(RTCW(arg1));
	Result = F785_4812(RTCW(tr1), tr2);
	RTLE;
	return Result;
}

/* {ENCODING}.is_valid */
EIF_BOOLEAN F3_52 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTGC;
	tr1 = RTOUCR(56,F3_56, (Current));
	Result = (FUNCTION_CAST(EIF_BOOLEAN, (EIF_REFERENCE, EIF_REFERENCE)) R3826[Dtype(RTCW(tr1))-793])(tr1, *(EIF_REFERENCE *)(Current));
	RTLE;
	return Result;
}

/* {ENCODING}.is_conversion_possible */
EIF_BOOLEAN F3_53 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE tr2 = NULL;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(4);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLR(2,arg1);
	RTLR(3,tr2);
	RTLIU(4);
	
	RTGC;
	tr1 = RTOUCR(56,F3_56, (Current));
	tr2 = *(EIF_REFERENCE *)(RTCW(arg1));
	Result = (FUNCTION_CAST(EIF_BOOLEAN, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE)) R3828[Dtype(RTCW(tr1))-793])(tr1, *(EIF_REFERENCE *)(Current), tr2);
	RTLE;
	return Result;
}

/* {ENCODING}.unicode_conversion */
static EIF_REFERENCE F3_55_body (EIF_REFERENCE Current)
{
	GTCX
	RTEX;
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
#define Result RTOTRR
	RTOUDR(57)

	RTLI(1);
	RTLR(0,tr1);
	RTLIU(1);
	
	RTEV;
	RTGC;
	RTOTP;
	tr1 = RTLNS(eif_new_type(794, 0x01).id, 794, _OBJSIZ_1_2_0_0_0_0_0_0_);
	Result = (EIF_REFERENCE) tr1;
	RTOTE;
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F3_55 (EIF_REFERENCE Current)
{
	GTCX
	return RTOUCR(57,F3_55_body,(Current));
}

/* {ENCODING}.regular_encoding_imp */
static EIF_REFERENCE F3_56_body (EIF_REFERENCE Current)
{
	GTCX
	RTEX;
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
#define Result RTOTRR
	RTOUDR(56)

	RTLI(1);
	RTLR(0,tr1);
	RTLIU(1);
	
	RTEV;
	RTGC;
	RTOTP;
	tr1 = RTLNS(eif_new_type(793, 0x01).id, 793, _OBJSIZ_1_3_0_0_0_0_0_0_);
	Result = (EIF_REFERENCE) tr1;
	RTOTE;
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F3_56 (EIF_REFERENCE Current)
{
	GTCX
	return RTOUCR(56,F3_56_body,(Current));
}

void EIF_Minit3 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
