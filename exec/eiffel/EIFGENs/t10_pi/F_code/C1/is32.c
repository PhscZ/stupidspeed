/*
 * Code for class ISE_EXCEPTION_MANAGER
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "is32.h"
#include "eif_built_in.h"
#include "eif_except.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {ISE_EXCEPTION_MANAGER}.last_exception */
EIF_REFERENCE F45_674 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,Result);
	RTLIU(2);
	
	RTGC;
	Result = *(EIF_REFERENCE *)(RTCV(RTOSCF(692,F45_692, (Current))));
	RTLE;
	return Result;
}

/* {ISE_EXCEPTION_MANAGER}.raise */
void F45_675 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_POINTER loc1 = (EIF_POINTER) 0;
	EIF_POINTER loc2 = (EIF_POINTER) 0;
	EIF_REFERENCE loc3 = (EIF_REFERENCE) 0;
	EIF_POINTER tp1;
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_32 ti4_1;
	EIF_BOOLEAN tb1;
	RTLD;
	
	RTLI(4);
	RTLR(0,arg1);
	RTLR(1,Current);
	RTLR(2,tr1);
	RTLR(3,loc3);
	RTLIU(4);
	
	RTGC;
	tb1 = F78_1115(RTCW(arg1));
	if ((EIF_BOOLEAN) !tb1) {
		if ((EIF_BOOLEAN) EIF_TEST(eif_is_in_rescue())) {
			tr1 = F45_674(Current);
			F78_1119(RTCW(arg1), tr1);
		}
		F45_686(Current, arg1);
		{
			/* INLINED CODE (ANY.default_pointer) */
			tp1 = (EIF_POINTER)  0;
			/* END INLINED CODE */
		}
		loc1 = tp1;
		tr1 = *(EIF_REFERENCE *)(RTCW(arg1) + _REFACS_3_);
		loc3 = tr1;
		if (EIF_TEST(loc3)) {
			loc2 = F128_1479(loc3);
		} else {
			{
				/* INLINED CODE (ANY.default_pointer) */
				tp1 = (EIF_POINTER)  0;
				/* END INLINED CODE */
			}
			loc2 = tp1;
		}
		ti4_1 = (FUNCTION_CAST(EIF_INTEGER_32, (EIF_REFERENCE)) R1044[Dtype(RTCW(arg1))-77])(arg1);
		eif_builtin_ISE_EXCEPTION_MANAGER_developer_raise__i4_p_p_ (ti4_1, loc1, loc2);
	}
	RTLE;
}

/* {ISE_EXCEPTION_MANAGER}.is_ignored */
EIF_BOOLEAN F45_681 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_32 ti4_1;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(3);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLR(2,arg1);
	RTLIU(3);
	
	RTGC;
	tr1 = RTOSCF(688,F45_688, (Current));
	ti4_1 = (EIF_INTEGER_32) eif_builtin_TYPE_type_id__i4 (arg1);
	Result = F633_2951(RTCW(tr1), ti4_1);
	RTLE;
	return Result;
}

