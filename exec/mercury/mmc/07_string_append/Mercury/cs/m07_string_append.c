/*
** Automatically generated from `07_string_append.m'
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


// :- module m07_string_append.
// :- implementation.

/*
INIT mercury__m07_string_append__init
ENDINIT
*/

#include "m07_string_append.mih"


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




static void MR_CALL 
m07_string_append__append_x_3_p_0(
  MR_Integer N_4,
  MR_String Text0_5,
  MR_String * Text_6);


static /* final */ const MR_Box m07_string_append_scalar_common_1[1][1];




static /* final */ const MR_Box m07_string_append_scalar_common_1[1][1] = {
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
    MR_String Text_5;
    MR_Integer SS_T1_6;
    MR_Integer SS_MS_7;
    MR_Integer Var_11;
    MR_String Var_12;
    MR_Integer Var_14;
    MR_Integer Var_15;
    MR_Integer Var_16;
    MR_Integer Var_17;
    MR_Word Var_18;
    MR_Integer Var_28;
    MR_String Var_31;
    MR_String Var_33;
    MR_Word Var_39;
    MR_String Var_40;
    MR_String Var_42;
    MR_Word Var_48;
    MR_String Var_49;

    mercury__time__clock_3_p_0(&SS_T0_4);
    Var_11 = (MR_Integer) 250000;
    Var_12 = (MR_String) "";
    m07_string_append__append_x_3_p_0(Var_11, Var_12, &Text_5);
    mercury__time__clock_3_p_0(&SS_T1_6);
    Var_15 = (MR_Integer) ((MR_Unsigned) SS_T1_6 - (MR_Unsigned) SS_T0_4);
    Var_16 = (MR_Integer) 1000;
    Var_14 = (MR_Integer) ((MR_Unsigned) Var_15 * (MR_Unsigned) Var_16);
    Var_17 = mercury__time__clocks_per_sec_0_f_0();
    SS_MS_7 = mercury__int__f_slash_2_f_0(Var_14, Var_17);
    Var_18 = mercury__io__stderr_stream_0_f_0();
    Var_31 = (MR_String) "TIME_MS=";
    mercury__io__write_string_4_p_0(Var_18, Var_31);
    Var_39 = (MR_Word) (&m07_string_append_scalar_common_1[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_39, SS_MS_7, &Var_33);
    mercury__io__write_string_4_p_0(Var_18, Var_33);
    Var_40 = (MR_String) "\n";
    mercury__io__write_string_4_p_0(Var_18, Var_40);
    Var_28 = mercury__string__length_1_f_0(Text_5);
    Var_48 = (MR_Word) (&m07_string_append_scalar_common_1[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_48, Var_28, &Var_42);
    mercury__io__write_string_3_p_0(Var_42);
    Var_49 = (MR_String) "\n";
    mercury__io__write_string_3_p_0(Var_49);
  }
}

static void MR_CALL 
m07_string_append__append_x_3_p_0(
  MR_Integer N_4,
  MR_String Text0_5,
  MR_String * Text_6)
{
  while (MR_TRUE)
  {
    MR_bool succeeded;
    MR_Integer Var_7 = (MR_Integer) 0;

    // setup for model_det tailcalls optimized into a loop
    ;
    succeeded = (N_4 <= Var_7);
    if (succeeded)
      *Text_6 = Text0_5;
    else
    {
      MR_Integer Var_8;
      MR_String Var_9;
      MR_Integer Var_10 = (MR_Integer) 1;
      MR_String Var_11;
      MR_Integer next_value_of_N_4;
      MR_String next_value_of_Text0_5;

      Var_8 = (MR_Integer) ((MR_Unsigned) N_4 - (MR_Unsigned) Var_10);
      Var_11 = (MR_String) "x";
      Var_9 = mercury__string__f_43_43_2_f_0(Text0_5, Var_11);
      // direct tailcall eliminated
      ;
      next_value_of_N_4 = Var_8;
      next_value_of_Text0_5 = Var_9;
      N_4 = next_value_of_N_4;
      Text0_5 = next_value_of_Text0_5;
      continue;
    }
    break;
  }
}

void mercury__m07_string_append__init(void)
{
}

void mercury__m07_string_append__init_type_tables(void)
{
}

void mercury__m07_string_append__init_debugger(void)
{
	MR_fatal_error("debugger initialization in MLDS grade");
}

// Ensure everything is compiled with the same grade.
const char *mercury__m07_string_append__grade_check(void)
{
    return &MR_GRADE_VAR;
}

// :- end_module m07_string_append.
