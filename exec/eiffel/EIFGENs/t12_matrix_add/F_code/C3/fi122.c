/*
 * Code for class FILE_INFO
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "fi122.h"
#include "eif_eiffel.h"
#include "eif_file.h"
#include "eif_built_in.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef INLINE_F157_1949
static EIF_INTEGER_32 inline_F157_1949 (EIF_POINTER arg1, EIF_POINTER arg2, EIF_INTEGER_32 arg3)
{
	#ifdef EIF_WINDOWS
				return (EIF_INTEGER) MultiByteToWideChar(CP_ACP, 0, (LPSTR) arg1, -1, (LPWSTR) arg2, (int) arg3) * sizeof(wchar_t);
			#else
				return arg3;
			#endif
	;
}
#define INLINE_F157_1949
#endif
#ifndef INLINE_F157_1951
static EIF_INTEGER_32 inline_F157_1951 (void)
{
	return sizeof(wchar_t);
	;
}
#define INLINE_F157_1951
#endif

#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {FILE_INFO}.make */
void F157_1892 (EIF_REFERENCE Current)
{
	GTCX
	EIF_INTEGER_32 ti4_1;
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	ti4_1 = (EIF_INTEGER_32) stat_size();
	F146_1885(Current, (EIF_NATURAL_8) ((EIF_INTEGER_32) 0L), ti4_1);
	*(EIF_BOOLEAN *)(Current+ _CHROFF_3_1_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 1;
	*(EIF_BOOLEAN *)(Current+ _CHROFF_3_0_) = (EIF_BOOLEAN) (EIF_BOOLEAN) 0;
	RTLE;
}

/* {FILE_INFO}.file_name_to_pointer */
EIF_REFERENCE F157_1909 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_REFERENCE arg2)
{
	GTCX
	struct eif_ex_9 sloc1;
	EIF_REFERENCE loc1 = (EIF_REFERENCE) sloc1.data;
	EIF_REFERENCE loc2 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc3 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc4 = (EIF_REFERENCE) 0;
	EIF_POINTER tp1;
	EIF_POINTER tp2;
	EIF_POINTER tp3;
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_32 ti4_1;
	EIF_INTEGER_32 ti4_2;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	memset (&sloc1.overhead, 0, OVERHEAD + _OBJSIZ_0_0_0_0_0_0_0_0_);
	sloc1.overhead.ov_flags = EO_EXP | EO_STACK;
	RT_DFS(&sloc1.overhead, eif_new_type(10, 0x00).id);
	RTLI(9);
	RTLR(0,arg2);
	RTLR(1,Result);
	RTLR(2,loc3);
	RTLR(3,arg1);
	RTLR(4,loc1);
	RTLR(5,loc2);
	RTLR(6,Current);
	RTLR(7,loc4);
	RTLR(8,tr1);
	RTLIU(9);
	
	RTGC;
	Result = (EIF_REFERENCE) arg2;
	if ((EIF_BOOLEAN) eif_builtin_PLATFORM_is_windows__b) {
		loc3 = arg1;
		loc3 = RTRV(eif_new_type(813, 0x01),loc3);
		if (EIF_TEST(loc3)) {
			if ((EIF_BOOLEAN)(Result != NULL)) {
				ti4_1 = (FUNCTION_CAST(EIF_INTEGER_32, (EIF_REFERENCE)) R3484[Dtype(RTCW(arg1))-814])(arg1);
				F117_1291(RTCW(Result), (EIF_INTEGER_32) ((EIF_INTEGER_32) (ti4_1 + ((EIF_INTEGER_32) 1L)) * ((EIF_INTEGER_32) 2L)));
			} else {
				Result = RTLNS(eif_new_type(116, 0x01).id, 116, _OBJSIZ_0_1_0_1_0_1_1_0_);
				ti4_1 = (FUNCTION_CAST(EIF_INTEGER_32, (EIF_REFERENCE)) R3484[Dtype(RTCW(arg1))-814])(arg1);
				F117_1201(RTCW(Result), (EIF_INTEGER_32) ((EIF_INTEGER_32) (ti4_1 + ((EIF_INTEGER_32) 1L)) * ((EIF_INTEGER_32) 2L)));
			}
			ti4_1 = (FUNCTION_CAST(EIF_INTEGER_32, (EIF_REFERENCE)) R3484[Dtype(RTCW(arg1))-814])(arg1);
			F11_281(RTCW(loc1), arg1, ((EIF_INTEGER_32) 1L), ti4_1, Result, ((EIF_INTEGER_32) 0L), NULL);
		} else {
			loc2 = RTLNS(eif_new_type(126, 0x01).id, 126, _OBJSIZ_1_0_0_1_0_0_0_0_);
			F127_1439(RTCW(loc2), arg1);
			if ((EIF_BOOLEAN)(Result != NULL)) {
				tp1 = F127_1461(RTCW(loc2));
				{
					/* INLINED CODE (ANY.default_pointer) */
					tp2 = (EIF_POINTER)  0;
					/* END INLINED CODE */
				}
				tp3 = tp2;
				ti4_1 = inline_F157_1949(tp1, tp3, ((EIF_INTEGER_32) 0L));
				F117_1291(RTCW(Result), ti4_1);
			} else {
				Result = RTLNS(eif_new_type(116, 0x01).id, 116, _OBJSIZ_0_1_0_1_0_1_1_0_);
				tp1 = F127_1461(RTCW(loc2));
				tp2 = F1_33(Current);
				ti4_1 = inline_F157_1949(tp1, tp2, ((EIF_INTEGER_32) 0L));
				F117_1201(RTCW(Result), ti4_1);
			}
			tp1 = F127_1461(RTCW(loc2));
			tp2 = *(EIF_POINTER *)(RTCW(Result)+ _PTROFF_0_1_0_1_0_0_);
			ti4_1 = *(EIF_INTEGER_32 *)(RTCW(Result)+ _LNGOFF_0_1_0_0_);
			ti4_2 = inline_F157_1951();
			ti4_1 = inline_F157_1949(tp1, tp2, (EIF_INTEGER_32) (ti4_1 / ti4_2));
			eif_do_nothing_value.it_i4 = ti4_1;
		}
	} else {
		if ((EIF_BOOLEAN)(Result != NULL)) {
			ti4_1 = (FUNCTION_CAST(EIF_INTEGER_32, (EIF_REFERENCE)) R3484[Dtype(RTCW(arg1))-814])(arg1);
			F117_1291(RTCW(Result), (EIF_INTEGER_32) (ti4_1 + ((EIF_INTEGER_32) 1L)));
		} else {
			Result = RTLNS(eif_new_type(116, 0x01).id, 116, _OBJSIZ_0_1_0_1_0_1_1_0_);
			ti4_1 = (FUNCTION_CAST(EIF_INTEGER_32, (EIF_REFERENCE)) R3484[Dtype(RTCW(arg1))-814])(arg1);
			F117_1201(RTCW(Result), (EIF_INTEGER_32) (ti4_1 + ((EIF_INTEGER_32) 1L)));
		}
		loc4 = arg1;
		loc4 = RTRV(eif_new_type(813, 0x01),loc4);
		if (EIF_TEST(loc4)) {
			ti4_1 = (FUNCTION_CAST(EIF_INTEGER_32, (EIF_REFERENCE)) R3484[Dtype(RTCW(arg1))-814])(arg1);
			F11_256(RTCW(loc1), arg1, ((EIF_INTEGER_32) 1L), ti4_1, Result, ((EIF_INTEGER_32) 0L), NULL);
		} else {
			tr1 = RTLNS(eif_new_type(126, 0x01).id, 126, _OBJSIZ_1_0_0_1_0_0_0_0_);
			tp1 = *(EIF_POINTER *)(RTCW(Result)+ _PTROFF_0_1_0_1_0_0_);
			ti4_1 = (FUNCTION_CAST(EIF_INTEGER_32, (EIF_REFERENCE)) R3484[Dtype(RTCW(arg1))-814])(arg1);
			F127_1444(RTCW(tr1), tp1, ti4_1);
			F127_1467(RTCW(tr1), arg1);
		}
	}
	RTLE;
	return Result;
}

