/*
** Automatically generated from `14_file_read.m'
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


// :- module m14_file_read.
// :- implementation.

/*
INIT mercury__m14_file_read__init
ENDINIT
*/

#include "m14_file_read.mih"


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
m14_file_read__read_all_5_p_0(
  MR_Word Stream_6,
  MR_Integer STATE_VARIABLE_Total_0_12,
  MR_Integer * STATE_VARIABLE_Total_13);


static /* final */ const MR_Box m14_file_read_scalar_common_1[1][1];




static /* final */ const MR_Box m14_file_read_scalar_common_1[1][1] = {
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
    Var_14 = (MR_String) "data.bin";
    mercury__io__open_binary_input_4_p_0(Var_14, &OpenRes_5);
    if (((MR_tag((MR_Word) OpenRes_5)) == (MR_Integer) 1))
    {
      MR_Word Error_10 = ((MR_Word) ((MR_hl_field(MR_mktag(1), OpenRes_5, (MR_Integer) 0))));
      MR_String Var_20;
      MR_Integer Var_22;
      MR_String Var_66;
      MR_String Var_68;

      Var_20 = mercury__io__error_message_1_f_0(Error_10);
      Var_66 = (MR_String) "cannot open data.bin: ";
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
      MR_Integer Total_7;
      MR_Integer SS_T1_8;
      MR_Integer SS_MS_9;
      MR_Integer Var_24 = (MR_Integer) 0;
      MR_Integer Var_28;
      MR_Integer Var_29;
      MR_Integer Var_30;
      MR_Integer Var_31;
      MR_Word Var_32;
      MR_Integer Var_42;
      MR_Integer Var_43;
      MR_String Var_46;
      MR_String Var_48;
      MR_Word Var_54;
      MR_String Var_55;
      MR_String Var_57;
      MR_Word Var_63;
      MR_String Var_64;

      m14_file_read__read_all_5_p_0(Stream_6, Var_24, &Total_7);
      mercury__io__close_binary_input_3_p_0(Stream_6);
      mercury__time__clock_3_p_0(&SS_T1_8);
      Var_29 = (MR_Integer) ((MR_Unsigned) SS_T1_8 - (MR_Unsigned) SS_T0_4);
      Var_30 = (MR_Integer) 1000;
      Var_28 = (MR_Integer) ((MR_Unsigned) Var_29 * (MR_Unsigned) Var_30);
      Var_31 = mercury__time__clocks_per_sec_0_f_0();
      SS_MS_9 = mercury__int__f_slash_2_f_0(Var_28, Var_31);
      Var_32 = mercury__io__stderr_stream_0_f_0();
      Var_46 = (MR_String) "TIME_MS=";
      mercury__io__write_string_4_p_0(Var_32, Var_46);
      Var_54 = (MR_Word) (&m14_file_read_scalar_common_1[0]);
      mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_54, SS_MS_9, &Var_48);
      mercury__io__write_string_4_p_0(Var_32, Var_48);
      Var_55 = (MR_String) "\n";
      mercury__io__write_string_4_p_0(Var_32, Var_55);
      Var_43 = (MR_Integer) 4294967296;
      Var_42 = mercury__int__mod_2_f_0(Total_7, Var_43);
      Var_63 = (MR_Word) (&m14_file_read_scalar_common_1[0]);
      mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_63, Var_42, &Var_57);
      mercury__io__write_string_3_p_0(Var_57);
      Var_64 = (MR_String) "\n";
      mercury__io__write_string_3_p_0(Var_64);
    }
  }
}

static void MR_CALL 
m14_file_read__read_all_5_p_0(
  MR_Word Stream_6,
  MR_Integer STATE_VARIABLE_Total_0_12,
  MR_Integer * STATE_VARIABLE_Total_13)
{
  while (MR_TRUE)
  {
    MR_bool succeeded;
    MR_Word Result_9;
    MR_Integer Byte_10;

    // setup for model_det tailcalls optimized into a loop
    ;
    mercury__io__read_byte_4_p_0(Stream_6, &Result_9);
    succeeded = ((MR_tag((MR_Word) Result_9)) == (MR_Integer) 1);
    if (succeeded)
    {
      Byte_10 = ((MR_Integer) ((MR_hl_field(MR_mktag(1), Result_9, (MR_Integer) 0))));
      {
        MR_Integer STATE_VARIABLE_Total_17_17 = (MR_Integer) ((MR_Unsigned) STATE_VARIABLE_Total_0_12 + (MR_Unsigned) Byte_10);
        MR_Integer next_value_of_STATE_VARIABLE_Total_0_12 = STATE_VARIABLE_Total_17_17;

        // direct tailcall eliminated
        ;
        STATE_VARIABLE_Total_0_12 = next_value_of_STATE_VARIABLE_Total_0_12;
        continue;
      }
    }
    else
    {
      MR_Word Error_11;

      succeeded = ((MR_tag((MR_Word) Result_9)) == (MR_Integer) 2);
      if (succeeded)
      {
        Error_11 = ((MR_Word) ((MR_hl_field(MR_mktag(2), Result_9, (MR_Integer) 0))));
        {
          MR_String Var_24;
          MR_Integer Var_26;
          MR_String Var_29;
          MR_String Var_31;

          Var_24 = mercury__io__error_message_1_f_0(Error_11);
          Var_29 = (MR_String) "read error: ";
          mercury__io__write_string_3_p_0(Var_29);
          mercury__io__write_string_3_p_0(Var_24);
          Var_31 = (MR_String) "\n";
          mercury__io__write_string_3_p_0(Var_31);
          Var_26 = (MR_Integer) 1;
          mercury__io__set_exit_status_3_p_0(Var_26);
        }
      }
      *STATE_VARIABLE_Total_13 = STATE_VARIABLE_Total_0_12;
    }
    break;
  }
}

void mercury__m14_file_read__init(void)
{
}

void mercury__m14_file_read__init_type_tables(void)
{
}

void mercury__m14_file_read__init_debugger(void)
{
	MR_fatal_error("debugger initialization in MLDS grade");
}

// Ensure everything is compiled with the same grade.
const char *mercury__m14_file_read__grade_check(void)
{
    return &MR_GRADE_VAR;
}

// :- end_module m14_file_read.
