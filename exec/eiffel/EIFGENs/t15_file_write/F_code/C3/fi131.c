/*
 * Code for class FILE
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"
#include "../E1/eoffsets.h"

#include "fi131.h"
#include "eif_file.h"

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {FILE}.make_with_name */
void F489_2262 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_POINTER tp1;
	EIF_POINTER tp2;
	EIF_REFERENCE tr1 = NULL;
	RTCDT;
	RTLD;
	
	RTLI(3);
	RTLR(0,arg1);
	RTLR(1,Current);
	RTLR(2,tr1);
	RTLIU(3);
	
	RTGC;
	F489_2425(Current, arg1);
	*(EIF_INTEGER_32 *)(Current + O2116[dtype-488]) = (EIF_INTEGER_32) ((EIF_INTEGER_32) 0L);
	{
		/* INLINED CODE (ANY.default_pointer) */
		tp1 = (EIF_POINTER)  0;
		/* END INLINED CODE */
	}
	tp2 = tp1;
	*(EIF_POINTER *)(Current + O1977[dtype-488]) = (EIF_POINTER) tp2;
	tr1 = RTLNSMART(eif_new_type(782, 1).id);
	F775_4601(RTCW(tr1));
	RTAR(Current, tr1);
	*(EIF_REFERENCE *)(Current) = (EIF_REFERENCE) tr1;
	RTLE;
}

/* {FILE}.make_open_write */
void F489_2265 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	RTLD;
	
	RTLI(2);
	RTLR(0,arg1);
	RTLR(1,Current);
	RTLIU(2);
	
	RTGC;
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_REFERENCE)) R1964[Dtype(Current)-489])(Current, arg1);
	F489_2333(Current);
	RTLE;
}

/* {FILE}.descriptor_available */
EIF_BOOLEAN F489_2277 (EIF_REFERENCE Current)
{
	return *(EIF_BOOLEAN *)(Current + O2125[Dtype(Current)-488]);
}


/* {FILE}.count */
EIF_INTEGER_32 F489_2292 (EIF_REFERENCE Current)
{
	GTCX
	EIF_POINTER tp1;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTCDT;
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	if ((FUNCTION_CAST(EIF_BOOLEAN, (EIF_REFERENCE)) R1340[dtype-489])(Current)) {
		if ((EIF_BOOLEAN) !F489_2323(Current)) {
			F489_2433(Current);
			Result = F155_1896(RTCV(RTOSCF(2431,F489_2431, (Current))));
		} else {
			tp1 = *(EIF_POINTER *)(Current + O1977[dtype-488]);
			Result = (EIF_INTEGER_32) eif_file_size((FILE*) tp1);
			RTLE;
			return (EIF_INTEGER_32) Result;
		}
	}
	RTLE;
	return Result;
}

/* {FILE}.exists */
EIF_BOOLEAN F489_2297 (EIF_REFERENCE Current)
{
	GTCX
	EIF_POINTER tp1;
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	if (F489_2321(Current)) {
		tp1 = *(EIF_POINTER *)(RTCV(F489_2423(Current))+ _PTROFF_0_1_0_1_0_0_);
		Result = (EIF_BOOLEAN) EIF_TEST(eif_file_exists((EIF_FILENAME) tp1));
	} else {
		RTLE;
		return (EIF_BOOLEAN) (EIF_BOOLEAN) 1;
	}
	RTLE;
	return Result;
}

/* {FILE}.is_closed */
EIF_BOOLEAN F489_2321 (EIF_REFERENCE Current)
{
	GTCX
	
	
	return (EIF_BOOLEAN) (EIF_BOOLEAN)(*(EIF_INTEGER_32 *)(Current + O2116[Dtype(Current)-488]) == ((EIF_INTEGER_32) 0L));
}

/* {FILE}.is_open_write */
EIF_BOOLEAN F489_2323 (EIF_REFERENCE Current)
{
	GTCX
	RTCDT;
	
	
	return (EIF_BOOLEAN) (EIF_BOOLEAN) ((EIF_BOOLEAN) ((EIF_BOOLEAN) ((EIF_BOOLEAN)(*(EIF_INTEGER_32 *)(Current + O2116[dtype-488]) == ((EIF_INTEGER_32) 2L)) || (EIF_BOOLEAN)(*(EIF_INTEGER_32 *)(Current + O2116[dtype-488]) == ((EIF_INTEGER_32) 4L))) || (EIF_BOOLEAN)(*(EIF_INTEGER_32 *)(Current + O2116[dtype-488]) == ((EIF_INTEGER_32) 5L))) || (EIF_BOOLEAN)(*(EIF_INTEGER_32 *)(Current + O2116[dtype-488]) == ((EIF_INTEGER_32) 3L)));
}

