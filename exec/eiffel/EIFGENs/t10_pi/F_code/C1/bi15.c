/*
 * Code for class BIG
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "bi15.h"
#include "eif_helpers.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {BIG}.make */
void F28_511 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTGC;
	*(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_1_) = (EIF_INTEGER_32) ((EIF_INTEGER_32) 8L);
	{
		static EIF_TYPE_INDEX typarr0[] = {0xFF01,652,736,0xFFFF};
		EIF_TYPE typres0;
		static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
		
		typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
		tr1 = RTLNSP2(typres0.id,0,*(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_1_),sizeof(EIF_INTEGER_64), EIF_TRUE);
	}
	F653_3173(RTCW(tr1), (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L), *(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_1_));
	RTAR(Current, tr1);
	*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
	RTLE;
}

/* {BIG}.compare */
EIF_INTEGER_32 F28_512 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_INTEGER_32 ti4_1;
	EIF_BOOLEAN tb1;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,arg1);
	RTLIU(2);
	
	RTGC;
	tb1 = *(EIF_BOOLEAN *)(RTCW(arg1)+ _CHROFF_1_0_);
	if ((EIF_BOOLEAN)(*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) != tb1)) {
		if (*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_)) {
			ti4_1 = ((EIF_INTEGER_32) -1L);
		} else {
			ti4_1 = ((EIF_INTEGER_32) 1L);
		}
		Result = (EIF_INTEGER_32) ti4_1;
	} else {
		Result = F28_513(Current, arg1);
		if (*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_)) {
			RTLE;
			return (EIF_INTEGER_32) (EIF_INTEGER_32) -Result;
		}
	}
	RTLE;
	return Result;
}

/* {BIG}.compare_mag */
EIF_INTEGER_32 F28_513 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_INTEGER_32 loc1 = (EIF_INTEGER_32) 0;
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_64 ti8_1;
	EIF_INTEGER_64 ti8_2;
	EIF_INTEGER_64 ti8_3;
	EIF_INTEGER_32 ti4_1;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTLD;
	
	RTLI(3);
	RTLR(0,Current);
	RTLR(1,arg1);
	RTLR(2,tr1);
	RTLIU(3);
	
	RTGC;
	ti4_1 = *(EIF_INTEGER_32 *)(RTCW(arg1)+ _LNGOFF_1_1_0_0_);
	if ((EIF_BOOLEAN)(*(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_0_) != ti4_1)) {
		ti4_1 = *(EIF_INTEGER_32 *)(RTCW(arg1)+ _LNGOFF_1_1_0_0_);
		if ((EIF_BOOLEAN) (*(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_0_) < ti4_1)) {
			ti4_1 = ((EIF_INTEGER_32) -1L);
		} else {
			ti4_1 = ((EIF_INTEGER_32) 1L);
		}
		Result = (EIF_INTEGER_32) ti4_1;
	} else {
		loc1 = *(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_0_);
		for (;;) {
			if ((EIF_BOOLEAN) ((EIF_BOOLEAN) (loc1 <= ((EIF_INTEGER_32) 0L)) || (EIF_BOOLEAN)(Result != ((EIF_INTEGER_32) 0L)))) break;
			loc1--;
			tr1 = *(EIF_REFERENCE *)(Current);
			/* INLINED CODE (SPECIAL.item) */
			ti8_2 = *((EIF_INTEGER_64 *)RTCW(tr1) + (loc1));
			/* END INLINED CODE */
			ti8_1 = ti8_2;
			tr1 = *(EIF_REFERENCE *)(RTCW(arg1));
			/* INLINED CODE (SPECIAL.item) */
			ti8_3 = *((EIF_INTEGER_64 *)RTCW(tr1) + (loc1));
			/* END INLINED CODE */
			ti8_2 = ti8_3;
			if ((EIF_BOOLEAN)(ti8_1 != ti8_2)) {
				tr1 = *(EIF_REFERENCE *)(Current);
				/* INLINED CODE (SPECIAL.item) */
				ti8_2 = *((EIF_INTEGER_64 *)RTCW(tr1) + (loc1));
				/* END INLINED CODE */
				ti8_1 = ti8_2;
				tr1 = *(EIF_REFERENCE *)(RTCW(arg1));
				/* INLINED CODE (SPECIAL.item) */
				ti8_3 = *((EIF_INTEGER_64 *)RTCW(tr1) + (loc1));
				/* END INLINED CODE */
				ti8_2 = ti8_3;
				if ((EIF_BOOLEAN) (ti8_1 < ti8_2)) {
					ti4_1 = ((EIF_INTEGER_32) -1L);
				} else {
					ti4_1 = ((EIF_INTEGER_32) 1L);
				}
				Result = (EIF_INTEGER_32) ti4_1;
			}
		}
	}
	RTLE;
	return Result;
}

