/*
 * Code for class SYSTEM_ENCODINGS_IMP
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "sy24.h"
#include <windows.h>
#include <Winnls.h>

#ifdef __cplusplus
extern "C" {
#endif

#ifndef INLINE_F37_608
static EIF_NATURAL_32 inline_F37_608 (void)
{
	return (EIF_NATURAL_32) GetConsoleOutputCP ();
	;
}
#define INLINE_F37_608
#endif
#ifndef INLINE_F37_607
static EIF_NATURAL_32 inline_F37_607 (void)
{
	return (EIF_NATURAL_32) GetConsoleCP ();
	;
}
#define INLINE_F37_607
#endif
#ifndef INLINE_F37_611
static EIF_NATURAL_32 inline_F37_611 (void)
{
	return (EIF_NATURAL_32) GetOEMCP ();
	;
}
#define INLINE_F37_611
#endif

#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {SYSTEM_ENCODINGS_IMP}.console_code_page */
EIF_REFERENCE F37_599 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_32 loc1 = (EIF_NATURAL_32) 0;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Result);
	RTLIU(1);
	
	RTGC;
	loc1 = inline_F37_608();
	if ((EIF_BOOLEAN)(loc1 == (EIF_NATURAL_32) ((EIF_INTEGER_32) 0L))) {
		loc1 = inline_F37_607();
		if ((EIF_BOOLEAN)(loc1 == (EIF_NATURAL_32) ((EIF_INTEGER_32) 0L))) {
			loc1 = inline_F37_611();
		}
	}
	Result = RTLNS(eif_new_type(816, 0x01).id, 816, _OBJSIZ_1_1_0_3_0_0_0_0_);
	F815_4749(RTCW(Result), ((EIF_INTEGER_32) 5L));
	F817_4871(RTCW(Result), loc1);
	RTLE;
	return Result;
}

/* {SYSTEM_ENCODINGS_IMP}.console_input_code_page */
EIF_NATURAL_32 F37_607 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_32 Result = ((EIF_NATURAL_32) 0);
	
	
	
	Result = inline_F37_607 ();
	return Result;
}

/* {SYSTEM_ENCODINGS_IMP}.console_output_code_page */
EIF_NATURAL_32 F37_608 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_32 Result = ((EIF_NATURAL_32) 0);
	
	
	
	Result = inline_F37_608 ();
	return Result;
}

/* {SYSTEM_ENCODINGS_IMP}.oem_code_page */
EIF_NATURAL_32 F37_611 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_32 Result = ((EIF_NATURAL_32) 0);
	
	
	
	Result = inline_F37_611 ();
	return Result;
}

void EIF_Minit24 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
