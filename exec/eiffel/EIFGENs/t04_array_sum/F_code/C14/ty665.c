/*
 * Code for class TYPE [TYPED_POINTER [INTEGER_8]]
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "ty665.h"
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

/* {TYPE}.name_32 */
EIF_REFERENCE F722_3338 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(3);
	RTLR(0,Current);
	RTLR(1,Result);
	RTLR(2,tr1);
	RTLIU(3);
	
	RTGC;
	Result = *(EIF_REFERENCE *)(Current);
	if ((EIF_BOOLEAN) !(EIF_BOOLEAN)(Result != NULL)) {
		Result = RTLNS(eif_new_type(814, 0x01).id, 814, _OBJSIZ_1_0_0_4_0_0_0_0_);
		tr1 = F722_3367(Current);
		F815_4784(RTCW(Result), tr1);
		RTAR(Current, Result);
		*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) Result;
	}
	RTLE;
	return Result;
}

/* {TYPE}.generic_parameter_type */
EIF_REFERENCE F722_3340 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	GTCX
	RTEX;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,Result);
	RTLR(1,Current);
	RTLIU(2);
	
	RTEAA("generic_parameter_type", 721, Current, 0, 1, 8942);
	Result = (EIF_REFERENCE) eif_builtin_TYPE_generic_parameter_type__i4_t (Current, arg1);
	if (!Result) {RTEC(EN_FAIL);}
	RTLE;
	RTEE;
	return Result;
}

/* {TYPE}.type_id */
EIF_INTEGER_32 F722_3341 (EIF_REFERENCE Current)
{
	GTCX
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	
	
	Result = (EIF_INTEGER_32) eif_builtin_TYPE_type_id__i4 (Current);
	return Result;
}

/* {TYPE}.hash_code */
EIF_INTEGER_32 F722_3342 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_INTEGER_32) (EIF_INTEGER_32) eif_builtin_TYPE_type_id__i4 (Current);
}

/* {TYPE}.is_attached */
EIF_BOOLEAN F722_3347 (EIF_REFERENCE Current)
{
	GTCX
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	
	
	Result = (EIF_BOOLEAN) eif_builtin_TYPE_is_attached__b (Current);
	return Result;
}

/* {TYPE}.is_equal */
EIF_BOOLEAN F722_3348 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_INTEGER_32 ti4_1;
	EIF_INTEGER_32 ti4_2;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,arg1);
	RTLIU(2);
	
	RTGC;
	ti4_1 = (EIF_INTEGER_32) eif_builtin_TYPE_type_id__i4 (Current);
	ti4_2 = (EIF_INTEGER_32) eif_builtin_TYPE_type_id__i4 (arg1);
	Result = (EIF_BOOLEAN) (EIF_BOOLEAN)(ti4_1 == ti4_2);
	RTLE;
	return Result;
}

/* {TYPE}.default */
EIF_INTEGER_8* F722_3355 (EIF_REFERENCE Current)
{
	GTCX
	EIF_INTEGER_8* loc1 = (EIF_INTEGER_8*) 0;
	
	
	RTGC;
	return (EIF_INTEGER_8*) 0;
}

/* {TYPE}.runtime_name */
EIF_REFERENCE F722_3367 (EIF_REFERENCE Current)
{
	GTCX
	RTEX;
	EIF_REFERENCE Result = ((EIF_REFERENCE) 0);
	
	RTLD;
	
	RTLI(2);
	RTLR(0,Result);
	RTLR(1,Current);
	RTLIU(2);
	
	RTEAA("runtime_name", 721, Current, 0, 0, 8969);
	Result = (EIF_REFERENCE) eif_builtin_TYPE_runtime_name__s1 (Current);
	if (!Result) {RTEC(EN_FAIL);}
	RTLE;
	RTEE;
	return Result;
}

void EIF_Minit665 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
