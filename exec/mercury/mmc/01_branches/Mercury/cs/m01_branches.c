/*
** Automatically generated from `01_branches.m'
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


// :- module m01_branches.
// :- implementation.

/*
INIT mercury__m01_branches__init
ENDINIT
*/

#include "m01_branches.mih"


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
m01_branches__loop_10_p_0(
  MR_Integer I_11,
  MR_Integer N_12,
  MR_Integer STATE_VARIABLE_A_0_17,
  MR_Integer * STATE_VARIABLE_A_18,
  MR_Integer STATE_VARIABLE_B_0_19,
  MR_Integer * STATE_VARIABLE_B_20,
  MR_Integer STATE_VARIABLE_C_0_21,
  MR_Integer * STATE_VARIABLE_C_22,
  MR_Integer STATE_VARIABLE_D_0_23,
  MR_Integer * STATE_VARIABLE_D_24);


static /* final */ const MR_Box m01_branches_scalar_common_1[1][1];




static /* final */ const MR_Box m01_branches_scalar_common_1[1][1] = {
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
    MR_Integer A_5;
    MR_Integer B_6;
    MR_Integer C_7;
    MR_Integer D_8;
    MR_Integer SS_T1_9;
    MR_Integer SS_MS_10;
    MR_Integer Var_14;
    MR_Integer Var_15;
    MR_Integer Var_16;
    MR_Integer Var_17;
    MR_Integer Var_18;
    MR_Integer Var_19;
    MR_Integer Var_21;
    MR_Integer Var_22;
    MR_Integer Var_23;
    MR_Integer Var_24;
    MR_Word Var_25;
    MR_String Var_43;
    MR_String Var_45;
    MR_Word Var_51;
    MR_String Var_52;
    MR_String Var_54;
    MR_Word Var_60;
    MR_String Var_62;
    MR_String Var_64;
    MR_Word Var_70;
    MR_String Var_72;
    MR_String Var_74;
    MR_Word Var_80;
    MR_String Var_82;
    MR_String Var_84;
    MR_Word Var_90;
    MR_String Var_91;

    mercury__time__clock_3_p_0(&SS_T0_4);
    Var_14 = (MR_Integer) 0;
    Var_15 = (MR_Integer) 100000000;
    Var_16 = (MR_Integer) 0;
    Var_17 = (MR_Integer) 0;
    Var_18 = (MR_Integer) 0;
    Var_19 = (MR_Integer) 0;
    m01_branches__loop_10_p_0(Var_14, Var_15, Var_16, &A_5, Var_17, &B_6, Var_18, &C_7, Var_19, &D_8);
    mercury__time__clock_3_p_0(&SS_T1_9);
    Var_22 = (MR_Integer) ((MR_Unsigned) SS_T1_9 - (MR_Unsigned) SS_T0_4);
    Var_23 = (MR_Integer) 1000;
    Var_21 = (MR_Integer) ((MR_Unsigned) Var_22 * (MR_Unsigned) Var_23);
    Var_24 = mercury__time__clocks_per_sec_0_f_0();
    SS_MS_10 = mercury__int__f_47_47_2_f_0(Var_21, Var_24);
    Var_25 = mercury__io__stderr_stream_0_f_0();
    Var_43 = (MR_String) "TIME_MS=";
    mercury__io__write_string_4_p_0(Var_25, Var_43);
    Var_51 = (MR_Word) (&m01_branches_scalar_common_1[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_51, SS_MS_10, &Var_45);
    mercury__io__write_string_4_p_0(Var_25, Var_45);
    Var_52 = (MR_String) "\n";
    mercury__io__write_string_4_p_0(Var_25, Var_52);
    Var_60 = (MR_Word) (&m01_branches_scalar_common_1[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_60, A_5, &Var_54);
    mercury__io__write_string_3_p_0(Var_54);
    Var_62 = (MR_String) " ";
    mercury__io__write_string_3_p_0(Var_62);
    Var_70 = (MR_Word) (&m01_branches_scalar_common_1[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_70, B_6, &Var_64);
    mercury__io__write_string_3_p_0(Var_64);
    Var_72 = (MR_String) " ";
    mercury__io__write_string_3_p_0(Var_72);
    Var_80 = (MR_Word) (&m01_branches_scalar_common_1[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_80, C_7, &Var_74);
    mercury__io__write_string_3_p_0(Var_74);
    Var_82 = (MR_String) " ";
    mercury__io__write_string_3_p_0(Var_82);
    Var_90 = (MR_Word) (&m01_branches_scalar_common_1[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_90, D_8, &Var_84);
    mercury__io__write_string_3_p_0(Var_84);
    Var_91 = (MR_String) "\n";
    mercury__io__write_string_3_p_0(Var_91);
  }
}

static void MR_CALL 
m01_branches__loop_10_p_0(
  MR_Integer I_11,
  MR_Integer N_12,
  MR_Integer STATE_VARIABLE_A_0_17,
  MR_Integer * STATE_VARIABLE_A_18,
  MR_Integer STATE_VARIABLE_B_0_19,
  MR_Integer * STATE_VARIABLE_B_20,
  MR_Integer STATE_VARIABLE_C_0_21,
  MR_Integer * STATE_VARIABLE_C_22,
  MR_Integer STATE_VARIABLE_D_0_23,
  MR_Integer * STATE_VARIABLE_D_24)
{
  while (MR_TRUE)
  {
    MR_bool succeeded = (I_11 >= N_12);

    // setup for model_det tailcalls optimized into a loop
    ;
    if (succeeded)
    {
      *STATE_VARIABLE_D_24 = STATE_VARIABLE_D_0_23;
      *STATE_VARIABLE_C_22 = STATE_VARIABLE_C_0_21;
      *STATE_VARIABLE_B_20 = STATE_VARIABLE_B_0_19;
      *STATE_VARIABLE_A_18 = STATE_VARIABLE_A_0_17;
    }
    else
    {
      MR_Integer STATE_VARIABLE_A_27_27;
      MR_Integer STATE_VARIABLE_B_31_31;
      MR_Integer STATE_VARIABLE_C_35_35;
      MR_Integer STATE_VARIABLE_D_37_37;
      MR_Integer Var_39;
      MR_Integer Var_44;
      MR_Integer Var_25;
      MR_Integer Var_26 = (MR_Integer) 3;
      MR_Integer next_value_of_I_11;
      MR_Integer next_value_of_STATE_VARIABLE_A_0_17;
      MR_Integer next_value_of_STATE_VARIABLE_B_0_19;
      MR_Integer next_value_of_STATE_VARIABLE_C_0_21;
      MR_Integer next_value_of_STATE_VARIABLE_D_0_23;

      Var_25 = mercury__int__mod_2_f_0(I_11, Var_26);
      succeeded = (Var_25 == (MR_Integer) 0);
      if (succeeded)
      {
        MR_Integer Var_28 = (MR_Integer) 1;

        STATE_VARIABLE_A_27_27 = (MR_Integer) ((MR_Unsigned) STATE_VARIABLE_A_0_17 + (MR_Unsigned) Var_28);
        STATE_VARIABLE_D_37_37 = STATE_VARIABLE_D_0_23;
        STATE_VARIABLE_C_35_35 = STATE_VARIABLE_C_0_21;
        STATE_VARIABLE_B_31_31 = STATE_VARIABLE_B_0_19;
      }
      else
      {
        MR_Integer Var_29;
        MR_Integer Var_30 = (MR_Integer) 5;

        Var_29 = mercury__int__mod_2_f_0(I_11, Var_30);
        succeeded = (Var_29 == (MR_Integer) 0);
        if (succeeded)
        {
          MR_Integer Var_32 = (MR_Integer) 1;

          STATE_VARIABLE_B_31_31 = (MR_Integer) ((MR_Unsigned) STATE_VARIABLE_B_0_19 + (MR_Unsigned) Var_32);
          STATE_VARIABLE_D_37_37 = STATE_VARIABLE_D_0_23;
          STATE_VARIABLE_C_35_35 = STATE_VARIABLE_C_0_21;
        }
        else
        {
          MR_Integer Var_33;
          MR_Integer Var_34 = (MR_Integer) 7;

          Var_33 = mercury__int__mod_2_f_0(I_11, Var_34);
          succeeded = (Var_33 == (MR_Integer) 0);
          if (succeeded)
          {
            MR_Integer Var_36 = (MR_Integer) 1;

            STATE_VARIABLE_C_35_35 = (MR_Integer) ((MR_Unsigned) STATE_VARIABLE_C_0_21 + (MR_Unsigned) Var_36);
            STATE_VARIABLE_D_37_37 = STATE_VARIABLE_D_0_23;
          }
          else
          {
            MR_Integer Var_38 = (MR_Integer) 1;

            STATE_VARIABLE_D_37_37 = (MR_Integer) ((MR_Unsigned) STATE_VARIABLE_D_0_23 + (MR_Unsigned) Var_38);
            STATE_VARIABLE_C_35_35 = STATE_VARIABLE_C_0_21;
          }
          STATE_VARIABLE_B_31_31 = STATE_VARIABLE_B_0_19;
        }
        STATE_VARIABLE_A_27_27 = STATE_VARIABLE_A_0_17;
      }
      Var_44 = (MR_Integer) 1;
      Var_39 = (MR_Integer) ((MR_Unsigned) I_11 + (MR_Unsigned) Var_44);
      // direct tailcall eliminated
      ;
      next_value_of_I_11 = Var_39;
      next_value_of_STATE_VARIABLE_A_0_17 = STATE_VARIABLE_A_27_27;
      next_value_of_STATE_VARIABLE_B_0_19 = STATE_VARIABLE_B_31_31;
      next_value_of_STATE_VARIABLE_C_0_21 = STATE_VARIABLE_C_35_35;
      next_value_of_STATE_VARIABLE_D_0_23 = STATE_VARIABLE_D_37_37;
      I_11 = next_value_of_I_11;
      STATE_VARIABLE_A_0_17 = next_value_of_STATE_VARIABLE_A_0_17;
      STATE_VARIABLE_B_0_19 = next_value_of_STATE_VARIABLE_B_0_19;
      STATE_VARIABLE_C_0_21 = next_value_of_STATE_VARIABLE_C_0_21;
      STATE_VARIABLE_D_0_23 = next_value_of_STATE_VARIABLE_D_0_23;
      continue;
    }
    break;
  }
}

void mercury__m01_branches__init(void)
{
}

void mercury__m01_branches__init_type_tables(void)
{
}

void mercury__m01_branches__init_debugger(void)
{
	MR_fatal_error("debugger initialization in MLDS grade");
}

// Ensure everything is compiled with the same grade.
const char *mercury__m01_branches__grade_check(void)
{
    return &MR_GRADE_VAR;
}

// :- end_module m01_branches.
