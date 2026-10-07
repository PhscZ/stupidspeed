/*
** Automatically generated from `12_matrix_add.m'
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


// :- module m12_matrix_add.
// :- implementation.

/*
INIT mercury__m12_matrix_add__init
ENDINIT
*/

#include "m12_matrix_add.mih"


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
m12_matrix_add__add_ab_6_p_0(
  MR_Integer I_7,
  MR_Integer N_8,
  MR_ArrayPtr A_9,
  MR_ArrayPtr B_10,
  MR_ArrayPtr STATE_VARIABLE_C_0_12,
  MR_ArrayPtr * STATE_VARIABLE_C_13);

static void MR_CALL 
m12_matrix_add__add_row_7_p_0(
  MR_Integer J_8,
  MR_Integer I_9,
  MR_Integer N_10,
  MR_ArrayPtr A_11,
  MR_ArrayPtr B_12,
  MR_ArrayPtr STATE_VARIABLE_C_0_15,
  MR_ArrayPtr * STATE_VARIABLE_C_16);

static void MR_CALL 
m12_matrix_add__fill_ab_6_p_0(
  MR_Integer I_7,
  MR_Integer N_8,
  MR_ArrayPtr STATE_VARIABLE_A_0_11,
  MR_ArrayPtr * STATE_VARIABLE_A_12,
  MR_ArrayPtr STATE_VARIABLE_B_0_13,
  MR_ArrayPtr * STATE_VARIABLE_B_14);

static void MR_CALL 
m12_matrix_add__fill_row_7_p_0(
  MR_Integer J_8,
  MR_Integer I_9,
  MR_Integer N_10,
  MR_ArrayPtr STATE_VARIABLE_A_0_14,
  MR_ArrayPtr * STATE_VARIABLE_A_15,
  MR_ArrayPtr STATE_VARIABLE_B_0_16,
  MR_ArrayPtr * STATE_VARIABLE_B_17);


static /* final */ const MR_Box m12_matrix_add_scalar_common_1[1][1];

static /* final */ const MR_Box m12_matrix_add_scalar_common_2[1][6];

static /* final */ const MR_Box m12_matrix_add_scalar_common_3[1][3];




static /* final */ const MR_Box m12_matrix_add_scalar_common_1[1][1] = {
  /* row 0 */
  {
    (MR_Box) (((((MR_Unsigned) 0U << 4)) | (((((MR_Unsigned) 0U << 3)) | (((((MR_Unsigned) 0U << 2)) | (((MR_Unsigned) 0U << 1))))))))
  },
};

