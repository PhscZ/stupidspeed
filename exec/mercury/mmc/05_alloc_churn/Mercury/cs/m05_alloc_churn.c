/*
** Automatically generated from `05_alloc_churn.m'
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


// :- module m05_alloc_churn.
// :- implementation.

/*
INIT mercury__m05_alloc_churn__init
ENDINIT
*/

#include "m05_alloc_churn.mih"


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




static const MR_PseudoTypeInfo m05_alloc_churn__m05_alloc_churn__field_types_blob_0_0[8];

static const MR_DuFunctorDesc m05_alloc_churn__m05_alloc_churn__du_functor_desc_blob_0_0;

static const MR_DuFunctorDescPtr m05_alloc_churn__m05_alloc_churn__du_stag_ordered_blob_0_0[1];

static const MR_DuPtagLayout m05_alloc_churn__m05_alloc_churn__du_ptag_ordered_blob_0[1];

static const MR_DuFunctorDescPtr m05_alloc_churn__m05_alloc_churn__du_name_ordered_blob_0[1];

static const MR_Integer m05_alloc_churn__m05_alloc_churn__functor_number_map_blob_0[1];

static void MR_CALL 
m05_alloc_churn____Compare____blob_0_0(
  MR_Word * HeadVar__1_1,
  MR_Word HeadVar__2_2,
  MR_Word HeadVar__3_3);

static MR_bool MR_CALL 
m05_alloc_churn____Unify____blob_0_0(
  MR_Word HeadVar__1_1,
  MR_Word HeadVar__2_2);

static void MR_CALL 
m05_alloc_churn__churn_6_p_0(
  MR_Integer I_7,
  MR_Integer N_8,
  MR_ArrayPtr STATE_VARIABLE_Slots_0_13,
  MR_ArrayPtr * STATE_VARIABLE_Slots_14,
  MR_Integer STATE_VARIABLE_Total_0_15,
  MR_Integer * STATE_VARIABLE_Total_16);

static MR_bool MR_CALL 
m05_alloc_churn____Unify____blob_0_0_10001(
  MR_Box wrapper_arg_1,
  MR_Box wrapper_arg_2);

static void MR_CALL 
m05_alloc_churn____Compare____blob_0_0_10001(
  MR_Box * wrapper_arg_1,
  MR_Box wrapper_arg_2,
  MR_Box wrapper_arg_3);


static /* final */ const MR_Box m05_alloc_churn_scalar_common_1[1][8];

static /* final */ const MR_Box m05_alloc_churn_scalar_common_2[1][1];




static /* final */ const MR_Box m05_alloc_churn_scalar_common_1[1][8] = {
  /* row 0 */
  {
    ((MR_Box) ((MR_Integer) 0)),
    ((MR_Box) ((MR_Integer) 0)),
    ((MR_Box) ((MR_Integer) 0)),
    ((MR_Box) ((MR_Integer) 0)),
    ((MR_Box) ((MR_Integer) 0)),
    ((MR_Box) ((MR_Integer) 0)),
    ((MR_Box) ((MR_Integer) 0)),
    ((MR_Box) ((MR_Integer) 0))
  },
};