/* {BIG}.set_from_integer_64 */
void F28_514 (EIF_REFERENCE Current, EIF_INTEGER_64 arg1)
{
	GTCX
	EIF_INTEGER_64 loc1 = (EIF_INTEGER_64) 0;
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_64 ti8_1;
	EIF_INTEGER_32 ti4_1;
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTGC;
	*(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_0_) = (EIF_INTEGER_32) ((EIF_INTEGER_32) 0L);
	*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 0;
	loc1 = (EIF_INTEGER_64) arg1;
	for (;;) {
		if ((EIF_BOOLEAN) (loc1 <= (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L))) break;
		F28_525(Current, (EIF_INTEGER_32) (*(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_0_) + ((EIF_INTEGER_32) 1L)));
		tr1 = *(EIF_REFERENCE *)(Current);
		/* INLINED CODE (SPECIAL.put) */
		*((EIF_INTEGER_64 *)RTCW(tr1) + (*(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_0_))) = (EIF_INTEGER_64) (loc1 % ((EIF_INTEGER_64) RTI64C(1000000000)));
		/* END INLINED CODE */
		;
		(*(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_0_))++;
		loc1 /= ((EIF_INTEGER_64) RTI64C(1000000000));
	}
	RTLE;
}

/* {BIG}.copy_from */
void F28_515 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_INTEGER_32 loc1 = (EIF_INTEGER_32) 0;
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE tr2 = NULL;
	EIF_INTEGER_64 ti8_1;
	EIF_INTEGER_64 ti8_2;
	EIF_INTEGER_32 ti4_1;
	EIF_INTEGER_32 ti4_2;
	EIF_BOOLEAN tb1;
	RTLD;
	
	RTLI(4);
	RTLR(0,arg1);
	RTLR(1,Current);
	RTLR(2,tr1);
	RTLR(3,tr2);
	RTLIU(4);
	
	RTGC;
	ti4_1 = *(EIF_INTEGER_32 *)(RTCW(arg1)+ _LNGOFF_1_1_0_0_);
	F28_525(Current, ti4_1);
	ti4_1 = *(EIF_INTEGER_32 *)(RTCW(arg1)+ _LNGOFF_1_1_0_0_);
	if ((EIF_BOOLEAN) (ti4_1 > ((EIF_INTEGER_32) 0L))) {
		loc1 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 0L);
		for (;;) {
			ti4_1 = *(EIF_INTEGER_32 *)(RTCW(arg1)+ _LNGOFF_1_1_0_0_);
			if ((EIF_BOOLEAN) (loc1 >= ti4_1)) break;
			tr1 = *(EIF_REFERENCE *)(Current);
			tr2 = *(EIF_REFERENCE *)(RTCW(arg1));
			/* INLINED CODE (SPECIAL.item) */
			ti8_2 = *((EIF_INTEGER_64 *)RTCW(tr2) + (loc1));
			/* END INLINED CODE */
			ti8_1 = ti8_2;
			/* INLINED CODE (SPECIAL.put) */
			*((EIF_INTEGER_64 *)RTCW(tr1) + (loc1)) = ti8_1;
			/* END INLINED CODE */
			;
			loc1++;
		}
	}
	ti4_2 = *(EIF_INTEGER_32 *)(RTCW(arg1)+ _LNGOFF_1_1_0_0_);
	*(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_0_) = (EIF_INTEGER_32) ti4_2;
	tb1 = *(EIF_BOOLEAN *)(RTCW(arg1)+ _CHROFF_1_0_);
	*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) tb1;
	RTLE;
}

