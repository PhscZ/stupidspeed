/*
 * Code for class SYSTEM_ENCODINGS_IMP
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "sy23.h"
#include <Winnls.h>
#include <windows.h>

#ifdef __cplusplus
extern "C" {
#endif

#ifndef INLINE_F35_590
static EIF_NATURAL_32 inline_F35_590 (void)
{
	return (EIF_NATURAL_32) GetConsoleOutputCP ();
	;
}
#define INLINE_F35_590
#endif
#ifndef INLINE_F35_589
static EIF_NATURAL_32 inline_F35_589 (void)
{
	return (EIF_NATURAL_32) GetConsoleCP ();
	;
}
#define INLINE_F35_589
#endif
#ifndef INLINE_F35_593
static EIF_NATURAL_32 inline_F35_593 (void)
{
	return (EIF_NATURAL_32) GetOEMCP ();
	;
}
#define INLINE_F35_593
#endif

#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {SYSTEM_ENCODINGS_IMP}.console_code_page */
EIF_REFERENCE F35_581 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_32 loc1 = (EIF_NATURAL_32) 0;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Result);
	RTLIU(1);
	
	RTGC;
	loc1 = inline_F35_590();
	if ((EIF_BOOLEAN)(loc1 == (EIF_NATURAL_32) ((EIF_INTEGER_32) 0L))) {
		loc1 = inline_F35_589();
		if ((EIF_BOOLEAN)(loc1 == (EIF_NATURAL_32) ((EIF_INTEGER_32) 0L))) {
			loc1 = inline_F35_593();
		}
	}
	Result = RTLNS(eif_new_type(779, 0x01).id, 779, _OBJSIZ_1_1_0_3_0_0_0_0_);
	F778_4731(RTCW(Result), ((EIF_INTEGER_32) 5L));
	F780_4853(RTCW(Result), loc1);
	RTLE;
	return Result;
}

/* {SYSTEM_ENCODINGS_IMP}.console_input_code_page */
EIF_NATURAL_32 F35_589 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_32 Result = ((EIF_NATURAL_32) 0);
	
	
	
	Result = inline_F35_589 ();
	return Result;
}

/* {SYSTEM_ENCODINGS_IMP}.console_output_code_page */
EIF_NATURAL_32 F35_590 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_32 Result = ((EIF_NATURAL_32) 0);
	
	
	
	Result = inline_F35_590 ();
	return Result;
}

/* {SYSTEM_ENCODINGS_IMP}.oem_code_page */
EIF_NATURAL_32 F35_593 (EIF_REFERENCE Current)
{
	GTCX
	EIF_NATURAL_32 Result = ((EIF_NATURAL_32) 0);
	
	
	
	Result = inline_F35_593 ();
	return Result;
}

void EIF_Minit23 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
