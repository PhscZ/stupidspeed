/*
** Automatically generated from `03_func_sum.m'
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


// :- module m03_func_sum.
// :- implementation.

/*
INIT mercury__m03_func_sum__init
ENDINIT
*/

#include "m03_func_sum.mih"


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
m03_func_sum__loop_4_p_0(
  MR_Integer I_5,
  MR_Integer N_6,
  MR_Integer STATE_VARIABLE_Value_0_8,
  MR_Integer * STATE_VARIABLE_Value_9);

static MR_Integer MR_CALL 
m03_func_sum__add_one_1_f_0(
  MR_Integer N_3);


static /* final */ const MR_Box m03_func_sum_scalar_common_1[1][1];




static /* final */ const MR_Box m03_func_sum_scalar_common_1[1][1] = {
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
    MR_Integer Value_5;
    MR_Integer SS_T1_6;
    MR_Integer SS_MS_7;
    MR_Integer Var_11;
    MR_Integer Var_12;
    MR_Integer Var_13;
    MR_Integer Var_15;
    MR_Integer Var_16;
    MR_Integer Var_17;
    MR_Integer Var_18;
    MR_Word Var_19;
    MR_String Var_31;
    MR_String Var_33;
    MR_Word Var_39;
    MR_String Var_40;
    MR_String Var_42;
    MR_Word Var_48;
    MR_String Var_49;

    mercury__time__clock_3_p_0(&SS_T0_4);
    Var_11 = (MR_Integer) 0;
    Var_12 = (MR_Integer) 100000000;
    Var_13 = (MR_Integer) 0;
    m03_func_sum__loop_4_p_0(Var_11, Var_12, Var_13, &Value_5);
    mercury__time__clock_3_p_0(&SS_T1_6);
    Var_16 = (MR_Integer) ((MR_Unsigned) SS_T1_6 - (MR_Unsigned) SS_T0_4);
    Var_17 = (MR_Integer) 1000;
    Var_15 = (MR_Integer) ((MR_Unsigned) Var_16 * (MR_Unsigned) Var_17);
    Var_18 = mercury__time__clocks_per_sec_0_f_0();
    SS_MS_7 = mercury__int__f_slash_2_f_0(Var_15, Var_18);
    Var_19 = mercury__io__stderr_stream_0_f_0();
    Var_31 = (MR_String) "TIME_MS=";
    mercury__io__write_string_4_p_0(Var_19, Var_31);
    Var_39 = (MR_Word) (&m03_func_sum_scalar_common_1[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_39, SS_MS_7, &Var_33);
    mercury__io__write_string_4_p_0(Var_19, Var_33);
    Var_40 = (MR_String) "\n";
    mercury__io__write_string_4_p_0(Var_19, Var_40);
    Var_48 = (MR_Word) (&m03_func_sum_scalar_common_1[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_48, Value_5, &Var_42);
    mercury__io__write_string_3_p_0(Var_42);
    Var_49 = (MR_String) "\n";
    mercury__io__write_string_3_p_0(Var_49);
  }
}

static void MR_CALL 
m03_func_sum__loop_4_p_0(
  MR_Integer I_5,
  MR_Integer N_6,
  MR_Integer STATE_VARIABLE_Value_0_8,
  MR_Integer * STATE_VARIABLE_Value_9)
{
  while (MR_TRUE)
  {
    MR_bool succeeded = (I_5 >= N_6);

    // setup for model_det tailcalls optimized into a loop
    ;
    if (succeeded)
      *STATE_VARIABLE_Value_9 = STATE_VARIABLE_Value_0_8;
    else
    {
      MR_Integer STATE_VARIABLE_Value_10_10;
      MR_Integer Var_11;
      MR_Integer Var_13;
      MR_Integer next_value_of_I_5;
      MR_Integer next_value_of_STATE_VARIABLE_Value_0_8;

      STATE_VARIABLE_Value_10_10 = m03_func_sum__add_one_1_f_0(STATE_VARIABLE_Value_0_8);
      Var_13 = (MR_Integer) 1;
      Var_11 = (MR_Integer) ((MR_Unsigned) I_5 + (MR_Unsigned) Var_13);
      // direct tailcall eliminated
      ;
      next_value_of_I_5 = Var_11;
      next_value_of_STATE_VARIABLE_Value_0_8 = STATE_VARIABLE_Value_10_10;
      I_5 = next_value_of_I_5;
      STATE_VARIABLE_Value_0_8 = next_value_of_STATE_VARIABLE_Value_0_8;
      continue;
    }
    break;
  }
}

static MR_Integer MR_CALL 
m03_func_sum__add_one_1_f_0(
  MR_Integer N_3)
{
  {
    MR_Integer HeadVar__2_2;
    MR_Integer Var_4 = (MR_Integer) 1;

    HeadVar__2_2 = (MR_Integer) ((MR_Unsigned) N_3 + (MR_Unsigned) Var_4);
    return HeadVar__2_2;
  }
}

void mercury__m03_func_sum__init(void)
{
}

void mercury__m03_func_sum__init_type_tables(void)
{
}

void mercury__m03_func_sum__init_debugger(void)
{
	MR_fatal_error("debugger initialization in MLDS grade");
}

// Ensure everything is compiled with the same grade.
const char *mercury__m03_func_sum__grade_check(void)
{
    return &MR_GRADE_VAR;
}

// :- end_module m03_func_sum.
