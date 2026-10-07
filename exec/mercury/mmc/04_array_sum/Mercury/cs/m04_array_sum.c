/*
** Automatically generated from `04_array_sum.m'
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


// :- module m04_array_sum.
// :- implementation.

/*
INIT mercury__m04_array_sum__init
ENDINIT
*/

#include "m04_array_sum.mih"


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
#include "random.mih"
#include "stream.mih"
#include "string.mih"
#include "term.mih"
#include "time.mih"
#include "tree234.mih"
#include "type_desc.mih"
#include "univ.mih"
#include "string.format.mih"
#include "string.parse_util.mih"




static MR_Box MR_CALL 
main_2_p_0_1(
  MR_Box closure_arg,
  MR_Box wrapper_arg_1,
  MR_Box wrapper_arg_2);

static void MR_CALL 
m04_array_sum__fill_4_p_0(
  MR_Integer I_5,
  MR_Integer N_6,
  MR_ArrayPtr STATE_VARIABLE_A_0_8,
  MR_ArrayPtr * STATE_VARIABLE_A_9);


static /* final */ const MR_Box m04_array_sum_scalar_common_1[1][1];

static /* final */ const MR_Box m04_array_sum_scalar_common_2[1][6];

static /* final */ const MR_Box m04_array_sum_scalar_common_3[1][3];




static /* final */ const MR_Box m04_array_sum_scalar_common_1[1][1] = {
  /* row 0 */
  {
    (MR_Box) (((((MR_Unsigned) 0U << 4)) | (((((MR_Unsigned) 0U << 3)) | (((((MR_Unsigned) 0U << 2)) | (((MR_Unsigned) 0U << 1))))))))
  },
};

static /* final */ const MR_Box m04_array_sum_scalar_common_2[1][6] = {
  /* row 0 */
  {
    NULL,
    ((MR_Box) (NULL)),
    ((MR_Box) ((MR_Integer) 3)),
    ((MR_Box) (&mercury__builtin__builtin__type_ctor_info_int_0)),
    ((MR_Box) (&mercury__builtin__builtin__type_ctor_info_int_0)),
    ((MR_Box) (&mercury__builtin__builtin__type_ctor_info_int_0))
  },
};

static /* final */ const MR_Box m04_array_sum_scalar_common_3[1][3] = {
  /* row 0 */
  {
    ((MR_Box) (&m04_array_sum_scalar_common_2[0])),
    ((MR_Box) (main_2_p_0_1)),
    ((MR_Box) ((MR_Integer) 0))
  },
};



#include "array.mh"
#include "bitmap.mh"
#include "io.mh"
#include "string.mh"
#include "time.mh"



static MR_Box MR_CALL 
main_2_p_0_1(
  MR_Box closure_arg,
  MR_Box wrapper_arg_1,
  MR_Box wrapper_arg_2)
{
  {
    MR_Box wrapper_arg_3;
    MR_Box closure = closure_arg;
    MR_Integer conv1_HeadVar__3_3;

    conv1_HeadVar__3_3 = mercury__int__f_plus_2_f_0(((MR_Integer) (wrapper_arg_1)), ((MR_Integer) (wrapper_arg_2)));
    wrapper_arg_3 = ((MR_Box) (conv1_HeadVar__3_3));
    return wrapper_arg_3;
  }
}

