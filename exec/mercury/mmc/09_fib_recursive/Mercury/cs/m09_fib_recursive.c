/*
** Automatically generated from `09_fib_recursive.m'
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


// :- module m09_fib_recursive.
// :- implementation.

/*
INIT mercury__m09_fib_recursive__init
ENDINIT
*/

#include "m09_fib_recursive.mih"


#include "array.mih"
#include "assoc_list.mih"
#include "bitmap.mih"
#include "bool.mih"
#include "builtin.mih"
#include "char.mih"
#include "construct.mih"
#include "deconstruct.mih"
#include "enum.mih"
#include "int.mih"
#include "io.mih"
#include "list.mih"
#include "map.mih"
#include "maybe.mih"
#include "ops.mih"
#include "pair.mih"
#include "pretty_printer.mih"
#include "private_builtin.mih"
#include "stream.mih"
#include "string.mih"
#include "term.mih"
#include "time.mih"
#include "tree234.mih"
#include "type_desc.mih"
#include "univ.mih"
#include "string.format.mih"
#include "string.parse_util.mih"




static MR_Integer MR_CALL 
m09_fib_recursive__fib_1_f_0(
  MR_Integer N_3);


static /* final */ const MR_Box m09_fib_recursive_scalar_common_1[1][1];




static /* final */ const MR_Box m09_fib_recursive_scalar_common_1[1][1] = {
  /* row 0 */
  {
    (MR_Box) (((((MR_Unsigned) 0U << 4)) | (((((MR_Unsigned) 0U << 3)) | (((((MR_Unsigned) 0U << 2)) | (((MR_Unsigned) 0U << 1))))))))
  },
};



#include "array.mh"
#include "bitmap.mh"
#include "io.mh"
#include "string.mh"
#include "time.mh"



void MR_CALL 
main_2_p_0(void)
{
  {
    MR_Integer SS_T0_4;
    MR_Integer SS_R_5;
    MR_Integer SS_T1_6;
    MR_Integer SS_MS_7;
    MR_Integer Var_11;
    MR_Integer Var_13;
    MR_Integer Var_14;
    MR_Integer Var_15;
    MR_Integer Var_16;
    MR_Word Var_17;
    MR_String Var_29;
    MR_String Var_31;
    MR_Word Var_37;
    MR_String Var_38;
    MR_String Var_40;
    MR_Word Var_46;
    MR_String Var_47;

    mercury__time__clock_3_p_0(&SS_T0_4);
    Var_11 = (MR_Integer) 40;
    SS_R_5 = m09_fib_recursive__fib_1_f_0(Var_11);
    mercury__time__clock_3_p_0(&SS_T1_6);
    Var_14 = (MR_Integer) ((MR_Unsigned) SS_T1_6 - (MR_Unsigned) SS_T0_4);
    Var_15 = (MR_Integer) 1000;
    Var_13 = (MR_Integer) ((MR_Unsigned) Var_14 * (MR_Unsigned) Var_15);
    Var_16 = mercury__time__clocks_per_sec_0_f_0();
    SS_MS_7 = mercury__int__f_slash_2_f_0(Var_13, Var_16);
    Var_17 = mercury__io__stderr_stream_0_f_0();
    Var_29 = (MR_String) "TIME_MS=";
    mercury__io__write_string_4_p_0(Var_17, Var_29);
    Var_37 = (MR_Word) (&m09_fib_recursive_scalar_common_1[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_37, SS_MS_7, &Var_31);
    mercury__io__write_string_4_p_0(Var_17, Var_31);
    Var_38 = (MR_String) "\n";
    mercury__io__write_string_4_p_0(Var_17, Var_38);
    Var_46 = (MR_Word) (&m09_fib_recursive_scalar_common_1[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_46, SS_R_5, &Var_40);
    mercury__io__write_string_3_p_0(Var_40);
    Var_47 = (MR_String) "\n";
    mercury__io__write_string_3_p_0(Var_47);
  }
}

static MR_Integer MR_CALL 
m09_fib_recursive__fib_1_f_0(
  MR_Integer N_3)
{
  {
    MR_bool succeeded;
    MR_Integer HeadVar__2_2;
    MR_Integer Var_4 = (MR_Integer) 2;

    succeeded = (N_3 < Var_4);
    if (succeeded)
      HeadVar__2_2 = N_3;
    else
    {
      MR_Integer Var_5;
      MR_Integer Var_6;
      MR_Integer Var_7 = (MR_Integer) 1;
      MR_Integer Var_8;
      MR_Integer Var_9;
      MR_Integer Var_10;

      Var_6 = (MR_Integer) ((MR_Unsigned) N_3 - (MR_Unsigned) Var_7);
      Var_5 = m09_fib_recursive__fib_1_f_0(Var_6);
      Var_10 = (MR_Integer) 2;
      Var_9 = (MR_Integer) ((MR_Unsigned) N_3 - (MR_Unsigned) Var_10);
      Var_8 = m09_fib_recursive__fib_1_f_0(Var_9);
      HeadVar__2_2 = (MR_Integer) ((MR_Unsigned) Var_5 + (MR_Unsigned) Var_8);
    }
    return HeadVar__2_2;
  }
}

void mercury__m09_fib_recursive__init(void)
{
}

void mercury__m09_fib_recursive__init_type_tables(void)
{
}

void mercury__m09_fib_recursive__init_debugger(void)
{
	MR_fatal_error("debugger initialization in MLDS grade");
}

// Ensure everything is compiled with the same grade.
const char *mercury__m09_fib_recursive__grade_check(void)
{
    return &MR_GRADE_VAR;
}

// :- end_module m09_fib_recursive.