static /* final */ const MR_Box m05_alloc_churn_scalar_common_2[1][1] = {
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



static const MR_PseudoTypeInfo m05_alloc_churn__m05_alloc_churn__field_types_blob_0_0[8] = {
  (MR_PseudoTypeInfo) (&mercury__builtin__builtin__type_ctor_info_int_0),
  (MR_PseudoTypeInfo) (&mercury__builtin__builtin__type_ctor_info_int_0),
  (MR_PseudoTypeInfo) (&mercury__builtin__builtin__type_ctor_info_int_0),
  (MR_PseudoTypeInfo) (&mercury__builtin__builtin__type_ctor_info_int_0),
  (MR_PseudoTypeInfo) (&mercury__builtin__builtin__type_ctor_info_int_0),
  (MR_PseudoTypeInfo) (&mercury__builtin__builtin__type_ctor_info_int_0),
  (MR_PseudoTypeInfo) (&mercury__builtin__builtin__type_ctor_info_int_0),
  (MR_PseudoTypeInfo) (&mercury__builtin__builtin__type_ctor_info_int_0)
};

static const MR_DuFunctorDesc m05_alloc_churn__m05_alloc_churn__du_functor_desc_blob_0_0 = {
  (MR_String) "blob",
  INT16_C(8),
  UINT16_C(0),
  MR_SECTAG_NONE,
  UINT8_C(0),
  (MR_Integer) -1,
  INT32_C(0),
  m05_alloc_churn__m05_alloc_churn__field_types_blob_0_0,
  NULL,
  NULL,
  NULL,
  MR_FUNCTOR_SUBTYPE_NONE,
  UINT8_C(0)
};

static const MR_DuFunctorDescPtr m05_alloc_churn__m05_alloc_churn__du_stag_ordered_blob_0_0[1] = {
  &m05_alloc_churn__m05_alloc_churn__du_functor_desc_blob_0_0
};

static const MR_DuPtagLayout m05_alloc_churn__m05_alloc_churn__du_ptag_ordered_blob_0[1] = {
  {
    UINT32_C(1),
    MR_SECTAG_NONE,
    m05_alloc_churn__m05_alloc_churn__du_stag_ordered_blob_0_0,
    INT8_C(-1),
    UINT8_C(0),
    UINT8_C(1)
  }
};

static const MR_DuFunctorDescPtr m05_alloc_churn__m05_alloc_churn__du_name_ordered_blob_0[1] = {
  &m05_alloc_churn__m05_alloc_churn__du_functor_desc_blob_0_0
};

static const MR_Integer m05_alloc_churn__m05_alloc_churn__functor_number_map_blob_0[1] = {
  (MR_Integer) 0
};

const MR_TypeCtorInfo_Struct m05_alloc_churn__m05_alloc_churn__type_ctor_info_blob_0 = {
  (MR_Integer) 0,
  UINT8_C(18),
  INT8_C(1),
  MR_TYPECTOR_REP_DU,
  ((MR_Box) (m05_alloc_churn____Unify____blob_0_0_10001)),
  ((MR_Box) (m05_alloc_churn____Compare____blob_0_0_10001)),
  (MR_String) "m05_alloc_churn",
  (MR_String) "blob",
  {     m05_alloc_churn__m05_alloc_churn__du_name_ordered_blob_0 },
  {     m05_alloc_churn__m05_alloc_churn__du_ptag_ordered_blob_0 },
  (MR_Integer) 1,
  UINT16_C(12),
  m05_alloc_churn__m05_alloc_churn__functor_number_map_blob_0,

};

static void MR_CALL 
m05_alloc_churn____Compare____blob_0_0(
  MR_Word * HeadVar__1_1,
  MR_Word HeadVar__2_2,
  MR_Word HeadVar__3_3)
{
  {
    MR_bool succeeded;
    MR_Integer CastX_27 = (MR_Integer) (HeadVar__2_2);
    MR_Integer CastY_28 = (MR_Integer) (HeadVar__3_3);

    succeeded = (CastX_27 == CastY_28);
    if (succeeded)
      *HeadVar__1_1 = (MR_Integer) 0;
    else
    {
      MR_Integer ArgX1_4 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__2_2, (MR_Integer) 0))));
      MR_Integer ArgY1_5 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__3_3, (MR_Integer) 0))));
      MR_Integer ArgX2_7 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__2_2, (MR_Integer) 1))));
      MR_Integer ArgY2_8 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__3_3, (MR_Integer) 1))));
      MR_Integer ArgX3_10 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__2_2, (MR_Integer) 2))));
      MR_Integer ArgY3_11 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__3_3, (MR_Integer) 2))));
      MR_Integer ArgX4_13 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__2_2, (MR_Integer) 3))));
      MR_Integer ArgY4_14 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__3_3, (MR_Integer) 3))));
      MR_Integer ArgX5_16 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__2_2, (MR_Integer) 4))));
      MR_Integer ArgY5_17 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__3_3, (MR_Integer) 4))));
      MR_Integer ArgX6_19 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__2_2, (MR_Integer) 5))));
      MR_Integer ArgY6_20 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__3_3, (MR_Integer) 5))));
      MR_Integer ArgX7_22 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__2_2, (MR_Integer) 6))));
      MR_Integer ArgY7_23 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__3_3, (MR_Integer) 6))));
      MR_Integer ArgX8_25 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__2_2, (MR_Integer) 7))));
      MR_Integer ArgY8_26 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__3_3, (MR_Integer) 7))));
      MR_Word SubResult1_6;

      succeeded = (ArgX1_4 < ArgY1_5);
      if (succeeded)
        SubResult1_6 = (MR_Integer) 1;
      else
      {
        succeeded = (ArgX1_4 > ArgY1_5);
        if (succeeded)
          SubResult1_6 = (MR_Integer) 2;
        else
          SubResult1_6 = (MR_Integer) 0;
      }
      succeeded = (SubResult1_6 != (MR_Integer) 0);
      if (succeeded)
        *HeadVar__1_1 = SubResult1_6;
      else
      {
        MR_Word SubResult2_9;

        succeeded = (ArgX2_7 < ArgY2_8);
        if (succeeded)
          SubResult2_9 = (MR_Integer) 1;
        else
        {
          succeeded = (ArgX2_7 > ArgY2_8);
          if (succeeded)
            SubResult2_9 = (MR_Integer) 2;
          else
            SubResult2_9 = (MR_Integer) 0;
        }
        succeeded = (SubResult2_9 != (MR_Integer) 0);
        if (succeeded)
          *HeadVar__1_1 = SubResult2_9;
        else
        {
          MR_Word SubResult3_12;

          succeeded = (ArgX3_10 < ArgY3_11);
          if (succeeded)
            SubResult3_12 = (MR_Integer) 1;
          else
          {
            succeeded = (ArgX3_10 > ArgY3_11);
            if (succeeded)
              SubResult3_12 = (MR_Integer) 2;
            else
              SubResult3_12 = (MR_Integer) 0;
          }
          succeeded = (SubResult3_12 != (MR_Integer) 0);
          if (succeeded)
            *HeadVar__1_1 = SubResult3_12;
          else
          {
            MR_Word SubResult4_15;

            succeeded = (ArgX4_13 < ArgY4_14);
            if (succeeded)
              SubResult4_15 = (MR_Integer) 1;
            else
            {
              succeeded = (ArgX4_13 > ArgY4_14);
              if (succeeded)
                SubResult4_15 = (MR_Integer) 2;
              else
                SubResult4_15 = (MR_Integer) 0;
            }
            succeeded = (SubResult4_15 != (MR_Integer) 0);
            if (succeeded)
              *HeadVar__1_1 = SubResult4_15;
            else
            {
              MR_Word SubResult5_18;

              succeeded = (ArgX5_16 < ArgY5_17);
              if (succeeded)
                SubResult5_18 = (MR_Integer) 1;
              else
              {
                succeeded = (ArgX5_16 > ArgY5_17);
                if (succeeded)
                  SubResult5_18 = (MR_Integer) 2;
                else
                  SubResult5_18 = (MR_Integer) 0;
              }
              succeeded = (SubResult5_18 != (MR_Integer) 0);
              if (succeeded)
                *HeadVar__1_1 = SubResult5_18;
              else
              {
                MR_Word SubResult6_21;

                succeeded = (ArgX6_19 < ArgY6_20);
                if (succeeded)
                  SubResult6_21 = (MR_Integer) 1;
                else
                {
                  succeeded = (ArgX6_19 > ArgY6_20);
                  if (succeeded)
                    SubResult6_21 = (MR_Integer) 2;
                  else
                    SubResult6_21 = (MR_Integer) 0;
                }
                succeeded = (SubResult6_21 != (MR_Integer) 0);
                if (succeeded)
                  *HeadVar__1_1 = SubResult6_21;
                else
                {
                  MR_Word SubResult7_24;

                  succeeded = (ArgX7_22 < ArgY7_23);
                  if (succeeded)
                    SubResult7_24 = (MR_Integer) 1;
                  else
                  {
                    succeeded = (ArgX7_22 > ArgY7_23);
                    if (succeeded)
                      SubResult7_24 = (MR_Integer) 2;
                    else
                      SubResult7_24 = (MR_Integer) 0;
                  }
                  succeeded = (SubResult7_24 != (MR_Integer) 0);
                  if (succeeded)
                    *HeadVar__1_1 = SubResult7_24;
                  else
                  {
                    succeeded = (ArgX8_25 < ArgY8_26);
                    if (succeeded)
                      *HeadVar__1_1 = (MR_Integer) 1;
                    else
                    {
                      succeeded = (ArgX8_25 > ArgY8_26);
                      if (succeeded)
                        *HeadVar__1_1 = (MR_Integer) 2;
                      else
                        *HeadVar__1_1 = (MR_Integer) 0;
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

static MR_bool MR_CALL 
m05_alloc_churn____Unify____blob_0_0(
  MR_Word HeadVar__1_1,
  MR_Word HeadVar__2_2)
{
  {
    MR_bool succeeded;
    MR_Integer CastX_19 = (MR_Integer) (HeadVar__1_1);
    MR_Integer CastY_20 = (MR_Integer) (HeadVar__2_2);

    succeeded = (CastX_19 == CastY_20);
    if (succeeded)
      succeeded = MR_TRUE;
    else
    {
      MR_Integer ArgX1_3 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__1_1, (MR_Integer) 0))));
      MR_Integer ArgY1_4 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__2_2, (MR_Integer) 0))));
      MR_Integer ArgX2_5 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__1_1, (MR_Integer) 1))));
      MR_Integer ArgY2_6 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__2_2, (MR_Integer) 1))));
      MR_Integer ArgX3_7 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__1_1, (MR_Integer) 2))));
      MR_Integer ArgY3_8 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__2_2, (MR_Integer) 2))));
      MR_Integer ArgX4_9 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__1_1, (MR_Integer) 3))));
      MR_Integer ArgY4_10 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__2_2, (MR_Integer) 3))));
      MR_Integer ArgX5_11 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__1_1, (MR_Integer) 4))));
      MR_Integer ArgY5_12 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__2_2, (MR_Integer) 4))));
      MR_Integer ArgX6_13 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__1_1, (MR_Integer) 5))));
      MR_Integer ArgY6_14 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__2_2, (MR_Integer) 5))));
      MR_Integer ArgX7_15 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__1_1, (MR_Integer) 6))));
      MR_Integer ArgY7_16 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__2_2, (MR_Integer) 6))));
      MR_Integer ArgX8_17 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__1_1, (MR_Integer) 7))));
      MR_Integer ArgY8_18 = ((MR_Integer) ((MR_hl_field(MR_mktag(0), HeadVar__2_2, (MR_Integer) 7))));

      succeeded = (ArgX1_3 == ArgY1_4);
      if (succeeded)
      {
        succeeded = (ArgX2_5 == ArgY2_6);
        if (succeeded)
        {
          succeeded = (ArgX3_7 == ArgY3_8);
          if (succeeded)
          {
            succeeded = (ArgX4_9 == ArgY4_10);
            if (succeeded)
            {
              succeeded = (ArgX5_11 == ArgY5_12);
              if (succeeded)
              {
                succeeded = (ArgX6_13 == ArgY6_14);
                if (succeeded)
                {
                  succeeded = (ArgX7_15 == ArgY7_16);
                  if (succeeded)
                    succeeded = (ArgX8_17 == ArgY8_18);
                }
              }
            }
          }
        }
      }
    }
    return succeeded;
  }
}