/* {FILE}.open_write */
void F489_2333 (EIF_REFERENCE Current)
{
	GTCX
	EIF_POINTER tp1;
	RTCDT;
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	tp1 = *(EIF_POINTER *)(RTCV(F489_2423(Current))+ _PTROFF_0_1_0_1_0_0_);
	tp1 = (FUNCTION_CAST(EIF_POINTER, (EIF_REFERENCE, EIF_POINTER, EIF_INTEGER_32)) R2058[dtype-489])(Current, tp1, ((EIF_INTEGER_32) 1L));
	*(EIF_POINTER *)(Current + O1977[dtype-488]) = (EIF_POINTER) tp1;
	*(EIF_INTEGER_32 *)(Current + O2116[dtype-488]) = (EIF_INTEGER_32) ((EIF_INTEGER_32) 2L);
	RTLE;
}

/* {FILE}.close */
void F489_2349 (EIF_REFERENCE Current)
{
	GTCX
	EIF_POINTER tp1;
	EIF_POINTER tp2;
	RTCDT;
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	
	RTGC;
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_POINTER)) R2059[dtype-489])(Current, *(EIF_POINTER *)(Current + O1977[dtype-488]));
	*(EIF_INTEGER_32 *)(Current + O2116[dtype-488]) = (EIF_INTEGER_32) ((EIF_INTEGER_32) 0L);
	{
		/* INLINED CODE (ANY.default_pointer) */
		tp1 = (EIF_POINTER)  0;
		/* END INLINED CODE */
	}
	tp2 = tp1;
	*(EIF_POINTER *)(Current + O1977[dtype-488]) = (EIF_POINTER) tp2;
	*(EIF_BOOLEAN *)(Current + O2125[dtype-488]) = (EIF_BOOLEAN) (EIF_BOOLEAN) 0;
	RTLE;
}

/* {FILE}.flush */
void F489_2360 (EIF_REFERENCE Current)
{
	GTCX
	EIF_POINTER tp1;
	
	
	tp1 = *(EIF_POINTER *)(Current + O1977[Dtype(Current)-488]);
	eif_file_flush((FILE*) tp1);
}

/* {FILE}.put_managed_pointer */
void F489_2373 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_INTEGER_32 arg2, EIF_INTEGER_32 arg3)
{
	GTCX
	EIF_POINTER tp1;
	EIF_POINTER tp2;
	RTLD;
	
	RTLI(2);
	RTLR(0,Current);
	RTLR(1,arg1);
	RTLIU(2);
	
	RTGC;
	tp1 = *(EIF_POINTER *)(Current + O1977[Dtype(Current)-488]);
	tp2 = *(EIF_POINTER *)(RTCW(arg1)+ _PTROFF_0_1_0_1_0_0_);
	tp2 = RTPOF(tp2,arg2);
	eif_file_ps((FILE*) tp1, (char*) tp2, (EIF_INTEGER) arg3);
	RTLE;
}

/* {FILE}.file_open */
EIF_POINTER F489_2420 (EIF_REFERENCE Current, EIF_POINTER arg1, EIF_INTEGER_32 arg2)
{
	GTCX
	EIF_POINTER Result = ((EIF_POINTER) 0);
	
	
	Result = (EIF_POINTER) eif_file_open((EIF_FILENAME) arg1, (int) arg2);
	
	return Result;
}

/* {FILE}.file_close */
void F489_2421 (EIF_REFERENCE Current, EIF_POINTER arg1)
{
	GTCX
	
	eif_file_close((FILE*) arg1);
	
}

