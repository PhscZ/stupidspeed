/*
** Automatically generated from `11_parallel_sum.m'
** by the Mercury compiler,
** version 22.01.9
** configured for x86_64-w64-mingw32.
** Do not edit.
**
** The autoconfigured grade settings governing
** the generation of this C file were
**
** TAG_BITS=3
** UNBOXED_FLOAT=yes
** UNBOXED_INT64S=yes
** PREGENERATED_DIST=no
** HIGHLEVEL_CODE=yes
**
** END_OF_C_GRADE_INFO
*/


// :- module m11_parallel_sum.
// :- implementation.

/*
INIT mercury__m11_parallel_sum__init
ENDINIT
*/

#include "m11_parallel_sum.mih"


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
#include "thread.mih"
#include "time.mih"
#include "tree234.mih"
#include "type_desc.mih"
#include "univ.mih"
#include "string.format.mih"
#include "string.parse_util.mih"
#include "thread.mvar.mih"




static const MR_FA_PseudoTypeInfo_Struct1 m11_parallel_sum__thread__mvar__pti_mvar_1__plain_builtin__type_ctor_info_int_0;

static void MR_CALL 
m11_parallel_sum__worker_5_p_0(
  MR_Integer T_6,
  MR_Word MVar_7,
  MR_Word _Thread_8);

static void MR_CALL 
m11_parallel_sum__work_loop_4_p_0(
  MR_Integer I_5,
  MR_Integer Hi_6,
  MR_Integer STATE_VARIABLE_Acc_0_9,
  MR_Integer * STATE_VARIABLE_Acc_10);

static void MR_CALL 
m11_parallel_sum__collect_6_p_0(
  MR_Integer I_7,
  MR_Word MVar_8,
  MR_Integer STATE_VARIABLE_Total_0_12,
  MR_Integer * STATE_VARIABLE_Total_13);

static void MR_CALL 
m11_parallel_sum__spawn_workers_4_p_0_1(
  MR_Box closure_arg,
  MR_Box wrapper_arg_1,
  MR_Box wrapper_arg_2,
  MR_Box * wrapper_arg_3);

static void MR_CALL 
m11_parallel_sum__spawn_workers_4_p_0(
  MR_Integer T_5,
  MR_Word MVar_6);


static /* final */ const MR_Box m11_parallel_sum_scalar_common_1[1][1];

static /* final */ const MR_Box m11_parallel_sum_scalar_common_2[1][8];




static /* final */ const MR_Box m11_parallel_sum_scalar_common_1[1][1] = {
  /* row 0 */
  {
    (MR_Box) (((((MR_Unsigned) 0U << 4)) | (((((MR_Unsigned) 0U << 3)) | (((((MR_Unsigned) 0U << 2)) | (((MR_Unsigned) 0U << 1))))))))
  },
};

static /* final */ const MR_Box m11_parallel_sum_scalar_common_2[1][8] = {
  /* row 0 */
  {
    NULL,
    ((MR_Box) (NULL)),
    ((MR_Box) ((MR_Integer) 5)),
    ((MR_Box) (&mercury__builtin__builtin__type_ctor_info_int_0)),
    ((MR_Box) (&m11_parallel_sum__thread__mvar__pti_mvar_1__plain_builtin__type_ctor_info_int_0)),
    ((MR_Box) (&mercury__thread__thread__type_ctor_info_thread_0)),
    ((MR_Box) (&mercury__io__io__type_ctor_info_state_0)),
    ((MR_Box) (&mercury__io__io__type_ctor_info_state_0))
  },
};



#include "array.mh"
#include "bitmap.mh"
#include "io.mh"
#include "string.mh"
#include "time.mh"



static const MR_FA_PseudoTypeInfo_Struct1 m11_parallel_sum__thread__mvar__pti_mvar_1__plain_builtin__type_ctor_info_int_0 = {
  &mercury__thread__mvar__thread__mvar__type_ctor_info_mvar_1,
  {
    (MR_PseudoTypeInfo) (&mercury__builtin__builtin__type_ctor_info_int_0)
  }
};