void MR_CALL 
main_2_p_0(void)
{
  {
    MR_Word TypeCtorInfo_42_42;
    MR_Integer SS_T0_4;
    MR_Word Zero_5;
    MR_ArrayPtr Slots0_6;
    MR_Integer Total_8;
    MR_Integer SS_T1_9;
    MR_Integer SS_MS_10;
    MR_Integer Var_22;
    MR_Integer Var_23;
    MR_Integer Var_24;
    MR_Integer Var_25;
    MR_Integer Var_27;
    MR_Integer Var_28;
    MR_Integer Var_29;
    MR_Integer Var_30;
    MR_Word Var_31;
    MR_String Var_44;
    MR_String Var_46;
    MR_Word Var_52;
    MR_String Var_53;
    MR_String Var_55;
    MR_Word Var_61;
    MR_String Var_62;
    MR_ArrayPtr conv0_Slots0_6;
    MR_ArrayPtr _Slots_7;

    mercury__time__clock_3_p_0(&SS_T0_4);
    Zero_5 = (MR_Word) (&m05_alloc_churn_scalar_common_1[0]);
    TypeCtorInfo_42_42 = (MR_Word) (&m05_alloc_churn__m05_alloc_churn__type_ctor_info_blob_0);
    Var_22 = (MR_Integer) 256;
    conv0_Slots0_6 = mercury__array__init_2_f_0(TypeCtorInfo_42_42, Var_22, ((MR_Box) (Zero_5)));
    Slots0_6 = (MR_ArrayPtr) (conv0_Slots0_6);
    Var_23 = (MR_Integer) 0;
    Var_24 = (MR_Integer) 10000000;
    Var_25 = (MR_Integer) 0;
    m05_alloc_churn__churn_6_p_0(Var_23, Var_24, Slots0_6, &_Slots_7, Var_25, &Total_8);
    mercury__time__clock_3_p_0(&SS_T1_9);
    Var_28 = (MR_Integer) ((MR_Unsigned) SS_T1_9 - (MR_Unsigned) SS_T0_4);
    Var_29 = (MR_Integer) 1000;
    Var_27 = (MR_Integer) ((MR_Unsigned) Var_28 * (MR_Unsigned) Var_29);
    Var_30 = mercury__time__clocks_per_sec_0_f_0();
    SS_MS_10 = mercury__int__f_slash_2_f_0(Var_27, Var_30);
    Var_31 = mercury__io__stderr_stream_0_f_0();
    Var_44 = (MR_String) "TIME_MS=";
    mercury__io__write_string_4_p_0(Var_31, Var_44);
    Var_52 = (MR_Word) (&m05_alloc_churn_scalar_common_2[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_52, SS_MS_10, &Var_46);
    mercury__io__write_string_4_p_0(Var_31, Var_46);
    Var_53 = (MR_String) "\n";
    mercury__io__write_string_4_p_0(Var_31, Var_53);
    Var_61 = (MR_Word) (&m05_alloc_churn_scalar_common_2[0]);
    mercury__string__format__format_signed_int_component_nowidth_noprec_3_p_0(Var_61, Total_8, &Var_55);
    mercury__io__write_string_3_p_0(Var_55);
    Var_62 = (MR_String) "\n";
    mercury__io__write_string_3_p_0(Var_62);
  }
}

static void MR_CALL 
m05_alloc_churn__churn_6_p_0(
  MR_Integer I_7,
  MR_Integer N_8,
  MR_ArrayPtr STATE_VARIABLE_Slots_0_13,
  MR_ArrayPtr * STATE_VARIABLE_Slots_14,
  MR_Integer STATE_VARIABLE_Total_0_15,
  MR_Integer * STATE_VARIABLE_Total_16)
{
  while (MR_TRUE)
  {
    MR_bool succeeded = (I_7 >= N_8);

    // setup for model_det tailcalls optimized into a loop
    ;
    if (succeeded)
    {
      *STATE_VARIABLE_Total_16 = STATE_VARIABLE_Total_0_15;
      *STATE_VARIABLE_Slots_14 = STATE_VARIABLE_Slots_0_13;
    }
    else
    {
      MR_Word TypeCtorInfo_31_31;
      MR_Integer V_11;
      MR_Word B_12;
      MR_Integer Var_17 = (MR_Integer) 256;
      MR_ArrayPtr STATE_VARIABLE_Slots_25_25;
      MR_Integer STATE_VARIABLE_Total_26_26;
      MR_Integer Var_27;
      MR_Integer Var_30;
      MR_ArrayPtr conv0_STATE_VARIABLE_Slots_25_25;
      MR_Integer next_value_of_I_7;
      MR_ArrayPtr next_value_of_STATE_VARIABLE_Slots_0_13;
      MR_Integer next_value_of_STATE_VARIABLE_Total_0_15;

      V_11 = mercury__int__mod_2_f_0(I_7, Var_17);
      {
        B_12 = (MR_Word) MR_new_object(MR_Word, (8 * sizeof(MR_Word)), NULL, NULL);
        MR_hl_field(MR_mktag(0), B_12, 0) = ((MR_Box) (V_11));
        MR_hl_field(MR_mktag(0), B_12, 1) = ((MR_Box) (V_11));
        MR_hl_field(MR_mktag(0), B_12, 2) = ((MR_Box) (V_11));
        MR_hl_field(MR_mktag(0), B_12, 3) = ((MR_Box) (V_11));
        MR_hl_field(MR_mktag(0), B_12, 4) = ((MR_Box) (V_11));
        MR_hl_field(MR_mktag(0), B_12, 5) = ((MR_Box) (V_11));
        MR_hl_field(MR_mktag(0), B_12, 6) = ((MR_Box) (V_11));
        MR_hl_field(MR_mktag(0), B_12, 7) = ((MR_Box) (V_11));
      }
      TypeCtorInfo_31_31 = (MR_Word) (&m05_alloc_churn__m05_alloc_churn__type_ctor_info_blob_0);
      mercury__array__set_4_p_0(TypeCtorInfo_31_31, V_11, ((MR_Box) (B_12)), (MR_ArrayPtr) (STATE_VARIABLE_Slots_0_13), &conv0_STATE_VARIABLE_Slots_25_25);
      STATE_VARIABLE_Slots_25_25 = (MR_ArrayPtr) (conv0_STATE_VARIABLE_Slots_25_25);
      STATE_VARIABLE_Total_26_26 = (MR_Integer) ((MR_Unsigned) STATE_VARIABLE_Total_0_15 + (MR_Unsigned) V_11);
      Var_30 = (MR_Integer) 1;
      Var_27 = (MR_Integer) ((MR_Unsigned) I_7 + (MR_Unsigned) Var_30);
      // direct tailcall eliminated
      ;
      next_value_of_I_7 = Var_27;
      next_value_of_STATE_VARIABLE_Slots_0_13 = STATE_VARIABLE_Slots_25_25;
      next_value_of_STATE_VARIABLE_Total_0_15 = STATE_VARIABLE_Total_26_26;
      I_7 = next_value_of_I_7;
      STATE_VARIABLE_Slots_0_13 = next_value_of_STATE_VARIABLE_Slots_0_13;
      STATE_VARIABLE_Total_0_15 = next_value_of_STATE_VARIABLE_Total_0_15;
      continue;
    }
    break;
  }
}

static MR_bool MR_CALL 
m05_alloc_churn____Unify____blob_0_0_10001(
  MR_Box wrapper_arg_1,
  MR_Box wrapper_arg_2)
{
  {
    MR_bool succeeded;

    succeeded = m05_alloc_churn____Unify____blob_0_0(((MR_Word) (wrapper_arg_1)), ((MR_Word) (wrapper_arg_2)));
    return succeeded;
  }
}

static void MR_CALL 
m05_alloc_churn____Compare____blob_0_0_10001(
  MR_Box * wrapper_arg_1,
  MR_Box wrapper_arg_2,
  MR_Box wrapper_arg_3)
{
  {
    MR_Word conv0_HeadVar__1_1;

    m05_alloc_churn____Compare____blob_0_0(&conv0_HeadVar__1_1, ((MR_Word) (wrapper_arg_2)), ((MR_Word) (wrapper_arg_3)));
    *wrapper_arg_1 = ((MR_Box) (conv0_HeadVar__1_1));
  }
}

void mercury__m05_alloc_churn__init(void)
{
}

void mercury__m05_alloc_churn__init_type_tables(void)
{
	static MR_bool initialised = MR_FALSE;
	if (initialised) return;
	initialised = MR_TRUE;

	MR_register_type_ctor_info(&m05_alloc_churn__m05_alloc_churn__type_ctor_info_blob_0);
}

void mercury__m05_alloc_churn__init_debugger(void)
{
	MR_fatal_error("debugger initialization in MLDS grade");
}

// Ensure everything is compiled with the same grade.
const char *mercury__m05_alloc_churn__grade_check(void)
{
    return &MR_GRADE_VAR;
}

// :- end_module m05_alloc_churn.