/* {FILE}.internal_name_pointer */
EIF_REFERENCE F489_2423 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE loc1 = (EIF_REFERENCE) 0;
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
	RTLI(3);
	RTLR(0,loc1);
	RTLR(1,Current);
	RTLR(2,tr1);
	RTLIU(3);
	
	RTGC;
	tr1 = *(EIF_REFERENCE *)(Current + _REFACS_2_);
	loc1 = tr1;
	if (EIF_TEST(loc1)) {
		RTLE;
		return (EIF_REFERENCE) loc1;
	} else {
		RTCT0("internal_name_pointer_set", EX_CHECK);
			RTCF0;
	}
	RTLE;
	return (EIF_REFERENCE) 0;
}

/* {FILE}.set_name */
void F489_2425 (EIF_REFERENCE Current, EIF_REFERENCE arg1)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	RTLD;
	
	RTLI(3);
	RTLR(0,Current);
	RTLR(1,arg1);
	RTLR(2,tr1);
	RTLIU(3);
	
	RTGC;
	RTAR(Current, arg1);
	*(EIF_REFERENCE *)(Current + _REFACS_1_) = (EIF_REFERENCE) arg1;
	tr1 = RTOSCF(2431,F489_2431, (Current));
	tr1 = F155_1909(RTCW(tr1), arg1, *(EIF_REFERENCE *)(Current + _REFACS_2_));
	RTAR(Current, tr1);
	*(EIF_REFERENCE *)(Current + _REFACS_2_) = (EIF_REFERENCE) tr1;
	RTLE;
}

/* {FILE}.buffered_file_info */
static EIF_REFERENCE F489_2431_body (EIF_REFERENCE Current)
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
	RTOSP (2431);
#define Result RTOSR(2431)
	RTOC_NEW(Result);
	tr1 = RTLNS(eif_new_type(154, 0x01).id, 154, _OBJSIZ_3_2_0_0_0_0_0_0_);
	F155_1892(RTCW(tr1));
	Result = (EIF_REFERENCE) tr1;
	RTOSE (2431);
	RTLE;
	RTEE;
	return Result;
#undef Result
}

EIF_REFERENCE F489_2431 (EIF_REFERENCE Current)
{
	GTCX
	return RTOSCF(2431,F489_2431_body,(Current));
}

/* {FILE}.set_buffer */
void F489_2433 (EIF_REFERENCE Current)
{
	GTCX
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE tr2 = NULL;
	EIF_REFERENCE tr3 = NULL;
	RTLD;
	
	RTLI(4);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLR(2,tr2);
	RTLR(3,tr3);
	RTLIU(4);
	
	RTGC;
	tr1 = RTOSCF(2431,F489_2431, (Current));
	tr2 = *(EIF_REFERENCE *)(Current + _REFACS_1_);
	tr3 = F489_2423(Current);
	F155_1939(RTCW(tr1), tr2, tr3);
	RTLE;
}

/* {FILE}.file_flush */
void F489_2438 (EIF_REFERENCE Current, EIF_POINTER arg1)
{
	GTCX
	
	eif_file_flush((FILE*) arg1);
	
}

/* {FILE}.file_size */
EIF_INTEGER_32 F489_2448 (EIF_REFERENCE Current, EIF_POINTER arg1)
{
	GTCX
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	
	Result = (EIF_INTEGER_32) eif_file_size((FILE*) arg1);
	
	return Result;
}

/* {FILE}.file_ps */
void F489_2460 (EIF_REFERENCE Current, EIF_POINTER arg1, EIF_POINTER arg2, EIF_INTEGER_32 arg3)
{
	GTCX
	
	
	EIF_ENTER_C;eif_file_ps((FILE*) arg1, (char*) arg2, (EIF_INTEGER) arg3);
	
	EIF_EXIT_C;
	RTGC;
}

/* {FILE}.file_exists */
EIF_BOOLEAN F489_2466 (EIF_REFERENCE Current, EIF_POINTER arg1)
{
	GTCX
	EIF_BOOLEAN Result = ((EIF_BOOLEAN) 0);
	
	
	Result = (EIF_BOOLEAN) EIF_TEST(eif_file_exists((EIF_FILENAME) arg1));
	
	return Result;
}

/* {FILE}.set_write_mode */
void F489_2489 (EIF_REFERENCE Current)
{
	GTCX
	
	
	*(EIF_INTEGER_32 *)(Current + O2116[Dtype(Current)-488]) = (EIF_INTEGER_32) ((EIF_INTEGER_32) 2L);
}

void EIF_Minit131 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif
