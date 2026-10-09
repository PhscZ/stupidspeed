/*
** Automatically generated from `08_average.m'
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


// :- module m08_average.
// :- implementation.

/*
INIT mercury__m08_average__init
ENDINIT
*/

#include "m08_average.mih"


#include "array.mih"
#include "assoc_list.mih"
#include "bitmap.mih"
#include "bool.mih"
#include "builtin.mih"
#include "char.mih"
#include "construct.mih"
#include "deconstruct.mih"
#include "enum.mih"
#include "float.mih"
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
m08_average__loop_4_p_0(
  MR_Integer I_5,
  MR_Integer N_6,
  MR_Float STATE_VARIABLE_Total_0_8,
  MR_Float * STATE_VARIABLE_Total_9);


static /* final */ const MR_Box m08_average_scalar_common_1[1][1];




static /* final */ const MR_Box m08_average_scalar_common_1[1][1] = {
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
    MR_Float Total_5;
    MR_Float Avg_6;
    MR_Integer SS_T1_7;
    MR_Integer SS_MS_8;
    MR_Integer Var_12;
    MR_Integer Var_13;
    MR_Float Var_14;
    MR_Float Var_15;
    MR_Integer Var_17;
    MR_Integer Var_18;
    MR_Integer Var_19;
    MR_Integer Var_20;
    MR_Word Var_21;
    MR_String Var_33;
    MR_String Var_35;
    MR_Word Var_41;
    MR_String Var_42;
    MR_String Var_44;
    MR_Word Var_50;
    MR_Integer Var_51;
    MR_Word Var_52;
    MR_String Var_53;

    mercury__time__clock_3_p_0(&SS_T0_4);
    Var_12 = (MR_Integer) 0;
    Var_13 = (MR_Integer) 100000000;
    Var_14 = (MR_Float) 0.0000000000000000;
    m08_average__loop_4_p_0(Var_12, Var_13, Var_14, &Total_5);
    Var_15 = (MR_Float) 100000000.00000000;
    Avg_6 = mercury__float__f_slash_2_f_0(Total_5, Var_15);
    mercury__time__clock_3_p_0(&SS_T1_7);
    Var_18 = (MR_Integer) ((MR_Unsigned) SS_T1_7 - (MR_Unsigned) SS_T0_4);
    Var_19 = (MR_Integer) 1000;
    Var_17 = (MR_Integer) ((MR_Unsigned) Var_18 * (MR_Unsigned) Var_19);
    Var_20 = mercury__time__clocks_per_sec_0_f_0();
    SS_MS_8 = mercury__int__f_slash_2_f_0(Var_17, Var_20);
    Var_21 = mercury__io__stderr_stream_0_f_0();
    Var_33 = (MR_String) "TIME_MS=";
    mercury__io__write_string_4_p_0(Var_21, Var_33);
    Var_41 = (MR_Word) (&m08_average_scalar_common_1[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_41, SS_MS_8, &Var_35);
    mercury__io__write_string_4_p_0(Var_21, Var_35);
    Var_42 = (MR_String) "\n";
    mercury__io__write_string_4_p_0(Var_21, Var_42);
    Var_50 = (MR_Word) (&m08_average_scalar_common_1[0]);
    Var_51 = (MR_Integer) 9;
    Var_52 = (MR_Integer) 2;
    mercury__string__format__format_float_component_nowidth_prec_5_p_0(Var_50, Var_51, Var_52, Avg_6, &Var_44);
    mercury__io__write_string_3_p_0(Var_44);
    Var_53 = (MR_String) "\n";
    mercury__io__write_string_3_p_0(Var_53);
  }
}

static void MR_CALL 
m08_average__loop_4_p_0(
  MR_Integer I_5,
  MR_Integer N_6,
  MR_Float STATE_VARIABLE_Total_0_8,
  MR_Float * STATE_VARIABLE_Total_9)
{
  while (MR_TRUE)
  {
    MR_bool succeeded = (I_5 >= N_6);

    // setup for model_det tailcalls optimized into a loop
    ;
    if (succeeded)
      *STATE_VARIABLE_Total_9 = STATE_VARIABLE_Total_0_8;
    else
    {
      MR_Float STATE_VARIABLE_Total_10_10;
      MR_Float Var_11;
      MR_Float Var_12;
      MR_Integer Var_13;
      MR_Integer Var_14 = (MR_Integer) 256;
      MR_Float Var_15;
      MR_Integer Var_16;
      MR_Integer Var_18;
      MR_Integer next_value_of_I_5;
      MR_Float next_value_of_STATE_VARIABLE_Total_0_8;

      Var_13 = mercury__int__mod_2_f_0(I_5, Var_14);
      Var_12 = mercury__float__float_1_f_0(Var_13);
      Var_15 = (MR_Float) 256.00000000000000;
      Var_11 = mercury__float__f_slash_2_f_0(Var_12, Var_15);
      STATE_VARIABLE_Total_10_10 = (STATE_VARIABLE_Total_0_8 + Var_11);
      Var_18 = (MR_Integer) 1;
      Var_16 = (MR_Integer) ((MR_Unsigned) I_5 + (MR_Unsigned) Var_18);
      // direct tailcall eliminated
      ;
      next_value_of_I_5 = Var_16;
      next_value_of_STATE_VARIABLE_Total_0_8 = STATE_VARIABLE_Total_10_10;
      I_5 = next_value_of_I_5;
      STATE_VARIABLE_Total_0_8 = next_value_of_STATE_VARIABLE_Total_0_8;
      continue;
    }
    break;
  }
}

void mercury__m08_average__init(void)
{
}

void mercury__m08_average__init_type_tables(void)
{
}

void mercury__m08_average__init_debugger(void)
{
	MR_fatal_error("debugger initialization in MLDS grade");
}

// Ensure everything is compiled with the same grade.
const char *mercury__m08_average__grade_check(void)
{
    return &MR_GRADE_VAR;
}

// :- end_module m08_average.