void MR_CALL 
main_2_p_0(void)
{
  {
    MR_Word TypeCtorInfo_41_41;
    MR_Integer SS_T0_4;
    MR_Integer N_5;
    MR_ArrayPtr A0_6;
    MR_ArrayPtr A_7;
    MR_Integer Total_8;
    MR_Integer SS_T1_11;
    MR_Integer SS_MS_12;
    MR_Integer Var_16;
    MR_Integer Var_17;
    MR_Word Var_18;
    MR_Integer Var_22;
    MR_Integer Var_24;
    MR_Integer Var_25;
    MR_Integer Var_26;
    MR_Integer Var_27;
    MR_Word Var_28;
    MR_String Var_43;
    MR_String Var_45;
    MR_Word Var_51;
    MR_String Var_52;
    MR_String Var_54;
    MR_Word Var_60;
    MR_String Var_61;
    MR_ArrayPtr conv0_A0_6;
    MR_Box conv2_Total_8;

    mercury__time__clock_3_p_0(&SS_T0_4);
    N_5 = (MR_Integer) 1000000;
    TypeCtorInfo_41_41 = (MR_Word) (&mercury__builtin__builtin__type_ctor_info_int_0);
    Var_16 = (MR_Integer) 0;
    conv0_A0_6 = mercury__array__init_2_f_0(TypeCtorInfo_41_41, N_5, ((MR_Box) (Var_16)));
    A0_6 = (MR_ArrayPtr) (conv0_A0_6);
    Var_17 = (MR_Integer) 0;
    m04_array_sum__fill_4_p_0(Var_17, N_5, A0_6, &A_7);
    Var_18 = (MR_Word) (&m04_array_sum_scalar_common_3[0]);
    Var_22 = (MR_Integer) 0;
    conv2_Total_8 = mercury__array__foldl_3_f_0(TypeCtorInfo_41_41, TypeCtorInfo_41_41, Var_18, (MR_ArrayPtr) (A_7), ((MR_Box) (Var_22)));
    Total_8 = ((MR_Integer) (conv2_Total_8));
    mercury__time__clock_3_p_0(&SS_T1_11);
    Var_25 = (MR_Integer) ((MR_Unsigned) SS_T1_11 - (MR_Unsigned) SS_T0_4);
    Var_26 = (MR_Integer) 1000;
    Var_24 = (MR_Integer) ((MR_Unsigned) Var_25 * (MR_Unsigned) Var_26);
    Var_27 = mercury__time__clocks_per_sec_0_f_0();
    SS_MS_12 = mercury__int__f_slash_2_f_0(Var_24, Var_27);
    Var_28 = mercury__io__stderr_stream_0_f_0();
    Var_43 = (MR_String) "TIME_MS=";
    mercury__io__write_string_4_p_0(Var_28, Var_43);
    Var_51 = (MR_Word) (&m04_array_sum_scalar_common_1[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_51, SS_MS_12, &Var_45);
    mercury__io__write_string_4_p_0(Var_28, Var_45);
    Var_52 = (MR_String) "\n";
    mercury__io__write_string_4_p_0(Var_28, Var_52);
    Var_60 = (MR_Word) (&m04_array_sum_scalar_common_1[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_60, Total_8, &Var_54);
    mercury__io__write_string_3_p_0(Var_54);
    Var_61 = (MR_String) "\n";
    mercury__io__write_string_3_p_0(Var_61);
  }
}

static void MR_CALL 
m04_array_sum__fill_4_p_0(
  MR_Integer I_5,
  MR_Integer N_6,
  MR_ArrayPtr STATE_VARIABLE_A_0_8,
  MR_ArrayPtr * STATE_VARIABLE_A_9)
{
  while (MR_TRUE)
  {
    MR_bool succeeded = (I_5 >= N_6);

    // setup for model_det tailcalls optimized into a loop
    ;
    if (succeeded)
      *STATE_VARIABLE_A_9 = STATE_VARIABLE_A_0_8;
    else
    {
      MR_Word TypeCtorInfo_15_15 = (MR_Word) (&mercury__builtin__builtin__type_ctor_info_int_0);
      MR_ArrayPtr STATE_VARIABLE_A_11_11;
      MR_Integer Var_12;
      MR_Integer Var_14;
      MR_ArrayPtr conv0_STATE_VARIABLE_A_11_11;
      MR_Integer next_value_of_I_5;
      MR_ArrayPtr next_value_of_STATE_VARIABLE_A_0_8;

      mercury__array__set_4_p_0(TypeCtorInfo_15_15, I_5, ((MR_Box) (I_5)), (MR_ArrayPtr) (STATE_VARIABLE_A_0_8), &conv0_STATE_VARIABLE_A_11_11);
      STATE_VARIABLE_A_11_11 = (MR_ArrayPtr) (conv0_STATE_VARIABLE_A_11_11);
      Var_14 = (MR_Integer) 1;
      Var_12 = (MR_Integer) ((MR_Unsigned) I_5 + (MR_Unsigned) Var_14);
      // direct tailcall eliminated
      ;
      next_value_of_I_5 = Var_12;
      next_value_of_STATE_VARIABLE_A_0_8 = STATE_VARIABLE_A_11_11;
      I_5 = next_value_of_I_5;
      STATE_VARIABLE_A_0_8 = next_value_of_STATE_VARIABLE_A_0_8;
      continue;
    }
    break;
  }
}

void mercury__m04_array_sum__init(void)
{
}

void mercury__m04_array_sum__init_type_tables(void)
{
}

void mercury__m04_array_sum__init_debugger(void)
{
	MR_fatal_error("debugger initialization in MLDS grade");
}

// Ensure everything is compiled with the same grade.
const char *mercury__m04_array_sum__grade_check(void)
{
    return &MR_GRADE_VAR;
}

// :- end_module m04_array_sum.
