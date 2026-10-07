/*
** Automatically generated from `06_char_count.m'
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


// :- module m06_char_count.
// :- implementation.

/*
INIT mercury__m06_char_count__init
ENDINIT
*/

#include "m06_char_count.mih"


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
m06_char_count__count_char_3_p_0(
  MR_Char C_4,
  MR_Integer A0_5,
  MR_Integer * A_6);

static void MR_CALL 
main_2_p_0_1(
  MR_Box closure_arg,
  MR_Box wrapper_arg_1,
  MR_Box wrapper_arg_2,
  MR_Box * wrapper_arg_3);


static /* final */ const MR_Box m06_char_count_scalar_common_1[1][1];

static /* final */ const MR_Box m06_char_count_scalar_common_2[1][6];

static /* final */ const MR_Box m06_char_count_scalar_common_3[1][3];




static /* final */ const MR_Box m06_char_count_scalar_common_1[1][1] = {
  /* row 0 */
  {
    (MR_Box) (((((MR_Unsigned) 0U << 4)) | (((((MR_Unsigned) 0U << 3)) | (((((MR_Unsigned) 0U << 2)) | (((MR_Unsigned) 0U << 1))))))))
  },
};

static /* final */ const MR_Box m06_char_count_scalar_common_2[1][6] = {
  /* row 0 */
  {
    NULL,
    ((MR_Box) (NULL)),
    ((MR_Box) ((MR_Integer) 3)),
    ((MR_Box) (&mercury__builtin__builtin__type_ctor_info_character_0)),
    ((MR_Box) (&mercury__builtin__builtin__type_ctor_info_int_0)),
    ((MR_Box) (&mercury__builtin__builtin__type_ctor_info_int_0))
  },
};

static /* final */ const MR_Box m06_char_count_scalar_common_3[1][3] = {
  /* row 0 */
  {
    ((MR_Box) (&m06_char_count_scalar_common_2[0])),
    ((MR_Box) (main_2_p_0_1)),
    ((MR_Box) ((MR_Integer) 0))
  },
};



#include "array.mh"
#include "bitmap.mh"
#include "io.mh"
#include "string.mh"
#include "time.mh"



static void MR_CALL 
m06_char_count__count_char_3_p_0(
  MR_Char C_4,
  MR_Integer A0_5,
  MR_Integer * A_6)
{
  {
    MR_bool succeeded = (C_4 == (MR_Char) 104);

    if (succeeded)
    {
      MR_Integer Var_7 = (MR_Integer) 1;

      *A_6 = (MR_Integer) ((MR_Unsigned) A0_5 + (MR_Unsigned) Var_7);
    }
    else
      *A_6 = A0_5;
  }
}

static void MR_CALL 
main_2_p_0_1(
  MR_Box closure_arg,
  MR_Box wrapper_arg_1,
  MR_Box wrapper_arg_2,
  MR_Box * wrapper_arg_3)
{
  {
    MR_Box closure = closure_arg;
    MR_Integer conv0_A_6;

    m06_char_count__count_char_3_p_0(((MR_Char) (MR_Word) wrapper_arg_1), ((MR_Integer) (wrapper_arg_2)), &conv0_A_6);
    *wrapper_arg_3 = ((MR_Box) (conv0_A_6));
  }
}

void MR_CALL 
main_2_p_0(void)
{
  {
    MR_Word TypeCtorInfo_33_33;
    MR_Word TypeCtorInfo_37_37;
    MR_Integer SS_T0_4;
    MR_String Block_5;
    MR_Word Blocks_6;
    MR_String Text_7;
    MR_Integer Count_8;
    MR_Integer SS_T1_9;
    MR_Integer SS_MS_10;
    MR_Integer Var_14;
    MR_Word Var_15;
    MR_Integer Var_16;
    MR_Integer Var_18;
    MR_Integer Var_19;
    MR_Integer Var_20;
    MR_Integer Var_21;
    MR_Word Var_22;
    MR_String Var_39;
    MR_String Var_41;
    MR_Word Var_47;
    MR_String Var_48;
    MR_String Var_50;
    MR_Word Var_56;
    MR_String Var_57;
    MR_Box conv1_Count_8;

    mercury__time__clock_3_p_0(&SS_T0_4);
    Block_5 = (MR_String) "abcdefghij";
    TypeCtorInfo_33_33 = (MR_Word) (&mercury__builtin__builtin__type_ctor_info_string_0);
    Var_14 = (MR_Integer) 10000000;
    Blocks_6 = mercury__list__duplicate_2_f_0(TypeCtorInfo_33_33, Var_14, ((MR_Box) (Block_5)));
    Text_7 = mercury__string__append_list_1_f_0(Blocks_6);
    Var_15 = (MR_Word) (&m06_char_count_scalar_common_3[0]);
    Var_16 = (MR_Integer) 0;
    TypeCtorInfo_37_37 = (MR_Word) (&mercury__builtin__builtin__type_ctor_info_int_0);
    mercury__string__foldl_4_p_1(TypeCtorInfo_37_37, Var_15, Text_7, ((MR_Box) (Var_16)), &conv1_Count_8);
    Count_8 = ((MR_Integer) (conv1_Count_8));
    mercury__time__clock_3_p_0(&SS_T1_9);
    Var_19 = (MR_Integer) ((MR_Unsigned) SS_T1_9 - (MR_Unsigned) SS_T0_4);
    Var_20 = (MR_Integer) 1000;
    Var_18 = (MR_Integer) ((MR_Unsigned) Var_19 * (MR_Unsigned) Var_20);
    Var_21 = mercury__time__clocks_per_sec_0_f_0();
    SS_MS_10 = mercury__int__f_slash_2_f_0(Var_18, Var_21);
    Var_22 = mercury__io__stderr_stream_0_f_0();
    Var_39 = (MR_String) "TIME_MS=";
    mercury__io__write_string_4_p_0(Var_22, Var_39);
    Var_47 = (MR_Word) (&m06_char_count_scalar_common_1[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_47, SS_MS_10, &Var_41);
    mercury__io__write_string_4_p_0(Var_22, Var_41);
    Var_48 = (MR_String) "\n";
    mercury__io__write_string_4_p_0(Var_22, Var_48);
    Var_56 = (MR_Word) (&m06_char_count_scalar_common_1[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_56, Count_8, &Var_50);
    mercury__io__write_string_3_p_0(Var_50);
    Var_57 = (MR_String) "\n";
    mercury__io__write_string_3_p_0(Var_57);
  }
}

void mercury__m06_char_count__init(void)
{
}

void mercury__m06_char_count__init_type_tables(void)
{
}

void mercury__m06_char_count__init_debugger(void)
{
	MR_fatal_error("debugger initialization in MLDS grade");
}

// Ensure everything is compiled with the same grade.
const char *mercury__m06_char_count__grade_check(void)
{
    return &MR_GRADE_VAR;
}

// :- end_module m06_char_count.