/* {ISE_EXCEPTION_MANAGER}.type_of_code */
EIF_REFERENCE F45_683 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,tr1);
	RTLR(1,Result);
	RTLIU(2);
	
	RTGC;
	switch (arg1) {
		case 1L:
			tr1 = RTLNTY2(eif_new_type(101, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 2L:
			tr1 = RTLNTY2(eif_new_type(92, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 3L:
			tr1 = RTLNTY2(eif_new_type(114, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 4L:
			tr1 = RTLNTY2(eif_new_type(113, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 5L:
			tr1 = RTLNTY2(eif_new_type(81, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 6L:
			tr1 = RTLNTY2(eif_new_type(112, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 7L:
			tr1 = RTLNTY2(eif_new_type(115, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 8L:
			tr1 = RTLNTY2(eif_new_type(100, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 9L:
			tr1 = RTLNTY2(eif_new_type(99, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 10L:
			tr1 = RTLNTY2(eif_new_type(111, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 11L:
			tr1 = RTLNTY2(eif_new_type(110, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 12L:
			tr1 = RTLNTY2(eif_new_type(83, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 13L:
			tr1 = RTLNTY2(eif_new_type(87, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 14L:
			tr1 = RTLNTY2(eif_new_type(107, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 15L:
			tr1 = RTLNTY2(eif_new_type(92, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 16L:
			tr1 = RTLNTY2(eif_new_type(106, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 17L:
			tr1 = RTLNTY2(eif_new_type(103, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 18L:
			tr1 = RTLNTY2(eif_new_type(91, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 19L:
			tr1 = RTLNTY2(eif_new_type(98, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 20L:
			tr1 = RTLNTY2(eif_new_type(108, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 21L:
			tr1 = RTLNTY2(eif_new_type(96, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 22L:
			tr1 = RTLNTY2(eif_new_type(85, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 23L:
			tr1 = RTLNTY2(eif_new_type(95, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 24L:
			tr1 = RTLNTY2(eif_new_type(78, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 25L:
			tr1 = RTLNTY2(eif_new_type(87, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 26L:
			tr1 = RTLNTY2(eif_new_type(104, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 27L:
			tr1 = RTLNTY2(eif_new_type(96, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 28L:
			tr1 = RTLNTY2(eif_new_type(84, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 29L:
			tr1 = RTLNTY2(eif_new_type(115, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 30L:
			tr1 = RTLNTY2(eif_new_type(88, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		case 31L:
			tr1 = RTLNTY2(eif_new_type(94, 0x01), 0x01);
			Result = (EIF_REFERENCE) tr1;
			break;
		default:
			Result = (EIF_REFERENCE) NULL;
			break;
	}
	RTLE;
	return Result;
}

/* {ISE_EXCEPTION_MANAGER}.exception_from_code */
EIF_REFERENCE F45_684 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE loc1 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc2 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc3 = (EIF_REFERENCE) 0;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(5);
	RTLR(0,Result);
	RTLR(1,loc3);
	RTLR(2,Current);
	RTLR(3,loc1);
	RTLR(4,loc2);
	RTLIU(5);
	
	RTGC;
	switch (arg1) {
		case 1L:
			Result = RTLNS(eif_new_type(101, 0x01).id, 101, _OBJSIZ_5_1_0_1_0_0_0_0_);
			break;
		case 2L:
			loc3 = *(EIF_REFERENCE *)(RTCV(RTOSCF(693,F45_693, (Current))));
			F93_1169(RTCW(loc3), ((EIF_INTEGER_32) 2L));
			Result = (EIF_REFERENCE) loc3;
			break;
		case 3L:
			Result = RTLNS(eif_new_type(114, 0x01).id, 114, _OBJSIZ_5_1_0_1_0_0_0_0_);
			break;
		case 4L:
			Result = RTLNS(eif_new_type(113, 0x01).id, 113, _OBJSIZ_5_1_0_1_0_0_0_0_);
			break;
		case 5L:
			Result = RTLNS(eif_new_type(81, 0x01).id, 81, _OBJSIZ_5_1_0_1_0_0_0_0_);
			break;
		case 6L:
			Result = RTLNS(eif_new_type(112, 0x01).id, 112, _OBJSIZ_5_2_0_1_0_0_0_0_);
			break;
		case 7L:
			Result = RTLNS(eif_new_type(115, 0x01).id, 115, _OBJSIZ_5_1_0_1_0_0_0_0_);
			break;
		case 8L:
			Result = RTLNS(eif_new_type(100, 0x01).id, 100, _OBJSIZ_7_1_0_1_0_0_0_0_);
			break;
		case 9L:
			Result = RTLNS(eif_new_type(99, 0x01).id, 99, _OBJSIZ_5_1_0_1_0_0_0_0_);
			break;
		case 10L:
			Result = RTLNS(eif_new_type(111, 0x01).id, 111, _OBJSIZ_5_1_0_1_0_0_0_0_);
			break;
		case 11L:
			Result = RTLNS(eif_new_type(110, 0x01).id, 110, _OBJSIZ_5_1_0_1_0_0_0_0_);
			break;
		case 12L:
			Result = RTLNS(eif_new_type(83, 0x01).id, 83, _OBJSIZ_5_1_0_2_0_0_0_0_);
			break;
		case 13L:
			loc1 = RTLNS(eif_new_type(87, 0x01).id, 87, _OBJSIZ_5_1_0_2_0_0_0_0_);
			F88_1161(RTCW(loc1), ((EIF_INTEGER_32) 13L));
			Result = (EIF_REFERENCE) loc1;
			break;
		case 14L:
			Result = RTLNS(eif_new_type(107, 0x01).id, 107, _OBJSIZ_5_1_0_1_0_0_0_0_);
			break;
		case 15L:
			loc3 = *(EIF_REFERENCE *)(RTCV(RTOSCF(693,F45_693, (Current))));
			F93_1169(RTCW(loc3), ((EIF_INTEGER_32) 15L));
			Result = (EIF_REFERENCE) loc3;
			break;
		case 16L:
			Result = RTLNS(eif_new_type(106, 0x01).id, 106, _OBJSIZ_5_1_0_1_0_0_0_0_);
			break;
		case 17L:
			Result = RTLNS(eif_new_type(103, 0x01).id, 103, _OBJSIZ_5_1_0_1_0_0_0_0_);
			break;
		case 18L:
			Result = RTLNS(eif_new_type(91, 0x01).id, 91, _OBJSIZ_5_1_0_1_0_0_0_0_);
			break;
		case 19L:
			Result = RTLNS(eif_new_type(98, 0x01).id, 98, _OBJSIZ_5_1_0_1_0_0_0_0_);
			break;
		case 20L:
			Result = RTLNS(eif_new_type(108, 0x01).id, 108, _OBJSIZ_5_1_0_1_0_0_0_0_);
			break;
		case 21L:
			loc2 = RTLNS(eif_new_type(96, 0x01).id, 96, _OBJSIZ_5_1_0_3_0_0_0_0_);
			F97_1179(RTCW(loc2), ((EIF_INTEGER_32) 21L));
			Result = (EIF_REFERENCE) loc2;
			break;
		case 22L:
			Result = RTLNS(eif_new_type(85, 0x01).id, 85, _OBJSIZ_5_1_0_2_0_0_0_0_);
			break;
		case 23L:
			Result = RTLNS(eif_new_type(95, 0x01).id, 95, _OBJSIZ_5_1_0_1_0_0_0_0_);
			break;
		case 24L:
			Result = RTLNS(eif_new_type(78, 0x01).id, 78, _OBJSIZ_5_1_0_1_0_0_0_0_);
			break;
		case 25L:
			loc1 = RTLNS(eif_new_type(87, 0x01).id, 87, _OBJSIZ_5_1_0_2_0_0_0_0_);
			F88_1161(RTCW(loc1), ((EIF_INTEGER_32) 25L));
			Result = (EIF_REFERENCE) loc1;
			break;
		case 26L:
			Result = RTLNS(eif_new_type(104, 0x01).id, 104, _OBJSIZ_5_1_0_1_0_0_0_0_);
			break;
		case 27L:
			loc2 = RTLNS(eif_new_type(96, 0x01).id, 96, _OBJSIZ_5_1_0_3_0_0_0_0_);
			F97_1179(RTCW(loc2), ((EIF_INTEGER_32) 27L));
			Result = (EIF_REFERENCE) loc2;
			break;
		case 28L:
			Result = RTLNS(eif_new_type(84, 0x01).id, 84, _OBJSIZ_6_1_0_3_0_0_0_0_);
			break;
		case 29L:
			Result = RTLNS(eif_new_type(115, 0x01).id, 115, _OBJSIZ_5_1_0_1_0_0_0_0_);
			break;
		case 30L:
			Result = RTLNS(eif_new_type(88, 0x01).id, 88, _OBJSIZ_5_1_0_1_0_0_0_0_);
			break;
		case 31L:
			Result = RTLNS(eif_new_type(94, 0x01).id, 94, _OBJSIZ_5_1_0_1_0_0_0_0_);
			break;
	}
	RTLE;
	return Result;
}

/* {ISE_EXCEPTION_MANAGER}.exception_data */
EIF_REFERENCE F45_685 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,Result);
	RTLIU(2);
	
	RTGC;
	Result = *(EIF_REFERENCE *)(RTCV(RTOSCF(691,F45_691, (Current))));
	RTLE;
	return Result;
}

/* {ISE_EXCEPTION_MANAGER}.set_last_exception */
void F45_686 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
	RTLI(3);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLR(2,arg1);
	RTLIU(3);
	
	RTGC;
	tr1 = RTOSCF(692,F45_692, (Current));
	F47_735(RTCW(tr1), arg1);
	RTLE;
}

/* {ISE_EXCEPTION_MANAGER}.set_exception_data */
void F45_687 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1, EIF_BOOLEAN arg2, EIF_INTEGER_32 arg3, EIF_INTEGER_32 arg4, EIF_REFERENCE arg5, EIF_REFERENCE arg6, EIF_REFERENCE arg7, EIF_REFERENCE arg8, EIF_REFERENCE arg9, EIF_REFERENCE arg10, EIF_INTEGER_32 arg11, EIF_BOOLEAN arg12)
{
	GTCX
	EIF_REFERENCE loc1 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc2 = (EIF_REFERENCE) 0;
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE tr2 = NULL;
	RTLD;
	
	RTLI(11);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLR(2,tr2);
	RTLR(3,arg5);
	RTLR(4,arg6);
	RTLR(5,arg7);
	RTLR(6,arg8);
	RTLR(7,arg9);
	RTLR(8,arg10);
	RTLR(9,loc1);
	RTLR(10,loc2);
	RTLIU(11);
	
	RTGC;
	tr1 = RTOSCF(691,F45_691, (Current));
	{
		static EIF_TYPE_INDEX typarr0[] = {0xFF01,0xFFF9,11,733,739,739,739,0xFF01,816,0xFF01,816,0xFF01,816,0xFF01,816,0xFF01,816,0xFF01,816,739,772,0xFFFF};
		EIF_TYPE typres0;
		static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
		
		typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
		tr2 = RTLNTS(typres0.id, 12, 0);
	}
	((EIF_TYPED_VALUE *)tr2+1)->it_i4 = arg1;
	((EIF_TYPED_VALUE *)tr2+2)->it_i4 = arg3;
	((EIF_TYPED_VALUE *)tr2+3)->it_i4 = arg4;
	((EIF_TYPED_VALUE *)tr2+4)->it_r = arg5;
	RTAR(tr2,arg5);
	((EIF_TYPED_VALUE *)tr2+5)->it_r = arg6;
	RTAR(tr2,arg6);
	((EIF_TYPED_VALUE *)tr2+6)->it_r = arg7;
	RTAR(tr2,arg7);
	((EIF_TYPED_VALUE *)tr2+7)->it_r = arg8;
	RTAR(tr2,arg8);
	((EIF_TYPED_VALUE *)tr2+8)->it_r = arg9;
	RTAR(tr2,arg9);
	((EIF_TYPED_VALUE *)tr2+9)->it_r = arg10;
	RTAR(tr2,arg10);
	((EIF_TYPED_VALUE *)tr2+10)->it_i4 = arg11;
	((EIF_TYPED_VALUE *)tr2+11)->it_b = arg12;
	F47_735(RTCW(tr1), tr2);
	if (arg2) {
		tr1 = F45_695(Current);
		loc1 = tr1;
		if (EIF_TEST(loc1)) {
			F45_686(Current, loc1);
		}
	} else {
		RTCT0("last_exception_attached", EX_CHECK);
		tr1 = F45_674(Current);
		loc2 = tr1;
		if (EIF_TEST(loc2)) {
			RTCK0;
		} else {
			RTCF0;
		}
		F78_1126(loc2, arg10);
		F78_1120(loc2, arg6);
		F78_1124(loc2, arg7);
	}
	RTLE;
}

/* {ISE_EXCEPTION_MANAGER}.ignored_exceptions */
static EIF_REFERENCE F45_688_body (EIF_REFERENCE Current)
{
	GTCX
	RTEX;
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	

	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTEV;
	RTGC;
	RTOSP (688);
#define Result RTOSR(688)
	RTOC_NEW(Result);
	{
		static EIF_TYPE_INDEX typarr0[] = {0xFF01,632,739,739,0xFFFF};
		EIF_TYPE typres0;
		static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
		
		typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
		tr1 = RTLNS(typres0.id, 632, _OBJSIZ_4_3_0_10_0_0_0_0_);
	}
	F633_2943(RTCW(tr1), ((EIF_INTEGER_32) 0L));
	Result = (EIF_REFERENCE) tr1;
	RTOSE (688);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F45_688 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(688,F45_688_body,(Current));
}

/* {ISE_EXCEPTION_MANAGER}.unignorable_exceptions */
static EIF_REFERENCE F45_689_body (EIF_REFERENCE Current)
{
	GTCX
	RTEX;
	EIF_INTEGER_32 loc1 = (EIF_INTEGER_32) 0;
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	

	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTEV;
	RTGC;
	RTOSP (689);
#define Result RTOSR(689)
	RTOC_NEW(Result);
	{
		static EIF_TYPE_INDEX typarr0[] = {0xFF01,632,739,739,0xFFFF};
		EIF_TYPE typres0;
		static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
		
		typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
		tr1 = RTLNS(typres0.id, 632, _OBJSIZ_4_3_0_10_0_0_0_0_);
	}
	F633_2943(RTCW(tr1), ((EIF_INTEGER_32) 1L));
	Result = (EIF_REFERENCE) tr1;
	tr1 = RTLNTY2(eif_new_type(101, 0x01), 0x01);
	loc1 = (EIF_INTEGER_32) eif_builtin_TYPE_type_id__i4 (tr1);
	F633_2990(RTCW(Result), loc1, loc1);
	RTOSE (689);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F45_689 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(689,F45_689_body,(Current));
}

/* {ISE_EXCEPTION_MANAGER}.unraisable_exceptions */
static EIF_REFERENCE F45_690_body (EIF_REFERENCE Current)
{
	GTCX
	RTEX;
	EIF_INTEGER_32 loc1 = (EIF_INTEGER_32) 0;
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	

	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTEV;
	RTGC;
	RTOSP (690);
#define Result RTOSR(690)
	RTOC_NEW(Result);
	{
		static EIF_TYPE_INDEX typarr0[] = {0xFF01,632,739,739,0xFFFF};
		EIF_TYPE typres0;
		static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
		
		typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
		tr1 = RTLNS(typres0.id, 632, _OBJSIZ_4_3_0_10_0_0_0_0_);
	}
	F633_2943(RTCW(tr1), ((EIF_INTEGER_32) 2L));
	Result = (EIF_REFERENCE) tr1;
	tr1 = RTLNTY2(eif_new_type(100, 0x01), 0x01);
	loc1 = (EIF_INTEGER_32) eif_builtin_TYPE_type_id__i4 (tr1);
	F633_2990(RTCW(Result), loc1, loc1);
	tr1 = RTLNTY2(eif_new_type(88, 0x01), 0x01);
	loc1 = (EIF_INTEGER_32) eif_builtin_TYPE_type_id__i4 (tr1);
	F633_2990(RTCW(Result), loc1, loc1);
	RTOSE (690);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F45_690 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(690,F45_690_body,(Current));
}

/* {ISE_EXCEPTION_MANAGER}.exception_data_cell */
static EIF_REFERENCE F45_691_body (EIF_REFERENCE Current)
{
	GTCX
	RTEX;
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	

	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTEV;
	RTGC;
	RTOSP (691);
#define Result RTOSR(691)
	RTOC_NEW(Result);
	{
		static EIF_TYPE_INDEX typarr0[] = {0xFF01,46,0xFFF9,11,733,739,739,739,0xFF01,816,0xFF01,816,0xFF01,816,0xFF01,816,0xFF01,816,0xFF01,816,739,772,0xFFFF};
		EIF_TYPE typres0;
		static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
		
		typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
		tr1 = RTLNS(typres0.id, 46, _OBJSIZ_1_0_0_0_0_0_0_0_);
	}
	F47_735(RTCW(tr1), NULL);
	Result = (EIF_REFERENCE) tr1;
	RTOSE (691);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F45_691 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(691,F45_691_body,(Current));
}

/* {ISE_EXCEPTION_MANAGER}.last_exception_cell */
static EIF_REFERENCE F45_692_body (EIF_REFERENCE Current)
{
	GTCX
	RTEX;
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	

	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTEV;
	RTGC;
	RTOSP (692);
#define Result RTOSR(692)
	RTOC_NEW(Result);
	{
		static EIF_TYPE_INDEX typarr0[] = {0xFF01,46,77,0xFFFF};
		EIF_TYPE typres0;
		static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
		
		typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
		tr1 = RTLNS(typres0.id, 46, _OBJSIZ_1_0_0_0_0_0_0_0_);
	}
	F47_735(RTCW(tr1), NULL);
	Result = (EIF_REFERENCE) tr1;
	RTOSE (692);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F45_692 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(692,F45_692_body,(Current));
}

/* {ISE_EXCEPTION_MANAGER}.no_memory_exception_object_cell */
static EIF_REFERENCE F45_693_body (EIF_REFERENCE Current)
{
	GTCX
	RTEX;
	EIF_REFERENCE loc1 = (EIF_REFERENCE) 0;
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	

	RTLI(3);
	RTLR(0,loc1);
	RTLR(1,tr1);
	RTLR(2,Current);
	RTLIU(3);
	
	RTEV;
	RTGC;
	RTOSP (693);
#define Result RTOSR(693)
	RTOC_NEW(Result);
	loc1 = RTLNS(eif_new_type(92, 0x01).id, 92, _OBJSIZ_5_1_0_2_0_0_0_0_);
	tr1 = RTLNS(eif_new_type(816, 0x01).id, 816, _OBJSIZ_1_1_0_3_0_0_0_0_);
	F815_4749(RTCW(tr1), ((EIF_INTEGER_32) 4096L));
	F78_1126(RTCW(loc1), tr1);
	{
		static EIF_TYPE_INDEX typarr0[] = {0xFF01,46,0xFF01,92,0xFFFF};
		EIF_TYPE typres0;
		static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
		
		typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(Dftype(Current), typarr0)));
		tr1 = RTLNS(typres0.id, 46, _OBJSIZ_1_0_0_0_0_0_0_0_);
	}
	F47_735(RTCW(tr1), loc1);
	Result = (EIF_REFERENCE) tr1;
	RTOSE (693);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F45_693 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(693,F45_693_body,(Current));
}

/* {ISE_EXCEPTION_MANAGER}.is_code_ignored */
EIF_BOOLEAN F45_694 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	EIF_REFERENCE loc1 = (EIF_REFERENCE) 0;
	EIF_REFERENCE tr1 = NULL;
	RTCFDT;
	RTLD;
	
	RTLI(3);
	RTLR(0,loc1);
	RTLR(1,Current);
	RTLR(2,tr1);
	RTLIU(3);
	
	RTGC;
	tr1 = F45_683(Current, arg1);
	loc1 = tr1;
	if (EIF_TEST(loc1)) {
		RTLE;
		return (EIF_BOOLEAN) F45_681(Current, loc1);
	} else {
		RTLE;
		return (EIF_BOOLEAN) (EIF_BOOLEAN) 1;
	}/* NOTREACHED */
	
}

/* {ISE_EXCEPTION_MANAGER}.exception_from_data */
EIF_REFERENCE F45_695 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE loc1 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc2 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc3 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc4 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc5 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc6 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc7 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc8 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc9 = (EIF_REFERENCE) 0;
	EIF_REFERENCE loc10 = (EIF_REFERENCE) 0;
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_32 ti4_1;
	EIF_BOOLEAN tb1;
	RTCFDT;
	RTLD;
	
	RTLI(12);
	RTLR(0,loc2);
	RTLR(1,Current);
	RTLR(2,tr1);
	RTLR(3,loc3);
	RTLR(4,loc4);
	RTLR(5,loc1);
	RTLR(6,loc5);
	RTLR(7,loc6);
	RTLR(8,loc7);
	RTLR(9,loc8);
	RTLR(10,loc9);
	RTLR(11,loc10);
	RTLIU(12);
	
	RTGC;
	tb1 = '\0';
	tr1 = F45_685(Current);
	loc2 = tr1;
	if (EIF_TEST(loc2)) {
		ti4_1 = eif_integer_32_item(loc2,1);
		tr1 = F45_684(Current, ti4_1);
		loc3 = tr1;
		tb1 = EIF_TEST(loc3);
	}
	if (tb1) {
		loc4 = loc3;
		loc4 = RTRV(eif_new_type(100, 0x01),loc4);
		if (EIF_TEST(loc4)) {
			loc1 = F45_674(Current);
			if ((EIF_BOOLEAN)(loc1 != NULL)) {
				F78_1119(loc3, loc1);
			}
			tr1 = eif_boxed_item(loc2,7);
			F101_1189(loc4, tr1);
			tr1 = eif_boxed_item(loc2,8);
			F101_1190(loc4, tr1);
		} else {
			loc5 = loc3;
			loc5 = RTRV(eif_new_type(88, 0x01),loc5);
			if (EIF_TEST(loc5)) {
				loc1 = F45_674(Current);
				if ((EIF_BOOLEAN)(loc1 != NULL)) {
					F78_1119(loc3, loc1);
				}
			} else {
				loc6 = loc3;
				loc6 = RTRV(eif_new_type(112, 0x01),loc6);
				if (EIF_TEST(loc6)) {
					tb1 = eif_boolean_item(loc2,11);
					F113_1208(loc6, tb1);
				} else {
					loc7 = loc3;
					loc7 = RTRV(eif_new_type(83, 0x01),loc7);
					if (EIF_TEST(loc7)) {
						ti4_1 = eif_integer_32_item(loc2,2);
						F84_1135(loc7, ti4_1);
					} else {
						loc8 = loc3;
						loc8 = RTRV(eif_new_type(96, 0x01),loc8);
						if (EIF_TEST(loc8)) {
							ti4_1 = eif_integer_32_item(loc2,3);
							F97_1178(loc8, ti4_1);
						} else {
							loc9 = loc3;
							loc9 = RTRV(eif_new_type(85, 0x01),loc9);
							if (EIF_TEST(loc9)) {
								ti4_1 = eif_integer_32_item(loc2,3);
								F86_1158(loc9, ti4_1);
							} else {
								loc10 = loc3;
								loc10 = RTRV(eif_new_type(84, 0x01),loc10);
								if (EIF_TEST(loc10)) {
									ti4_1 = eif_integer_32_item(loc2,2);
									F85_1140(loc10, ti4_1);
									tr1 = eif_boxed_item(loc2,4);
									F85_1145(loc10, tr1);
								}
							}
						}
					}
				}
				if ((EIF_BOOLEAN) EIF_TEST(eif_is_in_rescue())) {
					loc1 = F45_674(Current);
				}
				if ((EIF_BOOLEAN)(loc1 == NULL)) {
					loc1 = (EIF_REFERENCE) loc3;
				}
				F78_1119(loc3, loc1);
			}
		}
		tr1 = eif_boxed_item(loc2,9);
		F78_1126(loc3, tr1);
		tr1 = eif_boxed_item(loc2,4);
		F78_1112(loc3, tr1);
		tr1 = eif_boxed_item(loc2,5);
		F78_1120(loc3, tr1);
		tr1 = eif_boxed_item(loc2,6);
		F78_1124(loc3, tr1);
		RTLE;
		return (EIF_REFERENCE) loc3;
	}
	RTLE;
	return (EIF_REFERENCE) 0;
}

/* {ISE_EXCEPTION_MANAGER}.once_raise */
void F45_696 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_POINTER loc1 = (EIF_POINTER) 0;
	EIF_POINTER loc2 = (EIF_POINTER) 0;
	EIF_REFERENCE loc3 = (EIF_REFERENCE) 0;
	EIF_POINTER tp1;
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE tr2 = NULL;
	EIF_INTEGER_32 ti4_1;
	EIF_BOOLEAN tb1;
	RTLD;
	
	RTLI(5);
	RTLR(0,arg1);
	RTLR(1,tr1);
	RTLR(2,Current);
	RTLR(3,tr2);
	RTLR(4,loc3);
	RTLIU(5);
	
	RTGC;
	tb1 = F78_1115(RTCW(arg1));
	if ((EIF_BOOLEAN) !tb1) {
		if ((EIF_BOOLEAN) EIF_TEST(eif_is_in_rescue())) {
			tr1 = F78_1105(RTCW(arg1));
			tr2 = F45_674(Current);
			F78_1119(RTCW(tr1), tr2);
		}
		F45_686(Current, arg1);
		{
			/* INLINED CODE (ANY.default_pointer) */
			tp1 = (EIF_POINTER)  0;
			/* END INLINED CODE */
		}
		loc1 = tp1;
		tr1 = *(EIF_REFERENCE *)(RTCW(arg1) + _REFACS_3_);
		loc3 = tr1;
		if (EIF_TEST(loc3)) {
			loc2 = F128_1479(loc3);
		} else {
			{
				/* INLINED CODE (ANY.default_pointer) */
				tp1 = (EIF_POINTER)  0;
				/* END INLINED CODE */
			}
			loc2 = tp1;
		}
		ti4_1 = (FUNCTION_CAST(EIF_INTEGER_32, (EIF_REFERENCE)) R1044[Dtype(RTCW(arg1))-77])(arg1);
		eif_builtin_ISE_EXCEPTION_MANAGER_developer_raise__i4_p_p_ (ti4_1, loc1, loc2);
	}
	RTLE;
}

/* {ISE_EXCEPTION_MANAGER}.init_exception_manager */
void F45_697 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLIU(2);
	
	RTGC;
	{
		/* INLINED CODE (ANY.do_nothing) */
		tr1 = RTOSCF(688,F45_688, (Current));
		(void) RTCW(tr1);
		/* END INLINED CODE */
	}
	;
	{
		/* INLINED CODE (ANY.do_nothing) */
		tr1 = RTOSCF(689,F45_689, (Current));
		(void) RTCW(tr1);
		/* END INLINED CODE */
	}
	;
	{
		/* INLINED CODE (ANY.do_nothing) */
		tr1 = RTOSCF(690,F45_690, (Current));
		(void) RTCW(tr1);
		/* END INLINED CODE */
	}
	;
	{
		/* INLINED CODE (ANY.do_nothing) */
		tr1 = RTOSCF(691,F45_691, (Current));
		(void) RTCW(tr1);
		/* END INLINED CODE */
	}
	;
	{
		/* INLINED CODE (ANY.do_nothing) */
		tr1 = RTOSCF(692,F45_692, (Current));
		(void) RTCW(tr1);
		/* END INLINED CODE */
	}
	;
	{
		/* INLINED CODE (ANY.do_nothing) */
		tr1 = RTOSCF(693,F45_693, (Current));
		(void) RTCW(tr1);
		/* END INLINED CODE */
	}
	;
	RTLE;
}

/* {ISE_EXCEPTION_MANAGER}.free_preallocated_trace */
void F45_698 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE loc1 = (EIF_REFERENCE) 0;
	RTLD;
	
	RTLI(2);
	RTLR(0,loc1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	loc1 = *(EIF_REFERENCE *)(RTCV(RTOSCF(693,F45_693, (Current))));
	if ((EIF_BOOLEAN)(loc1 != NULL)) {
		F78_1112(RTCW(loc1), NULL);
	}
	RTLE;
}

/* {ISE_EXCEPTION_MANAGER}.developer_raise */
void F45_699 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1, EIF_POINTER arg2, EIF_POINTER arg3)
{
	GTCX
	
	
	eif_builtin_ISE_EXCEPTION_MANAGER_developer_raise__i4_p_p_ (arg1, arg2, arg3);
}

/* {ISE_EXCEPTION_MANAGER}.in_rescue */
EIF_BOOLEAN F45_700 (EIF_REFERENCE Current)
{
	GTCX
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	
	Result = (EIF_BOOLEAN) EIF_TEST(eif_is_in_rescue());
	
	return Result;
}

void EIF_Minit32 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
