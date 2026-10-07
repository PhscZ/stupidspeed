/*
 * Code for class REFLECTOR
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "re117.h"
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

/* {REFLECTOR}.field_conforms_to */
EIF_BOOLEAN F138_1728 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1, EIF_INTEGER_32 arg2)
{
	GTCX
	EIF_INTEGER_32 ti4_1;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	
	
	RTGC;
	ti4_1 = (EIF_INTEGER_32) eif_builtin_ISE_RUNTIME_detachable_type__i4_i4 (arg2);
	Result = (EIF_BOOLEAN) eif_builtin_ISE_RUNTIME_type_conforms_to__i4_i4_b (arg1, ti4_1);
	return Result;
}

void EIF_Minit117 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