/* {FILE_INFO}.is_equal */
EIF_BOOLEAN F157_1934 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE loc1 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc2 = (EIF_REFERENCE) 0;
	EIF_REFERENCE tr1 = NULL;
	EIF_BOOLEAN tb1;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(5);
	RTLR(0,arg1);
	RTLR(1,Current);
	RTLR(2,loc1);
	RTLR(3,tr1);
	RTLR(4,loc2);
	RTLIU(5);
	
	RTGC;
	if ((EIF_BOOLEAN)(arg1 == Current)) {
		RTLE;
		return (EIF_BOOLEAN) (EIF_BOOLEAN) 1;
	} else {
		tb1 = '\0';
		tr1 = *(EIF_REFERENCE *)(Current + _REFACS_1_);
		loc1 = tr1;
		if (EIF_TEST(loc1)) {
			tr1 = *(EIF_REFERENCE *)(RTCW(arg1) + _REFACS_1_);
			loc2 = tr1;
			tb1 = EIF_TEST(loc2);
		}
		if (tb1) {
			Result = '\0';
			tb1 = F811_4646(loc1, loc2);
			if (tb1) {
				tb1 = *(EIF_BOOLEAN *)(RTCW(arg1)+ _CHROFF_3_1_);
				Result = (EIF_BOOLEAN)(*(EIF_BOOLEAN *)(Current+ _CHROFF_3_1_) == tb1);
			}
		}
	}
	RTLE;
	return Result;
}

