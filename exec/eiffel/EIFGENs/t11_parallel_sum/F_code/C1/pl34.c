/*
 * Code for class PLATFORM
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "pl34.h"
#include <string.h>
#include "eif_built_in.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {PLATFORM}.is_thread_capable */
EIF_BOOLEAN F53_730 (EIF_REFERENCE Current)
{
	GTCX
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	
	
	Result = (EIF_BOOLEAN) eif_builtin_PLATFORM_is_thread_capable__b;
	return Result;
}

/* {PLATFORM}.is_windows */
EIF_BOOLEAN F53_733 (EIF_REFERENCE Current)
{
	GTCX
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	
	
	Result = (EIF_BOOLEAN) eif_builtin_PLATFORM_is_windows__b;
	return Result;
}

/* {PLATFORM}.is_little_endian */
static EIF_BOOLEAN F53_738_body (EIF_REFERENCE Current)
{
	GTCX
	RTEX;
	EIF_NATURAL_16 loc1 = (EIF_NATURAL_16) 0;
	EIF_NATURAL_8 loc2 = (EIF_NATURAL_8) 0;
	EIF_NATURAL_8 loc3 = (EIF_NATURAL_8) 0;
	
#define Result RTOTRB(EIF_BOOLEAN)
	RTOUDB(EIF_BOOLEAN, 16)

	
	RTEV;
	RTGC;
	RTOTP;
	loc1 = (EIF_NATURAL_16) (EIF_NATURAL_16) ((EIF_INTEGER_32) 17185L);
	loc2 = (EIF_NATURAL_8) (EIF_NATURAL_8) ((EIF_INTEGER_32) 33L);
	memcpy((void *)(EIF_NATURAL_8 *) &(loc3), (const void *) (EIF_NATURAL_16 *) &(loc1), (size_t) ((EIF_INTEGER_32) 1L));
	Result = (EIF_BOOLEAN) (EIF_BOOLEAN)(loc3 == loc2);
	RTOTE;
	RTEE;
	return Result;
#undef Result
}

EIF_BOOLEAN F53_738 (EIF_REFERENCE Current)
{
	GTCX
	return RTOUCB(EIF_BOOLEAN,16,F53_738_body,(Current));
}

void EIF_Minit34 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