/* {BIG}.add_from */
void F28_516 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	GTCX
	EIF_BOOLEAN loc1 = (EIF_BOOLEAN) 0;
	EIF_BOOLEAN loc2 = (EIF_BOOLEAN) 0;
	EIF_INTEGER_32 ti4_1;
	RTLD;
	
	RTLI(3);
	RTLR(0,arg1);
	RTLR(1,arg2);
	RTLR(2,Current);
	RTLIU(3);
	
	RTGC;
	loc1 = *(EIF_BOOLEAN *)(RTCW(arg1)+ _CHROFF_1_0_);
	loc2 = *(EIF_BOOLEAN *)(RTCW(arg2)+ _CHROFF_1_0_);
	if ((EIF_BOOLEAN)(loc1 == loc2)) {
		F28_527(Current, arg1, arg2);
		*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) loc1;
	} else {
		ti4_1 = F28_513(RTCW(arg1), arg2);
		if ((EIF_BOOLEAN) (ti4_1 >= ((EIF_INTEGER_32) 0L))) {
			F28_528(Current, arg1, arg2);
			*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) loc1;
		} else {
			F28_528(Current, arg2, arg1);
			*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) loc2;
		}
	}
	F28_526(Current);
	RTLE;
}

/* {BIG}.sub_from */
void F28_517 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	GTCX
	EIF_BOOLEAN loc1 = (EIF_BOOLEAN) 0;
	EIF_BOOLEAN loc2 = (EIF_BOOLEAN) 0;
	EIF_INTEGER_32 ti4_1;
	RTLD;
	
	RTLI(3);
	RTLR(0,arg1);
	RTLR(1,arg2);
	RTLR(2,Current);
	RTLIU(3);
	
	RTGC;
	loc1 = *(EIF_BOOLEAN *)(RTCW(arg1)+ _CHROFF_1_0_);
	loc2 = *(EIF_BOOLEAN *)(RTCW(arg2)+ _CHROFF_1_0_);
	if ((EIF_BOOLEAN)(loc1 != loc2)) {
		F28_527(Current, arg1, arg2);
		*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) loc1;
	} else {
		ti4_1 = F28_513(RTCW(arg1), arg2);
		if ((EIF_BOOLEAN) (ti4_1 >= ((EIF_INTEGER_32) 0L))) {
			F28_528(Current, arg1, arg2);
			*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) loc1;
		} else {
			F28_528(Current, arg2, arg1);
			*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) (EIF_BOOLEAN) !loc1;
		}
	}
	F28_526(Current);
	RTLE;
}

/* {BIG}.mul_small_from */
void F28_518 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_64 arg2)
{
	GTCX
	EIF_INTEGER_64 loc1 = (EIF_INTEGER_64) 0;
	EIF_INTEGER_64 loc2 = (EIF_INTEGER_64) 0;
	EIF_INTEGER_32 loc3 = (EIF_INTEGER_32) 0;
	EIF_INTEGER_32 loc4 = (EIF_INTEGER_32) 0;
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_64 ti8_1;
	EIF_INTEGER_64 ti8_2;
	EIF_INTEGER_32 ti4_1;
	EIF_BOOLEAN tb1;
	RTLD;
	
	RTLI(3);
	RTLR(0,arg1);
	RTLR(1,Current);
	RTLR(2,tr1);
	RTLIU(3);
	
	RTGC;
	tb1 = '\01';
	if (!((EIF_BOOLEAN)(arg2 == (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L)))) {
		ti4_1 = *(EIF_INTEGER_32 *)(RTCW(arg1)+ _LNGOFF_1_1_0_0_);
		tb1 = (EIF_BOOLEAN)(ti4_1 == ((EIF_INTEGER_32) 0L));
	}
	if (tb1) {
		*(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_0_) = (EIF_INTEGER_32) ((EIF_INTEGER_32) 0L);
		*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 0;
	} else {
		ti4_1 = *(EIF_INTEGER_32 *)(RTCW(arg1)+ _LNGOFF_1_1_0_0_);
		F28_525(Current, (EIF_INTEGER_32) (ti4_1 + ((EIF_INTEGER_32) 2L)));
		loc1 = (EIF_INTEGER_64) (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L);
		loc3 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 0L);
		for (;;) {
			ti4_1 = *(EIF_INTEGER_32 *)(RTCW(arg1)+ _LNGOFF_1_1_0_0_);
			if ((EIF_BOOLEAN) (loc3 >= ti4_1)) break;
			tr1 = *(EIF_REFERENCE *)(RTCW(arg1));
			/* INLINED CODE (SPECIAL.item) */
			ti8_2 = *((EIF_INTEGER_64 *)RTCW(tr1) + (loc3));
			/* END INLINED CODE */
			loc2 = ti8_2;
			loc2 = (EIF_INTEGER_64) (EIF_INTEGER_64) ((EIF_INTEGER_64) (loc2 * arg2) + loc1);
			tr1 = *(EIF_REFERENCE *)(Current);
			/* INLINED CODE (SPECIAL.put) */
			*((EIF_INTEGER_64 *)RTCW(tr1) + (loc3)) = (EIF_INTEGER_64) (loc2 % ((EIF_INTEGER_64) RTI64C(1000000000)));
			/* END INLINED CODE */
			;
			loc1 = (EIF_INTEGER_64) (EIF_INTEGER_64) (loc2 / ((EIF_INTEGER_64) RTI64C(1000000000)));
			loc3++;
		}
		loc4 = *(EIF_INTEGER_32 *)(RTCW(arg1)+ _LNGOFF_1_1_0_0_);
		for (;;) {
			if ((EIF_BOOLEAN) (loc1 <= (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L))) break;
			tr1 = *(EIF_REFERENCE *)(Current);
			/* INLINED CODE (SPECIAL.put) */
			*((EIF_INTEGER_64 *)RTCW(tr1) + (loc4)) = (EIF_INTEGER_64) (loc1 % ((EIF_INTEGER_64) RTI64C(1000000000)));
			/* END INLINED CODE */
			;
			loc1 /= ((EIF_INTEGER_64) RTI64C(1000000000));
			loc4++;
		}
		*(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_0_) = (EIF_INTEGER_32) loc4;
		tb1 = *(EIF_BOOLEAN *)(RTCW(arg1)+ _CHROFF_1_0_);
		*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) tb1;
		F28_526(Current);
	}
	RTLE;
}