static /* final */ const MR_Box m12_matrix_add_scalar_common_2[1][6] = {
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

static /* final */ const MR_Box m12_matrix_add_scalar_common_3[1][3] = {
  /* row 0 */
  {
    ((MR_Box) (&m12_matrix_add_scalar_common_2[0])),
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
    MR_Integer conv3_HeadVar__3_3;

    conv3_HeadVar__3_3 = mercury__int__f_plus_2_f_0(((MR_Integer) (wrapper_arg_1)), ((MR_Integer) (wrapper_arg_2)));
    wrapper_arg_3 = ((MR_Box) (conv3_HeadVar__3_3));
    return wrapper_arg_3;
  }
}

void MR_CALL 
main_2_p_0(void)
{
  {
    MR_Word TypeCtorInfo_50_50;
    MR_Integer SS_T0_4;
    MR_Integer N_5;
    MR_Integer E_6;
    MR_ArrayPtr A0_7;
    MR_ArrayPtr B0_8;
    MR_ArrayPtr C0_9;
    MR_ArrayPtr A_10;
    MR_ArrayPtr B_11;
    MR_ArrayPtr C_12;
    MR_Integer Total_13;
    MR_Integer SS_T1_16;
    MR_Integer SS_MS_17;
    MR_Integer Var_22;
    MR_Integer Var_23;
    MR_Integer Var_24;
    MR_Integer Var_25;
    MR_Integer Var_26;
    MR_Word Var_27;
    MR_Integer Var_31;
    MR_Integer Var_33;
    MR_Integer Var_34;
    MR_Integer Var_35;
    MR_Integer Var_36;
    MR_Word Var_37;
    MR_String Var_52;
    MR_String Var_54;
    MR_Word Var_60;
    MR_String Var_61;
    MR_String Var_63;
    MR_Word Var_69;
    MR_String Var_70;
    MR_ArrayPtr conv0_A0_7;
    MR_ArrayPtr conv1_B0_8;
    MR_ArrayPtr conv2_C0_9;
    MR_Box conv4_Total_13;

    mercury__time__clock_3_p_0(&SS_T0_4);
    N_5 = (MR_Integer) 1000;
    E_6 = (MR_Integer) ((MR_Unsigned) N_5 * (MR_Unsigned) N_5);
    TypeCtorInfo_50_50 = (MR_Word) (&mercury__builtin__builtin__type_ctor_info_int_0);
    Var_22 = (MR_Integer) 0;
    conv0_A0_7 = mercury__array__init_2_f_0(TypeCtorInfo_50_50, E_6, ((MR_Box) (Var_22)));
    A0_7 = (MR_ArrayPtr) (conv0_A0_7);
    Var_23 = (MR_Integer) 0;
    conv1_B0_8 = mercury__array__init_2_f_0(TypeCtorInfo_50_50, E_6, ((MR_Box) (Var_23)));
    B0_8 = (MR_ArrayPtr) (conv1_B0_8);
    Var_24 = (MR_Integer) 0;
    conv2_C0_9 = mercury__array__init_2_f_0(TypeCtorInfo_50_50, E_6, ((MR_Box) (Var_24)));
    C0_9 = (MR_ArrayPtr) (conv2_C0_9);
    Var_25 = (MR_Integer) 0;
    m12_matrix_add__fill_ab_6_p_0(Var_25, N_5, A0_7, &A_10, B0_8, &B_11);
    Var_26 = (MR_Integer) 0;
    m12_matrix_add__add_ab_6_p_0(Var_26, N_5, A_10, B_11, C0_9, &C_12);
    Var_27 = (MR_Word) (&m12_matrix_add_scalar_common_3[0]);
    Var_31 = (MR_Integer) 0;
    conv4_Total_13 = mercury__array__foldl_3_f_0(TypeCtorInfo_50_50, TypeCtorInfo_50_50, Var_27, (MR_ArrayPtr) (C_12), ((MR_Box) (Var_31)));
    Total_13 = ((MR_Integer) (conv4_Total_13));
    mercury__time__clock_3_p_0(&SS_T1_16);
    Var_34 = (MR_Integer) ((MR_Unsigned) SS_T1_16 - (MR_Unsigned) SS_T0_4);
    Var_35 = (MR_Integer) 1000;
    Var_33 = (MR_Integer) ((MR_Unsigned) Var_34 * (MR_Unsigned) Var_35);
    Var_36 = mercury__time__clocks_per_sec_0_f_0();
    SS_MS_17 = mercury__int__f_slash_2_f_0(Var_33, Var_36);
    Var_37 = mercury__io__stderr_stream_0_f_0();
    Var_52 = (MR_String) "TIME_MS=";
    mercury__io__write_string_4_p_0(Var_37, Var_52);
    Var_60 = (MR_Word) (&m12_matrix_add_scalar_common_1[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_60, SS_MS_17, &Var_54);
    mercury__io__write_string_4_p_0(Var_37, Var_54);
    Var_61 = (MR_String) "\n";
    mercury__io__write_string_4_p_0(Var_37, Var_61);
    Var_69 = (MR_Word) (&m12_matrix_add_scalar_common_1[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_69, Total_13, &Var_63);
    mercury__io__write_string_3_p_0(Var_63);
    Var_70 = (MR_String) "\n";
    mercury__io__write_string_3_p_0(Var_70);
  }
}

static void MR_CALL 
m12_matrix_add__add_ab_6_p_0(
  MR_Integer I_7,
  MR_Integer N_8,
  MR_ArrayPtr A_9,
  MR_ArrayPtr B_10,
  MR_ArrayPtr STATE_VARIABLE_C_0_12,
  MR_ArrayPtr * STATE_VARIABLE_C_13)
{
  while (MR_TRUE)
  {
    MR_bool succeeded = (I_7 >= N_8);

    // setup for model_det tailcalls optimized into a loop
    ;
    if (succeeded)
      *STATE_VARIABLE_C_13 = STATE_VARIABLE_C_0_12;
    else
    {
      MR_Integer Var_14 = (MR_Integer) 0;
      MR_ArrayPtr STATE_VARIABLE_C_15_15;
      MR_Integer Var_16;
      MR_Integer Var_18;
      MR_Integer next_value_of_I_7;
      MR_ArrayPtr next_value_of_STATE_VARIABLE_C_0_12;

      m12_matrix_add__add_row_7_p_0(Var_14, I_7, N_8, A_9, B_10, STATE_VARIABLE_C_0_12, &STATE_VARIABLE_C_15_15);
      Var_18 = (MR_Integer) 1;
      Var_16 = (MR_Integer) ((MR_Unsigned) I_7 + (MR_Unsigned) Var_18);
      // direct tailcall eliminated
      ;
      next_value_of_I_7 = Var_16;
      next_value_of_STATE_VARIABLE_C_0_12 = STATE_VARIABLE_C_15_15;
      I_7 = next_value_of_I_7;
      STATE_VARIABLE_C_0_12 = next_value_of_STATE_VARIABLE_C_0_12;
      continue;
    }
    break;
  }
}

static void MR_CALL 
m12_matrix_add__add_row_7_p_0(
  MR_Integer J_8,
  MR_Integer I_9,
  MR_Integer N_10,
  MR_ArrayPtr A_11,
  MR_ArrayPtr B_12,
  MR_ArrayPtr STATE_VARIABLE_C_0_15,
  MR_ArrayPtr * STATE_VARIABLE_C_16)
{
  while (MR_TRUE)
  {
    MR_bool succeeded = (J_8 >= N_10);

    // setup for model_det tailcalls optimized into a loop
    ;
    if (succeeded)
      *STATE_VARIABLE_C_16 = STATE_VARIABLE_C_0_15;
    else
    {
      MR_Word TypeCtorInfo_25_25;
      MR_Integer Idx_14;
      MR_Integer Var_17 = (MR_Integer) ((MR_Unsigned) I_9 * (MR_Unsigned) N_10);
      MR_Integer Var_18;
      MR_ArrayPtr STATE_VARIABLE_C_19_19;
      MR_Integer Var_20;
      MR_Integer Var_21;
      MR_Integer Var_22;
      MR_Integer Var_24;
      MR_Box conv0_Var_20;
      MR_Box conv1_Var_21;
      MR_ArrayPtr conv2_STATE_VARIABLE_C_19_19;
      MR_Integer next_value_of_J_8;
      MR_ArrayPtr next_value_of_STATE_VARIABLE_C_0_15;

      Idx_14 = (MR_Integer) ((MR_Unsigned) Var_17 + (MR_Unsigned) J_8);
      TypeCtorInfo_25_25 = (MR_Word) (&mercury__builtin__builtin__type_ctor_info_int_0);
      conv0_Var_20 = mercury__array__lookup_2_f_0(TypeCtorInfo_25_25, (MR_ArrayPtr) (A_11), Idx_14);
      Var_20 = ((MR_Integer) (conv0_Var_20));
      conv1_Var_21 = mercury__array__lookup_2_f_0(TypeCtorInfo_25_25, (MR_ArrayPtr) (B_12), Idx_14);
      Var_21 = ((MR_Integer) (conv1_Var_21));
      Var_18 = (MR_Integer) ((MR_Unsigned) Var_20 + (MR_Unsigned) Var_21);
      mercury__array__set_4_p_0(TypeCtorInfo_25_25, Idx_14, ((MR_Box) (Var_18)), (MR_ArrayPtr) (STATE_VARIABLE_C_0_15), &conv2_STATE_VARIABLE_C_19_19);
      STATE_VARIABLE_C_19_19 = (MR_ArrayPtr) (conv2_STATE_VARIABLE_C_19_19);
      Var_24 = (MR_Integer) 1;
      Var_22 = (MR_Integer) ((MR_Unsigned) J_8 + (MR_Unsigned) Var_24);
      // direct tailcall eliminated
      ;
      next_value_of_J_8 = Var_22;
      next_value_of_STATE_VARIABLE_C_0_15 = STATE_VARIABLE_C_19_19;
      J_8 = next_value_of_J_8;
      STATE_VARIABLE_C_0_15 = next_value_of_STATE_VARIABLE_C_0_15;
      continue;
    }
    break;
  }
}

static void MR_CALL 
m12_matrix_add__fill_ab_6_p_0(
  MR_Integer I_7,
  MR_Integer N_8,
  MR_ArrayPtr STATE_VARIABLE_A_0_11,
  MR_ArrayPtr * STATE_VARIABLE_A_12,
  MR_ArrayPtr STATE_VARIABLE_B_0_13,
  MR_ArrayPtr * STATE_VARIABLE_B_14)
{
  while (MR_TRUE)
  {
    MR_bool succeeded = (I_7 >= N_8);

    // setup for model_det tailcalls optimized into a loop
    ;
    if (succeeded)
    {
      *STATE_VARIABLE_B_14 = STATE_VARIABLE_B_0_13;
      *STATE_VARIABLE_A_12 = STATE_VARIABLE_A_0_11;
    }
    else
    {
      MR_Integer Var_15 = (MR_Integer) 0;
      MR_ArrayPtr STATE_VARIABLE_A_16_16;
      MR_ArrayPtr STATE_VARIABLE_B_17_17;
      MR_Integer Var_18;
      MR_Integer Var_21;
      MR_Integer next_value_of_I_7;
      MR_ArrayPtr next_value_of_STATE_VARIABLE_A_0_11;
      MR_ArrayPtr next_value_of_STATE_VARIABLE_B_0_13;

      m12_matrix_add__fill_row_7_p_0(Var_15, I_7, N_8, STATE_VARIABLE_A_0_11, &STATE_VARIABLE_A_16_16, STATE_VARIABLE_B_0_13, &STATE_VARIABLE_B_17_17);
      Var_21 = (MR_Integer) 1;
      Var_18 = (MR_Integer) ((MR_Unsigned) I_7 + (MR_Unsigned) Var_21);
      // direct tailcall eliminated
      ;
      next_value_of_I_7 = Var_18;
      next_value_of_STATE_VARIABLE_A_0_11 = STATE_VARIABLE_A_16_16;
      next_value_of_STATE_VARIABLE_B_0_13 = STATE_VARIABLE_B_17_17;
      I_7 = next_value_of_I_7;
      STATE_VARIABLE_A_0_11 = next_value_of_STATE_VARIABLE_A_0_11;
      STATE_VARIABLE_B_0_13 = next_value_of_STATE_VARIABLE_B_0_13;
      continue;
    }
    break;
  }
}

static void MR_CALL 
m12_matrix_add__fill_row_7_p_0(
  MR_Integer J_8,
  MR_Integer I_9,
  MR_Integer N_10,
  MR_ArrayPtr STATE_VARIABLE_A_0_14,
  MR_ArrayPtr * STATE_VARIABLE_A_15,
  MR_ArrayPtr STATE_VARIABLE_B_0_16,
  MR_ArrayPtr * STATE_VARIABLE_B_17)
{
  while (MR_TRUE)
  {
    MR_bool succeeded = (J_8 >= N_10);

    // setup for model_det tailcalls optimized into a loop
    ;
    if (succeeded)
    {
      *STATE_VARIABLE_B_17 = STATE_VARIABLE_B_0_16;
      *STATE_VARIABLE_A_15 = STATE_VARIABLE_A_0_14;
    }
    else
    {
      MR_Word TypeCtorInfo_27_27;
      MR_Integer Idx_13;
      MR_Integer Var_18 = (MR_Integer) ((MR_Unsigned) I_9 * (MR_Unsigned) N_10);
      MR_Integer Var_19;
      MR_ArrayPtr STATE_VARIABLE_A_20_20;
      MR_Integer Var_21;
      MR_ArrayPtr STATE_VARIABLE_B_22_22;
      MR_Integer Var_23;
      MR_Integer Var_26;
      MR_ArrayPtr conv0_STATE_VARIABLE_A_20_20;
      MR_ArrayPtr conv1_STATE_VARIABLE_B_22_22;
      MR_Integer next_value_of_J_8;
      MR_ArrayPtr next_value_of_STATE_VARIABLE_A_0_14;
      MR_ArrayPtr next_value_of_STATE_VARIABLE_B_0_16;

      Idx_13 = (MR_Integer) ((MR_Unsigned) Var_18 + (MR_Unsigned) J_8);
      Var_19 = (MR_Integer) ((MR_Unsigned) I_9 + (MR_Unsigned) J_8);
      TypeCtorInfo_27_27 = (MR_Word) (&mercury__builtin__builtin__type_ctor_info_int_0);
      mercury__array__set_4_p_0(TypeCtorInfo_27_27, Idx_13, ((MR_Box) (Var_19)), (MR_ArrayPtr) (STATE_VARIABLE_A_0_14), &conv0_STATE_VARIABLE_A_20_20);
      STATE_VARIABLE_A_20_20 = (MR_ArrayPtr) (conv0_STATE_VARIABLE_A_20_20);
      Var_21 = (MR_Integer) ((MR_Unsigned) I_9 - (MR_Unsigned) J_8);
      mercury__array__set_4_p_0(TypeCtorInfo_27_27, Idx_13, ((MR_Box) (Var_21)), (MR_ArrayPtr) (STATE_VARIABLE_B_0_16), &conv1_STATE_VARIABLE_B_22_22);
      STATE_VARIABLE_B_22_22 = (MR_ArrayPtr) (conv1_STATE_VARIABLE_B_22_22);
      Var_26 = (MR_Integer) 1;
      Var_23 = (MR_Integer) ((MR_Unsigned) J_8 + (MR_Unsigned) Var_26);
      // direct tailcall eliminated
      ;
      next_value_of_J_8 = Var_23;
      next_value_of_STATE_VARIABLE_A_0_14 = STATE_VARIABLE_A_20_20;
      next_value_of_STATE_VARIABLE_B_0_16 = STATE_VARIABLE_B_22_22;
      J_8 = next_value_of_J_8;
      STATE_VARIABLE_A_0_14 = next_value_of_STATE_VARIABLE_A_0_14;
      STATE_VARIABLE_B_0_16 = next_value_of_STATE_VARIABLE_B_0_16;
      continue;
    }
    break;
  }
}

void mercury__m12_matrix_add__init(void)
{
}

void mercury__m12_matrix_add__init_type_tables(void)
{
}

void mercury__m12_matrix_add__init_debugger(void)
{
	MR_fatal_error("debugger initialization in MLDS grade");
}

// Ensure everything is compiled with the same grade.
const char *mercury__m12_matrix_add__grade_check(void)
{
    return &MR_GRADE_VAR;
}

// :- end_module m12_matrix_add.
