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
    MR_Word OpenRes_5;
    MR_String Var_14;

    mercury__time__clock_3_p_0(&SS_T0_4);
    Var_14 = (MR_String) "out.bin";
    mercury__io__open_binary_output_4_p_0(Var_14, &OpenRes_5);
    if (((MR_tag((MR_Word) OpenRes_5)) == (MR_Integer) 1))
    {
      MR_Word Error_10 = ((MR_Word) ((MR_hl_field(MR_mktag(1), OpenRes_5, (MR_Integer) 0))));
      MR_String Var_20;
      MR_Integer Var_22;
      MR_String Var_66;
      MR_String Var_68;

      Var_20 = mercury__io__error_message_1_f_0(Error_10);
      Var_66 = (MR_String) "cannot open out.bin: ";
      mercury__io__write_string_3_p_0(Var_66);
      mercury__io__write_string_3_p_0(Var_20);
      Var_68 = (MR_String) "\n";
      mercury__io__write_string_3_p_0(Var_68);
      Var_22 = (MR_Integer) 1;
      mercury__io__set_exit_status_3_p_0(Var_22);
    }
    else
    {
      MR_Word Stream_6 = ((MR_Word) ((MR_hl_field(MR_mktag(0), OpenRes_5, (MR_Integer) 0))));
      MR_Integer Written_7;
      MR_Integer SS_T1_8;
      MR_Integer SS_MS_9;
      MR_Integer Var_24 = (MR_Integer) 0;
      MR_Integer Var_25 = (MR_Integer) 50;
      MR_Integer Var_26 = (MR_Integer) 0;
      MR_Integer Var_30;
      MR_Integer Var_31;
      MR_Integer Var_32;
      MR_Integer Var_33;
      MR_Word Var_34;
      MR_String Var_46;
      MR_String Var_48;
      MR_Word Var_54;
      MR_String Var_55;
      MR_String Var_57;
      MR_Word Var_63;
      MR_String Var_64;

      m15_file_write__write_chunks_7_p_0(Var_24, Var_25, Stream_6, Var_26, &Written_7);
      mercury__io__close_binary_output_3_p_0(Stream_6);
      mercury__time__clock_3_p_0(&SS_T1_8);
      Var_31 = (MR_Integer) ((MR_Unsigned) SS_T1_8 - (MR_Unsigned) SS_T0_4);
      Var_32 = (MR_Integer) 1000;
      Var_30 = (MR_Integer) ((MR_Unsigned) Var_31 * (MR_Unsigned) Var_32);
      Var_33 = mercury__time__clocks_per_sec_0_f_0();
      SS_MS_9 = mercury__int__f_slash_2_f_0(Var_30, Var_33);
      Var_34 = mercury__io__stderr_stream_0_f_0();
      Var_46 = (MR_String) "TIME_MS=";
      mercury__io__write_string_4_p_0(Var_34, Var_46);
      Var_54 = (MR_Word) (&m15_file_write_scalar_common_1[0]);
      mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_54, SS_MS_9, &Var_48);
      mercury__io__write_string_4_p_0(Var_34, Var_48);
      Var_55 = (MR_String) "\n";
      mercury__io__write_string_4_p_0(Var_34, Var_55);
      Var_63 = (MR_Word) (&m15_file_write_scalar_common_1[0]);
      mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_63, Written_7, &Var_57);
      mercury__io__write_string_3_p_0(Var_57);
      Var_64 = (MR_String) "\n";
      mercury__io__write_string_3_p_0(Var_64);
    }
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
