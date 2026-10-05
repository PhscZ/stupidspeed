/*
 * Code for class EXCEPTION_MANAGER_FACTORY
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "ex56.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {EXCEPTION_MANAGER_FACTORY}.exception_manager */
static EIF_REFERENCE F74_1054_body (EIF_REFERENCE Current)
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
	RTOSP (1054);
#define Result RTOSR(1054)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(42, 0x01).id, 42, _OBJSIZ_0_0_0_0_0_0_0_0_);
	Result = (EIF_REFERENCE) tr1;
	RTOSE (1054);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F74_1054 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(1054,F74_1054_body,(Current));
}

void EIF_Minit56 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
