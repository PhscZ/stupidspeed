/*
 * Code for class WORKER
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "wo38.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {WORKER}.make */
void F57_808 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	F56_785(Current);
	*(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_0_) = (EIF_INTEGER_32) arg1;
	RTLE;
}

/* {WORKER}.execute */
void F57_810 (EIF_REFERENCE Current)
{
	GTCX
	EIF_INTEGER_64 loc1 = (EIF_INTEGER_64) 0;
	EIF_INTEGER_64 loc2 = (EIF_INTEGER_64) 0;
	EIF_INTEGER_64 loc3 = (EIF_INTEGER_64) 0;
	EIF_INTEGER_64 loc4 = (EIF_INTEGER_64) 0;
	EIF_INTEGER_32 ti4_1;
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	ti4_1 = *(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_0_);
	loc3 = (EIF_INTEGER_64) ti4_1;
	loc3 = (EIF_INTEGER_64) (EIF_INTEGER_64) (loc3 * (EIF_INTEGER_64) ((EIF_INTEGER_32) 25000000L));
	loc4 = (EIF_INTEGER_64) (EIF_INTEGER_64) (loc3 + (EIF_INTEGER_64) ((EIF_INTEGER_32) 25000000L));
	loc2 = (EIF_INTEGER_64) loc3;
	for (;;) {
		if ((EIF_BOOLEAN) (loc2 >= loc4)) break;
		switch ((EIF_INTEGER_64) (loc2 % (EIF_INTEGER_64) ((EIF_INTEGER_32) 4L))) {
			case RTI64C(0):
				loc1 += (EIF_INTEGER_64) ((EIF_INTEGER_32) 1L);
				break;
			case RTI64C(1):
				loc1 += loc2;
				break;
			case RTI64C(2):
				loc1 += (EIF_INTEGER_64) ((EIF_INTEGER_64) ((EIF_INTEGER_32) 2L) * loc2);
				break;
			case RTI64C(3):
				loc1 += (EIF_INTEGER_64) ((EIF_INTEGER_64) ((EIF_INTEGER_32) 3L) * loc2);
				break;
			default:
				RTEC(EN_WHEN);
		}
		loc2 += (EIF_INTEGER_64) ((EIF_INTEGER_32) 1L);
	}
	*(EIF_INTEGER_64 *)(Current+ _I64OFF_1_1_0_1_0_1_0_) = (EIF_INTEGER_64) loc1;
	RTLE;
}

void EIF_Minit38 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
