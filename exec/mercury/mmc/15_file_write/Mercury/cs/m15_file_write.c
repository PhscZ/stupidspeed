/*
** Automatically generated from `15_file_write.m'
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


// :- module m15_file_write.
// :- implementation.

/*
INIT mercury__m15_file_write__init
ENDINIT
*/

#include "m15_file_write.mih"


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
m15_file_write__write_passes_6_p_0(
  MR_Integer I_7,
  MR_Integer N_8,
  MR_Integer Acc_9,
  MR_Integer * Total_10);

static void MR_CALL 
m15_file_write__write_chunks_7_p_0(
  MR_Integer I_8,
  MR_Integer N_9,
  MR_Word Stream_10,
  MR_Integer STATE_VARIABLE_Written_0_13,
  MR_Integer * STATE_VARIABLE_Written_14);

static void MR_CALL 
m15_file_write__write_chunk_7_p_0(
  MR_Integer J_8,
  MR_Integer M_9,
  MR_Word Stream_10,
  MR_Integer STATE_VARIABLE_Written_0_13,
  MR_Integer * STATE_VARIABLE_Written_14);


static /* final */ const MR_Box m15_file_write_scalar_common_1[1][1];




static /* final */ const MR_Box m15_file_write_scalar_common_1[1][1] = {
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
    MR_Integer Written_5;
    MR_Integer SS_T1_6;
    MR_Integer SS_MS_7;
    MR_Integer Var_11;
    MR_Integer Var_12;
    MR_Integer Var_13;
    MR_Integer Var_16;
    MR_Integer Var_17;
    MR_Integer Var_18;
    MR_Integer Var_19;
    MR_Word Var_20;
    MR_String Var_32;
    MR_String Var_34;
    MR_Word Var_40;
    MR_String Var_41;
    MR_String Var_43;
    MR_Word Var_49;
    MR_String Var_50;

    mercury__time__clock_3_p_0(&SS_T0_4);
    Var_11 = (MR_Integer) 0;
    Var_12 = (MR_Integer) 8;
    Var_13 = (MR_Integer) 0;
    m15_file_write__write_passes_6_p_0(Var_11, Var_12, Var_13, &Written_5);
    mercury__time__clock_3_p_0(&SS_T1_6);
    Var_17 = (MR_Integer) ((MR_Unsigned) SS_T1_6 - (MR_Unsigned) SS_T0_4);
    Var_18 = (MR_Integer) 1000;
    Var_16 = (MR_Integer) ((MR_Unsigned) Var_17 * (MR_Unsigned) Var_18);
    Var_19 = mercury__time__clocks_per_sec_0_f_0();
    SS_MS_7 = mercury__int__f_slash_2_f_0(Var_16, Var_19);
    Var_20 = mercury__io__stderr_stream_0_f_0();
    Var_32 = (MR_String) "TIME_MS=";
    mercury__io__write_string_4_p_0(Var_20, Var_32);
    Var_40 = (MR_Word) (&m15_file_write_scalar_common_1[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_40, SS_MS_7, &Var_34);
    mercury__io__write_string_4_p_0(Var_20, Var_34);
    Var_41 = (MR_String) "\n";
    mercury__io__write_string_4_p_0(Var_20, Var_41);
    Var_49 = (MR_Word) (&m15_file_write_scalar_common_1[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_49, Written_5, &Var_43);
    mercury__io__write_string_3_p_0(Var_43);
    Var_50 = (MR_String) "\n";
    mercury__io__write_string_3_p_0(Var_50);
  }
}

static void MR_CALL 
m15_file_write__write_passes_6_p_0(
  MR_Integer I_7,
  MR_Integer N_8,
  MR_Integer Acc_9,
  MR_Integer * Total_10)
{
  while (MR_TRUE)
  {
    MR_bool succeeded = (I_7 >= N_8);

    // setup for model_det tailcalls optimized into a loop
    ;
    if (succeeded)
      *Total_10 = Acc_9;
    else
    {
      MR_Word OpenRes_12;
      MR_String Var_18 = (MR_String) "out.bin";

      mercury__io__open_binary_output_4_p_0(Var_18, &OpenRes_12);
      if (((MR_tag((MR_Word) OpenRes_12)) == (MR_Integer) 1))
      {
        MR_Word Error_15 = ((MR_Word) ((MR_hl_field(MR_mktag(1), OpenRes_12, (MR_Integer) 0))));
        MR_String Var_24;
        MR_Integer Var_26;
        MR_String Var_38;
        MR_String Var_40;

        Var_24 = mercury__io__error_message_1_f_0(Error_15);
        Var_38 = (MR_String) "cannot open out.bin: ";
        mercury__io__write_string_3_p_0(Var_38);
        mercury__io__write_string_3_p_0(Var_24);
        Var_40 = (MR_String) "\n";
        mercury__io__write_string_3_p_0(Var_40);
        Var_26 = (MR_Integer) 1;
        mercury__io__set_exit_status_3_p_0(Var_26);
        *Total_10 = Acc_9;
      }
      else
      {
        MR_Word Stream_13 = ((MR_Word) ((MR_hl_field(MR_mktag(0), OpenRes_12, (MR_Integer) 0))));
        MR_Integer Pass_14;
        MR_Integer Var_28 = (MR_Integer) 0;
        MR_Integer Var_29 = (MR_Integer) 50;
        MR_Integer Var_30 = (MR_Integer) 0;
        MR_Integer Var_33;
        MR_Integer Var_34;
        MR_Integer Var_36;
        MR_Integer next_value_of_I_7;
        MR_Integer next_value_of_Acc_9;

        m15_file_write__write_chunks_7_p_0(Var_28, Var_29, Stream_13, Var_30, &Pass_14);
        mercury__io__close_binary_output_3_p_0(Stream_13);
        Var_36 = (MR_Integer) 1;
        Var_33 = (MR_Integer) ((MR_Unsigned) I_7 + (MR_Unsigned) Var_36);
        Var_34 = (MR_Integer) ((MR_Unsigned) Acc_9 + (MR_Unsigned) Pass_14);
        // direct tailcall eliminated
        ;
        next_value_of_I_7 = Var_33;
        next_value_of_Acc_9 = Var_34;
        I_7 = next_value_of_I_7;
        Acc_9 = next_value_of_Acc_9;
        continue;
      }
    }
    break;
  }
}

static void MR_CALL 
m15_file_write__write_chunks_7_p_0(
  MR_Integer I_8,
  MR_Integer N_9,
  MR_Word Stream_10,
  MR_Integer STATE_VARIABLE_Written_0_13,
  MR_Integer * STATE_VARIABLE_Written_14)
{
  while (MR_TRUE)
  {
    MR_bool succeeded = (I_8 >= N_9);

    // setup for model_det tailcalls optimized into a loop
    ;
    if (succeeded)
      *STATE_VARIABLE_Written_14 = STATE_VARIABLE_Written_0_13;
    else
    {
      MR_Integer Var_17 = (MR_Integer) 0;
      MR_Integer Var_18 = (MR_Integer) 1048576;
      MR_Integer STATE_VARIABLE_Written_19_19;
      MR_Integer Var_21;
      MR_Integer Var_24;
      MR_Integer next_value_of_I_8;
      MR_Integer next_value_of_STATE_VARIABLE_Written_0_13;

      m15_file_write__write_chunk_7_p_0(Var_17, Var_18, Stream_10, STATE_VARIABLE_Written_0_13, &STATE_VARIABLE_Written_19_19);
      Var_24 = (MR_Integer) 1;
      Var_21 = (MR_Integer) ((MR_Unsigned) I_8 + (MR_Unsigned) Var_24);
      // direct tailcall eliminated
      ;
      next_value_of_I_8 = Var_21;
      next_value_of_STATE_VARIABLE_Written_0_13 = STATE_VARIABLE_Written_19_19;
      I_8 = next_value_of_I_8;
      STATE_VARIABLE_Written_0_13 = next_value_of_STATE_VARIABLE_Written_0_13;
      continue;
    }
    break;
  }
}

static void MR_CALL 
m15_file_write__write_chunk_7_p_0(
  MR_Integer J_8,
  MR_Integer M_9,
  MR_Word Stream_10,
  MR_Integer STATE_VARIABLE_Written_0_13,
  MR_Integer * STATE_VARIABLE_Written_14)
{
  while (MR_TRUE)
  {
    MR_bool succeeded = (J_8 >= M_9);

    // setup for model_det tailcalls optimized into a loop
    ;
    if (succeeded)
      *STATE_VARIABLE_Written_14 = STATE_VARIABLE_Written_0_13;
    else
    {
      MR_Integer Var_17;
      MR_Integer Var_19 = (MR_Integer) 256;
      MR_Integer STATE_VARIABLE_Written_20_20;
      MR_Integer Var_21;
      MR_Integer Var_22;
      MR_Integer Var_25;
      MR_Integer next_value_of_J_8;
      MR_Integer next_value_of_STATE_VARIABLE_Written_0_13;

      Var_17 = mercury__int__mod_2_f_0(J_8, Var_19);
      mercury__io__write_byte_4_p_0(Stream_10, Var_17);
      Var_21 = (MR_Integer) 1;
      STATE_VARIABLE_Written_20_20 = (MR_Integer) ((MR_Unsigned) STATE_VARIABLE_Written_0_13 + (MR_Unsigned) Var_21);
      Var_25 = (MR_Integer) 1;
      Var_22 = (MR_Integer) ((MR_Unsigned) J_8 + (MR_Unsigned) Var_25);
      // direct tailcall eliminated
      ;
      next_value_of_J_8 = Var_22;
      next_value_of_STATE_VARIABLE_Written_0_13 = STATE_VARIABLE_Written_20_20;
      J_8 = next_value_of_J_8;
      STATE_VARIABLE_Written_0_13 = next_value_of_STATE_VARIABLE_Written_0_13;
      continue;
    }
    break;
  }
}

void mercury__m15_file_write__init(void)
{
}

void mercury__m15_file_write__init_type_tables(void)
{
}

void mercury__m15_file_write__init_debugger(void)
{
	MR_fatal_error("debugger initialization in MLDS grade");
}

// Ensure everything is compiled with the same grade.
const char *mercury__m15_file_write__grade_check(void)
{
    return &MR_GRADE_VAR;
}

// :- end_module m15_file_write.