static void MR_CALL 
m11_parallel_sum__worker_5_p_0(
  MR_Integer T_6,
  MR_Word MVar_7,
  MR_Word _Thread_8)
{
  {
    MR_Word TypeCtorInfo_14_14;
    MR_Integer Acc_10;
    MR_Integer Lo_17;
    MR_Integer Hi_18;
    MR_Integer Var_19 = (MR_Integer) 25000000;
    MR_Integer Var_20;
    MR_Integer Var_21;

    Lo_17 = (MR_Integer) ((MR_Unsigned) T_6 * (MR_Unsigned) Var_19);
    Var_20 = (MR_Integer) 25000000;
    Hi_18 = (MR_Integer) ((MR_Unsigned) Lo_17 + (MR_Unsigned) Var_20);
    Var_21 = (MR_Integer) 0;
    m11_parallel_sum__work_loop_4_p_0(Lo_17, Hi_18, Var_21, &Acc_10);
    TypeCtorInfo_14_14 = (MR_Word) (&mercury__builtin__builtin__type_ctor_info_int_0);
    mercury__thread__mvar__put_4_p_0(TypeCtorInfo_14_14, MVar_7, ((MR_Box) (Acc_10)));
  }
}

static void MR_CALL 
m11_parallel_sum__work_loop_4_p_0(
  MR_Integer I_5,
  MR_Integer Hi_6,
  MR_Integer STATE_VARIABLE_Acc_0_9,
  MR_Integer * STATE_VARIABLE_Acc_10)
{
  while (MR_TRUE)
  {
    MR_bool succeeded = (I_5 >= Hi_6);

    // setup for model_det tailcalls optimized into a loop
    ;
    if (succeeded)
      *STATE_VARIABLE_Acc_10 = STATE_VARIABLE_Acc_0_9;
    else
    {
      MR_Integer R_8;
      MR_Integer Var_11 = (MR_Integer) 4;
      MR_Integer STATE_VARIABLE_Acc_12_12;
      MR_Integer Var_21;
      MR_Integer Var_23;
      MR_Integer next_value_of_I_5;
      MR_Integer next_value_of_STATE_VARIABLE_Acc_0_9;

      R_8 = mercury__int__mod_2_f_0(I_5, Var_11);
      succeeded = (R_8 == (MR_Integer) 0);
      if (succeeded)
      {
        MR_Integer Var_13 = (MR_Integer) 1;

        STATE_VARIABLE_Acc_12_12 = (MR_Integer) ((MR_Unsigned) STATE_VARIABLE_Acc_0_9 + (MR_Unsigned) Var_13);
      }
      else
      {
        succeeded = (R_8 == (MR_Integer) 1);
        if (succeeded)
          STATE_VARIABLE_Acc_12_12 = (MR_Integer) ((MR_Unsigned) STATE_VARIABLE_Acc_0_9 + (MR_Unsigned) I_5);
        else
        {
          succeeded = (R_8 == (MR_Integer) 2);
          if (succeeded)
          {
            MR_Integer Var_16;
            MR_Integer Var_17 = (MR_Integer) 2;

            Var_16 = (MR_Integer) ((MR_Unsigned) Var_17 * (MR_Unsigned) I_5);
            STATE_VARIABLE_Acc_12_12 = (MR_Integer) ((MR_Unsigned) STATE_VARIABLE_Acc_0_9 + (MR_Unsigned) Var_16);
          }
          else
          {
            MR_Integer Var_19;
            MR_Integer Var_20 = (MR_Integer) 3;

            Var_19 = (MR_Integer) ((MR_Unsigned) Var_20 * (MR_Unsigned) I_5);
            STATE_VARIABLE_Acc_12_12 = (MR_Integer) ((MR_Unsigned) STATE_VARIABLE_Acc_0_9 + (MR_Unsigned) Var_19);
          }
        }
      }
      Var_23 = (MR_Integer) 1;
      Var_21 = (MR_Integer) ((MR_Unsigned) I_5 + (MR_Unsigned) Var_23);
      // direct tailcall eliminated
      ;
      next_value_of_I_5 = Var_21;
      next_value_of_STATE_VARIABLE_Acc_0_9 = STATE_VARIABLE_Acc_12_12;
      I_5 = next_value_of_I_5;
      STATE_VARIABLE_Acc_0_9 = next_value_of_STATE_VARIABLE_Acc_0_9;
      continue;
    }
    break;
  }
}