/* {BIG}.quotient */
EIF_INTEGER_64 F28_519 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	GTCX
	EIF_INTEGER_32 ti4_1;
	EIF_BOOLEAN tb1;
	EIF_BOOLEAN tb2;
	EIF_BOOLEAN tb3;
	EIF_INTEGER_64 Result = ((EIF_INTEGER_64) 0);
	
	RTLD;
	
	RTLI(3);
	RTLR(0,Current);
	RTLR(1,arg1);
	RTLR(2,arg2);
	RTLIU(3);
	
	RTGC;
	tb1 = '\01';
	tb2 = '\01';
	if (!*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_)) {
		tb3 = *(EIF_BOOLEAN *)(RTCW(arg1)+ _CHROFF_1_0_);
		tb2 = tb3;
	}
	if (!tb2) {
		ti4_1 = *(EIF_INTEGER_32 *)(RTCW(arg1)+ _LNGOFF_1_1_0_0_);
		tb1 = (EIF_BOOLEAN)(ti4_1 == ((EIF_INTEGER_32) 0L));
	}
	if (tb1) {
		Result = (EIF_INTEGER_64) (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L);
	} else {
		F28_515(RTCW(arg2), arg1);
		for (;;) {
			if ((EIF_BOOLEAN) (F28_512(Current, arg2) < ((EIF_INTEGER_32) 0L))) break;
			Result += (EIF_INTEGER_64) ((EIF_INTEGER_32) 1L);
			F28_527(RTCW(arg2), arg2, arg1);
		}
	}
	RTLE;
	return Result;
}

/* {BIG}.reserve */
void F28_525 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTGC;
	if ((EIF_BOOLEAN) (arg1 > *(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_1_))) {
		for (;;) {
			if ((EIF_BOOLEAN) (*(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_1_) >= arg1)) break;
			(*(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_1_)) *= ((EIF_INTEGER_32) 2L);
		}
		tr1 = *(EIF_REFERENCE *)(Current);
		tr1 = F653_3206(RTCW(tr1), (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L), *(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_1_));
		RTAR(Current, tr1);
		*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
	}
	RTLE;
}

/* {BIG}.trim */
void F28_526 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_64 ti8_1;
	EIF_INTEGER_64 ti8_2;
	EIF_INTEGER_32 ti4_1;
	EIF_BOOLEAN tb1;
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTGC;
	for (;;) {
		tb1 = '\01';
		if (!(EIF_BOOLEAN)(*(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_0_) == ((EIF_INTEGER_32) 0L))) {
			tr1 = *(EIF_REFERENCE *)(Current);
			/* INLINED CODE (SPECIAL.item) */
			ti8_2 = *((EIF_INTEGER_64 *)RTCW(tr1) + ((EIF_INTEGER_32) (*(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_0_) - ((EIF_INTEGER_32) 1L))));
			/* END INLINED CODE */
			ti8_1 = ti8_2;
			tb1 = (EIF_BOOLEAN)(ti8_1 != (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L));
		}
		if (tb1) break;
		(*(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_0_))--;
	}
	if ((EIF_BOOLEAN)(*(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_0_) == ((EIF_INTEGER_32) 0L))) {
		*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 0;
	}
	RTLE;
}

