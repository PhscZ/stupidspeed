/*
** Automatically generated from `03_func_sum_add_one.m'
** by the Mercury compiler,
** version 22.01.9
** configured for x86_64-w64-mingw32.
** Do not edit.
**
** The autoconfigured grade settings governing
** the generation of this C file were
**
** TAG_BITS=2
** UNBOXED_FLOAT=no
** UNBOXED_INT64S=no
** PREGENERATED_DIST=yes
** HIGHLEVEL_CODE=yes
**
** END_OF_C_GRADE_INFO
*/


// :- module m03_func_sum_add_one.
// :- implementation.

/*
INIT mercury__m03_func_sum_add_one__init
ENDINIT
*/

#include "m03_func_sum_add_one.mih"


#include "array.mih"
#include "assoc_list.mih"
#include "builtin.mih"
#include "enum.mih"
#include "int.mih"
#include "list.mih"
#include "map.mih"
#include "maybe.mih"
#include "pair.mih"
#include "pretty_printer.mih"
#include "private_builtin.mih"
#include "term.mih"
#include "tree234.mih"
#include "type_desc.mih"
#include "univ.mih"










#include "array.mh"



MR_Integer MR_CALL 
m03_func_sum_add_one__add_one_1_f_0(
  MR_Integer N_3)
{
  {
    MR_Integer HeadVar__2_2;
    MR_Integer Var_4 = (MR_Integer) 1;

    HeadVar__2_2 = (MR_Integer) ((MR_Unsigned) N_3 + (MR_Unsigned) Var_4);
    return HeadVar__2_2;
  }
}

void mercury__m03_func_sum_add_one__init(void)
{
}

void mercury__m03_func_sum_add_one__init_type_tables(void)
{
}

void mercury__m03_func_sum_add_one__init_debugger(void)
{
	MR_fatal_error("debugger initialization in MLDS grade");
}

// Ensure everything is compiled with the same grade.
const char *mercury__m03_func_sum_add_one__grade_check(void)
{
    return &MR_GRADE_VAR;
}

// :- end_module m03_func_sum_add_one.