void MR_CALL 
main_2_p_0(void)
{
  {
    MR_Word TypeCtorInfo_34_34;
    MR_Integer SS_T0_4;
    MR_Word MVar_5;
    MR_Integer Total_6;
    MR_Integer SS_T1_7;
    MR_Integer SS_MS_8;
    MR_Integer Var_13;
    MR_Integer Var_15;
    MR_Integer Var_16;
    MR_Integer Var_19;
    MR_Integer Var_20;
    MR_Integer Var_21;
    MR_Integer Var_22;
    MR_Word Var_23;
    MR_String Var_36;
    MR_String Var_38;
    MR_Word Var_44;
    MR_String Var_45;
    MR_String Var_47;
    MR_Word Var_53;
    MR_String Var_54;

    mercury__time__clock_3_p_0(&SS_T0_4);
    TypeCtorInfo_34_34 = (MR_Word) (&mercury__builtin__builtin__type_ctor_info_int_0);
    mercury__thread__mvar__init_3_p_0(TypeCtorInfo_34_34, &MVar_5);
    Var_13 = (MR_Integer) 0;
    m11_parallel_sum__spawn_workers_4_p_0(Var_13, MVar_5);
    Var_15 = (MR_Integer) 0;
    Var_16 = (MR_Integer) 0;
    m11_parallel_sum__collect_6_p_0(Var_15, MVar_5, Var_16, &Total_6);
    mercury__time__clock_3_p_0(&SS_T1_7);
    Var_20 = (MR_Integer) ((MR_Unsigned) SS_T1_7 - (MR_Unsigned) SS_T0_4);
    Var_21 = (MR_Integer) 1000;
    Var_19 = (MR_Integer) ((MR_Unsigned) Var_20 * (MR_Unsigned) Var_21);
    Var_22 = mercury__time__clocks_per_sec_0_f_0();
    SS_MS_8 = mercury__int__f_slash_2_f_0(Var_19, Var_22);
    Var_23 = mercury__io__stderr_stream_0_f_0();
    Var_36 = (MR_String) "TIME_MS=";
    mercury__io__write_string_4_p_0(Var_23, Var_36);
    Var_44 = (MR_Word) (&m11_parallel_sum_scalar_common_1[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_44, SS_MS_8, &Var_38);
    mercury__io__write_string_4_p_0(Var_23, Var_38);
    Var_45 = (MR_String) "\n";
    mercury__io__write_string_4_p_0(Var_23, Var_45);
    Var_53 = (MR_Word) (&m11_parallel_sum_scalar_common_1[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_53, Total_6, &Var_47);
    mercury__io__write_string_3_p_0(Var_47);
    Var_54 = (MR_String) "\n";
    mercury__io__write_string_3_p_0(Var_54);
  }
}

static void MR_CALL 
m11_parallel_sum__collect_6_p_0(
  MR_Integer I_7,
  MR_Word MVar_8,
  MR_Integer STATE_VARIABLE_Total_0_12,
  MR_Integer * STATE_VARIABLE_Total_13)
{
  while (MR_TRUE)
  {
    MR_bool succeeded;
    MR_Integer Var_16 = (MR_Integer) 4;

    // setup for model_det tailcalls optimized into a loop
    ;
    succeeded = (I_7 >= Var_16);
    if (succeeded)
      *STATE_VARIABLE_Total_13 = STATE_VARIABLE_Total_0_12;
    else
    {
      MR_Word TypeCtorInfo_23_23 = (MR_Word) (&mercury__builtin__builtin__type_ctor_info_int_0);
      MR_Integer V_11;
      MR_Integer STATE_VARIABLE_Total_18_18;
      MR_Integer Var_19;
      MR_Integer Var_22;
      MR_Box conv0_V_11;
      MR_Integer next_value_of_I_7;
      MR_Integer next_value_of_STATE_VARIABLE_Total_0_12;

      mercury__thread__mvar__take_4_p_0(TypeCtorInfo_23_23, MVar_8, &conv0_V_11);
      V_11 = ((MR_Integer) (conv0_V_11));
      STATE_VARIABLE_Total_18_18 = (MR_Integer) ((MR_Unsigned) STATE_VARIABLE_Total_0_12 + (MR_Unsigned) V_11);
      Var_22 = (MR_Integer) 1;
      Var_19 = (MR_Integer) ((MR_Unsigned) I_7 + (MR_Unsigned) Var_22);
      // direct tailcall eliminated
      ;
      next_value_of_I_7 = Var_19;
      next_value_of_STATE_VARIABLE_Total_0_12 = STATE_VARIABLE_Total_18_18;
      I_7 = next_value_of_I_7;
      STATE_VARIABLE_Total_0_12 = next_value_of_STATE_VARIABLE_Total_0_12;
      continue;
    }
    break;
  }
}

static void MR_CALL 
m11_parallel_sum__spawn_workers_4_p_0_1(
  MR_Box closure_arg,
  MR_Box wrapper_arg_1,
  MR_Box wrapper_arg_2,
  MR_Box * wrapper_arg_3)
{
  {
    MR_Box closure = closure_arg;

    m11_parallel_sum__worker_5_p_0(((MR_Integer) ((MR_hl_field(MR_mktag(0), closure, (MR_Integer) 3)))), ((MR_Word) ((MR_hl_field(MR_mktag(0), closure, (MR_Integer) 4)))), ((MR_Word) (wrapper_arg_1)));
  }
}

static void MR_CALL 
m11_parallel_sum__spawn_workers_4_p_0(
  MR_Integer T_5,
  MR_Word MVar_6)
{
  while (MR_TRUE)
  {
    MR_bool succeeded;
    MR_Integer Var_13 = (MR_Integer) 4;

    // setup for model_det tailcalls optimized into a loop
    ;
    succeeded = (T_5 >= Var_13);
    if (!(succeeded))
    {
      MR_Word Res_8;
      MR_Word Var_14;
      MR_Integer Var_23;
      MR_Integer Var_25;
      MR_Integer next_value_of_T_5;

      {
        Var_14 = (MR_Word) MR_new_object(MR_Word, (5 * sizeof(MR_Word)), NULL, NULL);
        MR_hl_field(MR_mktag(0), Var_14, 0) = ((MR_Box) (&m11_parallel_sum_scalar_common_2[0]));
        MR_hl_field(MR_mktag(0), Var_14, 1) = ((MR_Box) (m11_parallel_sum__spawn_workers_4_p_0_1));
        MR_hl_field(MR_mktag(0), Var_14, 2) = ((MR_Box) ((MR_Integer) 2));
        MR_hl_field(MR_mktag(0), Var_14, 3) = ((MR_Box) (T_5));
        MR_hl_field(MR_mktag(0), Var_14, 4) = ((MR_Box) (MVar_6));
      }
      mercury__thread__spawn_native_4_p_0(Var_14, &Res_8);
      if (((MR_tag((MR_Word) Res_8)) == (MR_Integer) 1))
      {
        MR_String Err_10 = ((MR_String) ((MR_hl_field(MR_mktag(1), Res_8, (MR_Integer) 0))));
        MR_Integer Var_21;
        MR_String Var_30 = (MR_String) "spawn failed: ";
        MR_String Var_32;

        mercury__io__write_string_3_p_0(Var_30);
        mercury__io__write_string_3_p_0(Err_10);
        Var_32 = (MR_String) "\n";
        mercury__io__write_string_3_p_0(Var_32);
        Var_21 = (MR_Integer) 1;
        mercury__io__set_exit_status_3_p_0(Var_21);
      }
      Var_25 = (MR_Integer) 1;
      Var_23 = (MR_Integer) ((MR_Unsigned) T_5 + (MR_Unsigned) Var_25);
      // direct tailcall eliminated
      ;
      next_value_of_T_5 = Var_23;
      T_5 = next_value_of_T_5;
      continue;
    }
    break;
  }
}

void mercury__m11_parallel_sum__init(void)
{
}

void mercury__m11_parallel_sum__init_type_tables(void)
{
}

void mercury__m11_parallel_sum__init_debugger(void)
{
	MR_fatal_error("debugger initialization in MLDS grade");
}

// Ensure everything is compiled with the same grade.
const char *mercury__m11_parallel_sum__grade_check(void)
{
    return &MR_GRADE_VAR;
}

// :- end_module m11_parallel_sum.
