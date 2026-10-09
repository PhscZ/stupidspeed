/*
** Automatically generated from `10_pi.m'
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


// :- module m10_pi.
// :- implementation.

/*
INIT mercury__m10_pi__init
ENDINIT
*/

#include "m10_pi.mih"


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
#include "integer.mih"
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
m10_pi__spigot_9_p_0(
  MR_Word Q_10,
  MR_Word R_11,
  MR_Word T_12,
  MR_Integer K_13,
  MR_Integer L_14,
  MR_Integer N_15,
  MR_Integer Produced_16,
  MR_Integer Sum0_17,
  MR_Integer * Sum_18);


static /* final */ const MR_Box m10_pi_scalar_common_1[1][1];




static /* final */ const MR_Box m10_pi_scalar_common_1[1][1] = {
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
    MR_Integer Sum_5;
    MR_Integer SS_T1_6;
    MR_Integer SS_MS_7;
    MR_Word Var_11;
    MR_Word Var_12;
    MR_Word Var_13;
    MR_Integer Var_14;
    MR_Integer Var_15;
    MR_Integer Var_16;
    MR_Integer Var_17;
    MR_Integer Var_18;
    MR_Integer Var_20;
    MR_Integer Var_21;
    MR_Integer Var_22;
    MR_Integer Var_23;
    MR_Word Var_24;
    MR_String Var_36;
    MR_String Var_38;
    MR_Word Var_44;
    MR_String Var_45;
    MR_String Var_47;
    MR_Word Var_53;
    MR_String Var_54;

    mercury__time__clock_3_p_0(&SS_T0_4);
    Var_11 = mercury__integer__one_0_f_0();
    Var_12 = mercury__integer__zero_0_f_0();
    Var_13 = mercury__integer__one_0_f_0();
    Var_14 = (MR_Integer) 1;
    Var_15 = (MR_Integer) 3;
    Var_16 = (MR_Integer) 3;
    Var_17 = (MR_Integer) 0;
    Var_18 = (MR_Integer) 0;
    m10_pi__spigot_9_p_0(Var_11, Var_12, Var_13, Var_14, Var_15, Var_16, Var_17, Var_18, &Sum_5);
    mercury__time__clock_3_p_0(&SS_T1_6);
    Var_21 = (MR_Integer) ((MR_Unsigned) SS_T1_6 - (MR_Unsigned) SS_T0_4);
    Var_22 = (MR_Integer) 1000;
    Var_20 = (MR_Integer) ((MR_Unsigned) Var_21 * (MR_Unsigned) Var_22);
    Var_23 = mercury__time__clocks_per_sec_0_f_0();
    SS_MS_7 = mercury__int__f_slash_2_f_0(Var_20, Var_23);
    Var_24 = mercury__io__stderr_stream_0_f_0();
    Var_36 = (MR_String) "TIME_MS=";
    mercury__io__write_string_4_p_0(Var_24, Var_36);
    Var_44 = (MR_Word) (&m10_pi_scalar_common_1[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_44, SS_MS_7, &Var_38);
    mercury__io__write_string_4_p_0(Var_24, Var_38);
    Var_45 = (MR_String) "\n";
    mercury__io__write_string_4_p_0(Var_24, Var_45);
    Var_53 = (MR_Word) (&m10_pi_scalar_common_1[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_53, Sum_5, &Var_47);
    mercury__io__write_string_3_p_0(Var_47);
    Var_54 = (MR_String) "\n";
    mercury__io__write_string_3_p_0(Var_54);
  }
}

static void MR_CALL 
m10_pi__spigot_9_p_0(
  MR_Word Q_10,
  MR_Word R_11,
  MR_Word T_12,
  MR_Integer K_13,
  MR_Integer L_14,
  MR_Integer N_15,
  MR_Integer Produced_16,
  MR_Integer Sum0_17,
  MR_Integer * Sum_18)
{
  while (MR_TRUE)
  {
    MR_bool succeeded;
    MR_Integer Var_29 = (MR_Integer) 1000;

    // setup for model_det tailcalls optimized into a loop
    ;
    succeeded = (Produced_16 >= Var_29);
    if (succeeded)
      *Sum_18 = Sum0_17;
    else
    {
      MR_Word U0_19;
      MR_Word V0_20;
      MR_Word Var_30;
      MR_Word Var_31;
      MR_Integer Var_32 = (MR_Integer) 4;
      MR_Word Var_33;
      MR_Integer Var_34;
      MR_Integer Var_35;

      Var_31 = mercury__integer__integer_1_f_0(Var_32);
      Var_30 = mercury__integer__f_times_2_f_0(Var_31, Q_10);
      U0_19 = mercury__integer__f_plus_2_f_0(Var_30, R_11);
      Var_35 = (MR_Integer) 1;
      Var_34 = (MR_Integer) ((MR_Unsigned) N_15 + (MR_Unsigned) Var_35);
      Var_33 = mercury__integer__integer_1_f_0(Var_34);
      V0_20 = mercury__integer__f_times_2_f_0(Var_33, T_12);
      succeeded = mercury__integer__f_less_than_2_p_0(U0_19, V0_20);
      if (succeeded)
      {
        MR_Integer Sum1_21 = (MR_Integer) ((MR_Unsigned) Sum0_17 + (MR_Unsigned) N_15);
        MR_Word U1_22;
        MR_Word Next_23;
        MR_Word R1_24;
        MR_Word Q1_25;
        MR_Word Var_36;
        MR_Integer Var_37 = (MR_Integer) 10;
        MR_Word Var_38;
        MR_Word Var_39;
        MR_Word Var_40;
        MR_Integer Var_41;
        MR_Word Var_42;
        MR_Word Var_43;
        MR_Integer Var_44;
        MR_Integer Var_45;
        MR_Word Var_46;
        MR_Integer Var_47;
        MR_Word Var_48;
        MR_Word Var_49;
        MR_Word Var_50;
        MR_Word Var_51;
        MR_Integer Var_52;
        MR_Integer Var_53;
        MR_Integer Var_54;
        MR_Integer Var_55;
        MR_Word next_value_of_Q_10;
        MR_Word next_value_of_R_11;
        MR_Integer next_value_of_N_15;
        MR_Integer next_value_of_Produced_16;
        MR_Integer next_value_of_Sum0_17;

        Var_36 = mercury__integer__integer_1_f_0(Var_37);
        Var_41 = (MR_Integer) 3;
        Var_40 = mercury__integer__integer_1_f_0(Var_41);
        Var_39 = mercury__integer__f_times_2_f_0(Var_40, Q_10);
        Var_38 = mercury__integer__f_plus_2_f_0(Var_39, R_11);
        U1_22 = mercury__integer__f_times_2_f_0(Var_36, Var_38);
        Var_42 = mercury__integer__div_2_f_0(U1_22, T_12);
        Var_45 = (MR_Integer) 10;
        Var_44 = (MR_Integer) ((MR_Unsigned) Var_45 * (MR_Unsigned) N_15);
        Var_43 = mercury__integer__integer_1_f_0(Var_44);
        Next_23 = mercury__integer__f_minus_2_f_0(Var_42, Var_43);
        Var_47 = (MR_Integer) 10;
        Var_46 = mercury__integer__integer_1_f_0(Var_47);
        Var_50 = mercury__integer__integer_1_f_0(N_15);
        Var_49 = mercury__integer__f_times_2_f_0(Var_50, T_12);
        Var_48 = mercury__integer__f_minus_2_f_0(R_11, Var_49);
        R1_24 = mercury__integer__f_times_2_f_0(Var_46, Var_48);
        Var_52 = (MR_Integer) 10;
        Var_51 = mercury__integer__integer_1_f_0(Var_52);
        Q1_25 = mercury__integer__f_times_2_f_0(Var_51, Q_10);
        Var_53 = mercury__integer__det_to_int_1_f_0(Next_23);
        Var_55 = (MR_Integer) 1;
        Var_54 = (MR_Integer) ((MR_Unsigned) Produced_16 + (MR_Unsigned) Var_55);
        // direct tailcall eliminated
        ;
        next_value_of_Q_10 = Q1_25;
        next_value_of_R_11 = R1_24;
        next_value_of_N_15 = Var_53;
        next_value_of_Produced_16 = Var_54;
        next_value_of_Sum0_17 = Sum1_21;
        Q_10 = next_value_of_Q_10;
        R_11 = next_value_of_R_11;
        N_15 = next_value_of_N_15;
        Produced_16 = next_value_of_Produced_16;
        Sum0_17 = next_value_of_Sum0_17;
        continue;
      }
      else
      {
        MR_Word U2_26;
        MR_Word V2_27;
        MR_Word T1_28;
        MR_Word Var_56;
        MR_Word Var_57;
        MR_Integer Var_58;
        MR_Integer Var_59;
        MR_Integer Var_60 = (MR_Integer) 7;
        MR_Integer Var_61;
        MR_Word Var_62;
        MR_Word Var_63;
        MR_Word Var_64;
        MR_Word Var_65;
        MR_Word Var_66;
        MR_Word Var_67;
        MR_Integer Var_68;
        MR_Word Var_69;
        MR_Word Var_70;
        MR_Word Var_71;
        MR_Integer Var_72;
        MR_Integer Var_73;
        MR_Integer Var_74;
        MR_Integer Var_75;
        MR_Integer Var_76;
        MR_Word Next_77;
        MR_Word R1_78;
        MR_Word Q1_79;
        MR_Word next_value_of_Q_10;
        MR_Word next_value_of_R_11;
        MR_Word next_value_of_T_12;
        MR_Integer next_value_of_K_13;
        MR_Integer next_value_of_L_14;
        MR_Integer next_value_of_N_15;

        Var_59 = (MR_Integer) ((MR_Unsigned) Var_60 * (MR_Unsigned) K_13);
        Var_61 = (MR_Integer) 2;
        Var_58 = (MR_Integer) ((MR_Unsigned) Var_59 + (MR_Unsigned) Var_61);
        Var_57 = mercury__integer__integer_1_f_0(Var_58);
        Var_56 = mercury__integer__f_times_2_f_0(Q_10, Var_57);
        Var_63 = mercury__integer__integer_1_f_0(L_14);
        Var_62 = mercury__integer__f_times_2_f_0(R_11, Var_63);
        U2_26 = mercury__integer__f_plus_2_f_0(Var_56, Var_62);
        Var_64 = mercury__integer__integer_1_f_0(L_14);
        V2_27 = mercury__integer__f_times_2_f_0(T_12, Var_64);
        Next_77 = mercury__integer__div_2_f_0(U2_26, V2_27);
        Var_68 = (MR_Integer) 2;
        Var_67 = mercury__integer__integer_1_f_0(Var_68);
        Var_66 = mercury__integer__f_times_2_f_0(Var_67, Q_10);
        Var_65 = mercury__integer__f_plus_2_f_0(Var_66, R_11);
        Var_69 = mercury__integer__integer_1_f_0(L_14);
        R1_78 = mercury__integer__f_times_2_f_0(Var_65, Var_69);
        Var_70 = mercury__integer__integer_1_f_0(K_13);
        Q1_79 = mercury__integer__f_times_2_f_0(Q_10, Var_70);
        Var_71 = mercury__integer__integer_1_f_0(L_14);
        T1_28 = mercury__integer__f_times_2_f_0(T_12, Var_71);
        Var_75 = (MR_Integer) 1;
        Var_72 = (MR_Integer) ((MR_Unsigned) K_13 + (MR_Unsigned) Var_75);
        Var_76 = (MR_Integer) 2;
        Var_73 = (MR_Integer) ((MR_Unsigned) L_14 + (MR_Unsigned) Var_76);
        Var_74 = mercury__integer__det_to_int_1_f_0(Next_77);
        // direct tailcall eliminated
        ;
        next_value_of_Q_10 = Q1_79;
        next_value_of_R_11 = R1_78;
        next_value_of_T_12 = T1_28;
        next_value_of_K_13 = Var_72;
        next_value_of_L_14 = Var_73;
        next_value_of_N_15 = Var_74;
        Q_10 = next_value_of_Q_10;
        R_11 = next_value_of_R_11;
        T_12 = next_value_of_T_12;
        K_13 = next_value_of_K_13;
        L_14 = next_value_of_L_14;
        N_15 = next_value_of_N_15;
        continue;
      }
    }
    break;
  }
}

void mercury__m10_pi__init(void)
{
}

void mercury__m10_pi__init_type_tables(void)
{
}

void mercury__m10_pi__init_debugger(void)
{
	MR_fatal_error("debugger initialization in MLDS grade");
}

// Ensure everything is compiled with the same grade.
const char *mercury__m10_pi__grade_check(void)
{
    return &MR_GRADE_VAR;
}

// :- end_module m10_pi.
