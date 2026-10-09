#include "eif_eiffel.h"
#include "eif_rout_obj.h"
#include "eaddress.h"
#include "eoffsets.h"

#ifdef __cplusplus
extern "C" {
#endif

	/* THREAD thr_get_terminated */
EIF_BOOLEAN A37_51 (EIF_REFERENCE Current)
{
	return (FUNCTION_CAST(EIF_BOOLEAN, (EIF_REFERENCE)) F56_800)(Current);
}

	/* THREAD thr_main */
void A37_50 (EIF_REFERENCE Current, EIF_INTEGER_32 arg1)
{
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_INTEGER_32)) F56_799)(Current, arg1);
}

	/* THREAD thr_set_terminated */
void A37_52 (EIF_REFERENCE Current, EIF_BOOLEAN arg1)
{
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_BOOLEAN)) F56_801)(Current, arg1);
}

	/* MISMATCH_INFORMATION wipe_out */
void A143_98 (EIF_REFERENCE Current)
{
	(FUNCTION_CAST(void, (EIF_REFERENCE)) F601_3034)(Current);
}

	/* MISMATCH_INFORMATION internal_put */
void A143_162 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_POINTER arg2)
{
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_REFERENCE, EIF_POINTER)) F607_3107)(Current, arg1, arg2);
}

	/* MISMATCH_INFORMATION set_string_versions */
void A143_163 (EIF_REFERENCE Current, EIF_POINTER arg1, EIF_POINTER arg2)
{
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_POINTER, EIF_POINTER)) F607_3108)(Current, arg1, arg2);
}


#ifdef __cplusplus
}
#endif