/* {BIG}.add_mag_from */
void F28_527 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	GTCX
	EIF_INTEGER_64 loc1 = (EIF_INTEGER_64) 0;
	EIF_INTEGER_64 loc2 = (EIF_INTEGER_64) 0;
	EIF_INTEGER_32 loc3 = (EIF_INTEGER_32) 0;
	EIF_INTEGER_32 loc4 = (EIF_INTEGER_32) 0;
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_64 ti8_1;
	EIF_INTEGER_64 ti8_2;
	EIF_INTEGER_32 ti4_1;
	EIF_INTEGER_32 ti4_2;
	RTLD;
	
	RTLI(4);
	RTLR(0,arg1);
	RTLR(1,arg2);
	RTLR(2,Current);
	RTLR(3,tr1);
	RTLIU(4);
	
	RTGC;
	ti4_1 = *(EIF_INTEGER_32 *)(RTCW(arg1)+ _LNGOFF_1_1_0_0_);
	ti4_2 = *(EIF_INTEGER_32 *)(RTCW(arg2)+ _LNGOFF_1_1_0_0_);
	loc4 = eif_max_int32 (ti4_1,ti4_2);
	F28_525(Current, (EIF_INTEGER_32) (loc4 + ((EIF_INTEGER_32) 1L)));
	loc1 = (EIF_INTEGER_64) (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L);
	loc3 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 0L);
	for (;;) {
		if ((EIF_BOOLEAN) (loc3 >= loc4)) break;
		loc2 = (EIF_INTEGER_64) loc1;
		ti4_1 = *(EIF_INTEGER_32 *)(RTCW(arg1)+ _LNGOFF_1_1_0_0_);
		if ((EIF_BOOLEAN) (loc3 < ti4_1)) {
			tr1 = *(EIF_REFERENCE *)(RTCW(arg1));
			/* INLINED CODE (SPECIAL.item) */
			ti8_2 = *((EIF_INTEGER_64 *)RTCW(tr1) + (loc3));
			/* END INLINED CODE */
			ti8_1 = ti8_2;
			loc2 += ti8_1;
		}
		ti4_1 = *(EIF_INTEGER_32 *)(RTCW(arg2)+ _LNGOFF_1_1_0_0_);
		if ((EIF_BOOLEAN) (loc3 < ti4_1)) {
			tr1 = *(EIF_REFERENCE *)(RTCW(arg2));
			/* INLINED CODE (SPECIAL.item) */
			ti8_2 = *((EIF_INTEGER_64 *)RTCW(tr1) + (loc3));
			/* END INLINED CODE */
			ti8_1 = ti8_2;
			loc2 += ti8_1;
		}
		if ((EIF_BOOLEAN) (loc2 >= ((EIF_INTEGER_64) RTI64C(1000000000)))) {
			loc2 -= ((EIF_INTEGER_64) RTI64C(1000000000));
			loc1 = (EIF_INTEGER_64) (EIF_INTEGER_64) ((EIF_INTEGER_32) 1L);
		} else {
			loc1 = (EIF_INTEGER_64) (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L);
		}
		tr1 = *(EIF_REFERENCE *)(Current);
		/* INLINED CODE (SPECIAL.put) */
		*((EIF_INTEGER_64 *)RTCW(tr1) + (loc3)) = loc2;
		/* END INLINED CODE */
		;
		loc3++;
	}
	tr1 = *(EIF_REFERENCE *)(Current);
	/* INLINED CODE (SPECIAL.put) */
	*((EIF_INTEGER_64 *)RTCW(tr1) + (loc4)) = loc1;
	/* END INLINED CODE */
	;
	*(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_0_) = (EIF_INTEGER_32) loc4;
	if ((EIF_BOOLEAN) (loc1 > (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L))) {
		*(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_0_) = (EIF_INTEGER_32) (EIF_INTEGER_32) (loc4 + ((EIF_INTEGER_32) 1L));
	}
	*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 0;
	RTLE;
}