/* {FILE_INFO}.copy */
void F157_1935 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE loc1 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc2 = (EIF_REFERENCE) 0;
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
	RTLI(5);
	RTLR(0,arg1);
	RTLR(1,Current);
	RTLR(2,tr1);
	RTLR(3,loc1);
	RTLR(4,loc2);
	RTLIU(5);
	
	RTGC;
	if ((EIF_BOOLEAN)(arg1 != Current)) {
		eif_builtin_ANY_standard_copy__o_ (Current, arg1);
		tr1 = *(EIF_REFERENCE *)(RTCW(arg1));
		tr1 = F1_14(tr1);
		F146_1891(Current, tr1);
		tr1 = *(EIF_REFERENCE *)(RTCW(arg1) + _REFACS_2_);
		loc1 = tr1;
		if (EIF_TEST(loc1)) {
			tr1 = F1_14(loc1);
			RTAR(Current, tr1);
			*(EIF_REFERENCE *)(Current + _REFACS_2_) = (EIF_REFERENCE) tr1;
		}
		tr1 = *(EIF_REFERENCE *)(RTCW(arg1) + _REFACS_1_);
		loc2 = tr1;
		if (EIF_TEST(loc2)) {
			tr1 = F1_14(loc2);
			RTAR(Current, tr1);
			*(EIF_REFERENCE *)(Current + _REFACS_1_) = (EIF_REFERENCE) tr1;
		}
	}
	RTLE;
}

/* {FILE_INFO}.stat_size */
EIF_INTEGER_32 F157_1942 (EIF_REFERENCE Current)
{
	GTCX
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	
	Result = (EIF_INTEGER_32) stat_size();
	
	return Result;
}

/* {FILE_INFO}.multi_byte_to_utf_16 */
EIF_INTEGER_32 F157_1949 (EIF_REFERENCE Current, EIF_POINTER arg1, EIF_POINTER arg2, EIF_INTEGER_32 arg3)
{
	GTCX
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	
	
	Result = inline_F157_1949 ((EIF_POINTER) arg1, (EIF_POINTER) arg2, (EIF_INTEGER_32) arg3);
	return Result;
}

/* {FILE_INFO}.wchar_length */
EIF_INTEGER_32 F157_1951 (EIF_REFERENCE Current)
{
	GTCX
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	
	
	Result = inline_F157_1951 ();
	return Result;
}

void EIF_Minit122 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