/* {BIG}.sub_mag_from */
void F28_528 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	GTCX
	EIF_INTEGER_64 loc1 = (EIF_INTEGER_64) 0;
	EIF_INTEGER_64 loc2 = (EIF_INTEGER_64) 0;
	EIF_INTEGER_32 loc3 = (EIF_INTEGER_32) 0;
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE tr2 = NULL;
	EIF_INTEGER_64 ti8_1;
	EIF_INTEGER_64 ti8_2;
	EIF_INTEGER_32 ti4_1;
	EIF_INTEGER_32 ti4_2;
	RTLD;
	
	RTLI(5);
	RTLR(0,arg1);
	RTLR(1,Current);
	RTLR(2,arg2);
	RTLR(3,tr1);
	RTLR(4,tr2);
	RTLIU(5);
	
	RTGC;
	ti4_1 = *(EIF_INTEGER_32 *)(RTCW(arg1)+ _LNGOFF_1_1_0_0_);
	F28_525(Current, ti4_1);
	loc1 = (EIF_INTEGER_64) (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L);
	loc3 = (EIF_INTEGER_32) ((EIF_INTEGER_32) 0L);
	for (;;) {
		ti4_1 = *(EIF_INTEGER_32 *)(RTCW(arg1)+ _LNGOFF_1_1_0_0_);
		if ((EIF_BOOLEAN) (loc3 >= ti4_1)) break;
		loc2 = (EIF_INTEGER_64) loc1;
		ti4_2 = *(EIF_INTEGER_32 *)(RTCW(arg2)+ _LNGOFF_1_1_0_0_);
		if ((EIF_BOOLEAN) (loc3 < ti4_2)) {
			tr1 = *(EIF_REFERENCE *)(RTCW(arg2));
			/* INLINED CODE (SPECIAL.item) */
			ti8_2 = *((EIF_INTEGER_64 *)RTCW(tr1) + (loc3));
			/* END INLINED CODE */
			ti8_1 = ti8_2;
			loc2 += ti8_1;
		}
		tr1 = *(EIF_REFERENCE *)(RTCW(arg1));
		/* INLINED CODE (SPECIAL.item) */
		ti8_2 = *((EIF_INTEGER_64 *)RTCW(tr1) + (loc3));
		/* END INLINED CODE */
		ti8_1 = ti8_2;
		if ((EIF_BOOLEAN) (ti8_1 >= loc2)) {
			tr1 = *(EIF_REFERENCE *)(Current);
			tr2 = *(EIF_REFERENCE *)(RTCW(arg1));
			/* INLINED CODE (SPECIAL.item) */
			ti8_2 = *((EIF_INTEGER_64 *)RTCW(tr2) + (loc3));
			/* END INLINED CODE */
			ti8_1 = ti8_2;
			/* INLINED CODE (SPECIAL.put) */
			*((EIF_INTEGER_64 *)RTCW(tr1) + (loc3)) = (EIF_INTEGER_64) (ti8_1 - loc2);
			/* END INLINED CODE */
			;
			loc1 = (EIF_INTEGER_64) (EIF_INTEGER_64) ((EIF_INTEGER_32) 0L);
		} else {
			tr1 = *(EIF_REFERENCE *)(Current);
			tr2 = *(EIF_REFERENCE *)(RTCW(arg1));
			/* INLINED CODE (SPECIAL.item) */
			ti8_2 = *((EIF_INTEGER_64 *)RTCW(tr2) + (loc3));
			/* END INLINED CODE */
			ti8_1 = ti8_2;
			/* INLINED CODE (SPECIAL.put) */
			*((EIF_INTEGER_64 *)RTCW(tr1) + (loc3)) = (EIF_INTEGER_64) ((EIF_INTEGER_64) (ti8_1 + ((EIF_INTEGER_64) RTI64C(1000000000))) - loc2);
			/* END INLINED CODE */
			;
			loc1 = (EIF_INTEGER_64) (EIF_INTEGER_64) ((EIF_INTEGER_32) 1L);
		}
		loc3++;
	}
	ti4_2 = *(EIF_INTEGER_32 *)(RTCW(arg1)+ _LNGOFF_1_1_0_0_);
	*(EIF_INTEGER_32 *)(Current+ _LNGOFF_1_1_0_0_) = (EIF_INTEGER_32) ti4_2;
	*(EIF_BOOLEAN *)(Current+ _CHROFF_1_0_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 0;
	F28_526(Current);
	RTLE;
}

void EIF_Minit15 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
