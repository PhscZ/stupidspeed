// Lean compiler output
// Module: «15_file_write»
// Imports: public import Init public meta import Init
#include <lean/lean.h>
#if defined(__clang__)
#pragma clang diagnostic ignored "-Wunused-parameter"
#pragma clang diagnostic ignored "-Wunused-label"
#elif defined(__GNUC__) && !defined(__CLANG__)
#pragma GCC diagnostic ignored "-Wunused-parameter"
#pragma GCC diagnostic ignored "-Wunused-label"
#pragma GCC diagnostic ignored "-Wunused-but-set-variable"
#endif
#ifdef __cplusplus
extern "C" {
#endif
lean_object* l_UInt8_ofNat___boxed(lean_object*);
lean_object* l_Array_ofFn___redArg(lean_object*, lean_object*);
lean_object* lean_byte_array_mk(lean_object*);
extern lean_object* l_ByteArray_empty;
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
lean_object* lean_nat_shiftr(lean_object*, lean_object*);
lean_object* lean_byte_array_size(lean_object*);
lean_object* lean_byte_array_copy_slice(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, uint8_t);
lean_object* lean_nat_mod(lean_object*, lean_object*);
uint8_t lean_nat_dec_lt(lean_object*, lean_object*);
lean_object* lean_io_prim_handle_write(lean_object*, lean_object*);
lean_object* lean_io_mono_nanos_now();
lean_object* lean_io_prim_handle_mk(lean_object*, uint8_t);
lean_object* lean_io_prim_handle_flush(lean_object*);
double lean_float_of_nat(lean_object*);
double l_Float_ofScientific(lean_object*, uint8_t, lean_object*);
double lean_float_div(double, double);
lean_object* lean_float_to_string(double);
lean_object* lean_string_append(lean_object*, lean_object*);
lean_object* l_IO_eprintln___at___00__private_Init_System_IO_0__IO_eprintlnAux_spec__0(lean_object*);
lean_object* l_Nat_reprFast(lean_object*);
lean_object* lean_string_push(lean_object*, uint32_t);
lean_object* lean_get_stdout();
LEAN_EXPORT lean_object* l_repeatBytes_go(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_0015__file__write_0__repeatBytes_go_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_0015__file__write_0__repeatBytes_go_match__1_splitter___redArg___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_0015__file__write_0__repeatBytes_go_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_0015__file__write_0__repeatBytes_go_match__1_splitter___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_repeatBytes(lean_object*, lean_object*);
static const lean_closure_object l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)l_UInt8_ofNat___boxed, .m_arity = 1, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__0 = (const lean_object*)&l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__0_value;
static lean_once_cell_t l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__1_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__1;
static lean_once_cell_t l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__2_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__2;
static lean_once_cell_t l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__3_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__3;
static lean_once_cell_t l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__4_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__4;
LEAN_EXPORT lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__1_spec__1(lean_object*);
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__1_spec__1___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__1(lean_object*);
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__1___boxed(lean_object*, lean_object*);
static const lean_string_object l_main___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 8, .m_capacity = 8, .m_length = 7, .m_data = "out.bin"};
static const lean_object* l_main___closed__0 = (const lean_object*)&l_main___closed__0_value;
static const lean_ctor_object l_main___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*3 + 0, .m_other = 3, .m_tag = 0}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)(((size_t)(50) << 1) | 1)),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* l_main___closed__1 = (const lean_object*)&l_main___closed__1_value;
static lean_once_cell_t l_main___closed__2_once = LEAN_ONCE_CELL_INITIALIZER;
static double l_main___closed__2;
static const lean_string_object l_main___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 9, .m_capacity = 9, .m_length = 8, .m_data = "TIME_MS="};
static const lean_object* l_main___closed__3 = (const lean_object*)&l_main___closed__3_value;
LEAN_EXPORT lean_object* _lean_main();
LEAN_EXPORT lean_object* l_main___boxed(lean_object*);
LEAN_EXPORT lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_repeatBytes_go(lean_object* v_a_1_, lean_object* v_a_2_, lean_object* v_a_3_){
_start:
{
lean_object* v_zero_4_; uint8_t v_isZero_5_; 
v_zero_4_ = lean_unsigned_to_nat(0u);
v_isZero_5_ = lean_nat_dec_eq(v_a_1_, v_zero_4_);
if (v_isZero_5_ == 1)
{
lean_dec_ref(v_a_3_);
lean_dec(v_a_1_);
return v_a_2_;
}
else
{
lean_object* v_one_6_; lean_object* v_n_7_; lean_object* v___x_8_; lean_object* v___x_9_; lean_object* v___x_10_; lean_object* v___y_12_; lean_object* v___x_16_; uint8_t v___x_17_; 
v_one_6_ = lean_unsigned_to_nat(1u);
v_n_7_ = lean_nat_sub(v_a_1_, v_one_6_);
lean_dec(v_a_1_);
v___x_8_ = lean_nat_add(v_n_7_, v_one_6_);
lean_dec(v_n_7_);
v___x_9_ = lean_unsigned_to_nat(2u);
v___x_10_ = lean_nat_shiftr(v___x_8_, v_one_6_);
v___x_16_ = lean_nat_mod(v___x_8_, v___x_9_);
lean_dec(v___x_8_);
v___x_17_ = lean_nat_dec_eq(v___x_16_, v_one_6_);
lean_dec(v___x_16_);
if (v___x_17_ == 0)
{
v___y_12_ = v_a_2_;
goto v___jp_11_;
}
else
{
lean_object* v___x_18_; lean_object* v___x_19_; lean_object* v___x_20_; 
v___x_18_ = lean_byte_array_size(v_a_2_);
v___x_19_ = lean_byte_array_size(v_a_3_);
v___x_20_ = lean_byte_array_copy_slice(v_a_3_, v_zero_4_, v_a_2_, v___x_18_, v___x_19_, v_isZero_5_);
v___y_12_ = v___x_20_;
goto v___jp_11_;
}
v___jp_11_:
{
lean_object* v___x_13_; lean_object* v___x_14_; 
v___x_13_ = lean_byte_array_size(v_a_3_);
lean_inc_ref(v_a_3_);
v___x_14_ = lean_byte_array_copy_slice(v_a_3_, v_zero_4_, v_a_3_, v___x_13_, v___x_13_, v_isZero_5_);
lean_dec_ref(v_a_3_);
v_a_1_ = v___x_10_;
v_a_2_ = v___y_12_;
v_a_3_ = v___x_14_;
goto _start;
}
}
}
}
LEAN_EXPORT lean_object* l___private_0015__file__write_0__repeatBytes_go_match__1_splitter___redArg(lean_object* v_x_21_, lean_object* v_x_22_, lean_object* v_x_23_, lean_object* v_h__1_24_, lean_object* v_h__2_25_){
_start:
{
lean_object* v_zero_26_; uint8_t v_isZero_27_; 
v_zero_26_ = lean_unsigned_to_nat(0u);
v_isZero_27_ = lean_nat_dec_eq(v_x_21_, v_zero_26_);
if (v_isZero_27_ == 1)
{
lean_object* v___x_28_; 
lean_dec(v_h__2_25_);
v___x_28_ = lean_apply_2(v_h__1_24_, v_x_22_, v_x_23_);
return v___x_28_;
}
else
{
lean_object* v_one_29_; lean_object* v_n_30_; lean_object* v___x_31_; 
lean_dec(v_h__1_24_);
v_one_29_ = lean_unsigned_to_nat(1u);
v_n_30_ = lean_nat_sub(v_x_21_, v_one_29_);
v___x_31_ = lean_apply_3(v_h__2_25_, v_n_30_, v_x_22_, v_x_23_);
return v___x_31_;
}
}
}
LEAN_EXPORT lean_object* l___private_0015__file__write_0__repeatBytes_go_match__1_splitter___redArg___boxed(lean_object* v_x_32_, lean_object* v_x_33_, lean_object* v_x_34_, lean_object* v_h__1_35_, lean_object* v_h__2_36_){
_start:
{
lean_object* v_res_37_; 
v_res_37_ = l___private_0015__file__write_0__repeatBytes_go_match__1_splitter___redArg(v_x_32_, v_x_33_, v_x_34_, v_h__1_35_, v_h__2_36_);
lean_dec(v_x_32_);
return v_res_37_;
}
}
LEAN_EXPORT lean_object* l___private_0015__file__write_0__repeatBytes_go_match__1_splitter(lean_object* v_motive_38_, lean_object* v_x_39_, lean_object* v_x_40_, lean_object* v_x_41_, lean_object* v_h__1_42_, lean_object* v_h__2_43_){
_start:
{
lean_object* v_zero_44_; uint8_t v_isZero_45_; 
v_zero_44_ = lean_unsigned_to_nat(0u);
v_isZero_45_ = lean_nat_dec_eq(v_x_39_, v_zero_44_);
if (v_isZero_45_ == 1)
{
lean_object* v___x_46_; 
lean_dec(v_h__2_43_);
v___x_46_ = lean_apply_2(v_h__1_42_, v_x_40_, v_x_41_);
return v___x_46_;
}
else
{
lean_object* v_one_47_; lean_object* v_n_48_; lean_object* v___x_49_; 
lean_dec(v_h__1_42_);
v_one_47_ = lean_unsigned_to_nat(1u);
v_n_48_ = lean_nat_sub(v_x_39_, v_one_47_);
v___x_49_ = lean_apply_3(v_h__2_43_, v_n_48_, v_x_40_, v_x_41_);
return v___x_49_;
}
}
}
LEAN_EXPORT lean_object* l___private_0015__file__write_0__repeatBytes_go_match__1_splitter___boxed(lean_object* v_motive_50_, lean_object* v_x_51_, lean_object* v_x_52_, lean_object* v_x_53_, lean_object* v_h__1_54_, lean_object* v_h__2_55_){
_start:
{
lean_object* v_res_56_; 
v_res_56_ = l___private_0015__file__write_0__repeatBytes_go_match__1_splitter(v_motive_50_, v_x_51_, v_x_52_, v_x_53_, v_h__1_54_, v_h__2_55_);
lean_dec(v_x_51_);
return v_res_56_;
}
}
LEAN_EXPORT lean_object* l_repeatBytes(lean_object* v_block_57_, lean_object* v_times_58_){
_start:
{
lean_object* v___x_59_; lean_object* v___x_60_; 
v___x_59_ = l_ByteArray_empty;
v___x_60_ = l_repeatBytes_go(v_times_58_, v___x_59_, v_block_57_);
return v___x_60_;
}
}
static lean_object* _init_l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__1(void){
_start:
{
lean_object* v___f_62_; lean_object* v___x_63_; lean_object* v___x_64_; 
v___f_62_ = ((lean_object*)(l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__0));
v___x_63_ = lean_unsigned_to_nat(256u);
v___x_64_ = l_Array_ofFn___redArg(v___x_63_, v___f_62_);
return v___x_64_;
}
}
static lean_object* _init_l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__2(void){
_start:
{
lean_object* v___x_65_; lean_object* v___x_66_; 
v___x_65_ = lean_obj_once(&l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__1, &l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__1_once, _init_l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__1);
v___x_66_ = lean_byte_array_mk(v___x_65_);
return v___x_66_;
}
}
static lean_object* _init_l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__3(void){
_start:
{
lean_object* v___x_67_; lean_object* v___x_68_; lean_object* v___x_69_; 
v___x_67_ = lean_unsigned_to_nat(4096u);
v___x_68_ = lean_obj_once(&l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__2, &l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__2_once, _init_l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__2);
v___x_69_ = l_repeatBytes(v___x_68_, v___x_67_);
return v___x_69_;
}
}
static lean_object* _init_l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__4(void){
_start:
{
lean_object* v___x_70_; lean_object* v___x_71_; 
v___x_70_ = lean_obj_once(&l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__3, &l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__3_once, _init_l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__3);
v___x_71_ = lean_byte_array_size(v___x_70_);
return v___x_71_;
}
}
LEAN_EXPORT lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg(lean_object* v_a_72_, lean_object* v_range_73_, lean_object* v_b_74_, lean_object* v_i_75_){
_start:
{
lean_object* v_stop_77_; lean_object* v_step_78_; uint8_t v___x_79_; 
v_stop_77_ = lean_ctor_get(v_range_73_, 1);
v_step_78_ = lean_ctor_get(v_range_73_, 2);
v___x_79_ = lean_nat_dec_lt(v_i_75_, v_stop_77_);
if (v___x_79_ == 0)
{
lean_object* v___x_80_; 
lean_dec(v_i_75_);
v___x_80_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v___x_80_, 0, v_b_74_);
return v___x_80_;
}
else
{
lean_object* v___x_81_; lean_object* v___x_82_; 
v___x_81_ = lean_obj_once(&l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__3, &l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__3_once, _init_l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__3);
v___x_82_ = lean_io_prim_handle_write(v_a_72_, v___x_81_);
if (lean_obj_tag(v___x_82_) == 0)
{
lean_object* v___x_83_; lean_object* v___x_84_; lean_object* v___x_85_; 
lean_dec_ref_known(v___x_82_, 1);
v___x_83_ = lean_obj_once(&l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__4, &l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__4_once, _init_l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__4);
v___x_84_ = lean_nat_add(v_b_74_, v___x_83_);
lean_dec(v_b_74_);
v___x_85_ = lean_nat_add(v_i_75_, v_step_78_);
lean_dec(v_i_75_);
v_b_74_ = v___x_84_;
v_i_75_ = v___x_85_;
goto _start;
}
else
{
lean_object* v_a_87_; lean_object* v___x_89_; uint8_t v_isShared_90_; uint8_t v_isSharedCheck_94_; 
lean_dec(v_i_75_);
lean_dec(v_b_74_);
v_a_87_ = lean_ctor_get(v___x_82_, 0);
v_isSharedCheck_94_ = !lean_is_exclusive(v___x_82_);
if (v_isSharedCheck_94_ == 0)
{
v___x_89_ = v___x_82_;
v_isShared_90_ = v_isSharedCheck_94_;
goto v_resetjp_88_;
}
else
{
lean_inc(v_a_87_);
lean_dec(v___x_82_);
v___x_89_ = lean_box(0);
v_isShared_90_ = v_isSharedCheck_94_;
goto v_resetjp_88_;
}
v_resetjp_88_:
{
lean_object* v___x_92_; 
if (v_isShared_90_ == 0)
{
v___x_92_ = v___x_89_;
goto v_reusejp_91_;
}
else
{
lean_object* v_reuseFailAlloc_93_; 
v_reuseFailAlloc_93_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_93_, 0, v_a_87_);
v___x_92_ = v_reuseFailAlloc_93_;
goto v_reusejp_91_;
}
v_reusejp_91_:
{
return v___x_92_;
}
}
}
}
}
}
LEAN_EXPORT lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___boxed(lean_object* v_a_95_, lean_object* v_range_96_, lean_object* v_b_97_, lean_object* v_i_98_, lean_object* v___y_99_){
_start:
{
lean_object* v_res_100_; 
v_res_100_ = l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg(v_a_95_, v_range_96_, v_b_97_, v_i_98_);
lean_dec_ref(v_range_96_);
lean_dec(v_a_95_);
return v_res_100_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__1_spec__1(lean_object* v_s_101_){
_start:
{
lean_object* v___x_103_; lean_object* v_putStr_104_; lean_object* v___x_105_; 
v___x_103_ = lean_get_stdout();
v_putStr_104_ = lean_ctor_get(v___x_103_, 4);
lean_inc_ref(v_putStr_104_);
lean_dec_ref(v___x_103_);
v___x_105_ = lean_apply_2(v_putStr_104_, v_s_101_, lean_box(0));
return v___x_105_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__1_spec__1___boxed(lean_object* v_s_106_, lean_object* v_a_107_){
_start:
{
lean_object* v_res_108_; 
v_res_108_ = l_IO_print___at___00IO_println___at___00main_spec__1_spec__1(v_s_106_);
return v_res_108_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__1(lean_object* v_s_109_){
_start:
{
lean_object* v___x_111_; uint32_t v___x_112_; lean_object* v___x_113_; lean_object* v___x_114_; 
v___x_111_ = l_Nat_reprFast(v_s_109_);
v___x_112_ = 10;
v___x_113_ = lean_string_push(v___x_111_, v___x_112_);
v___x_114_ = l_IO_print___at___00IO_println___at___00main_spec__1_spec__1(v___x_113_);
return v___x_114_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__1___boxed(lean_object* v_s_115_, lean_object* v_a_116_){
_start:
{
lean_object* v_res_117_; 
v_res_117_ = l_IO_println___at___00main_spec__1(v_s_115_);
return v_res_117_;
}
}
static double _init_l_main___closed__2(void){
_start:
{
lean_object* v___x_123_; uint8_t v___x_124_; lean_object* v___x_125_; double v___x_126_; 
v___x_123_ = lean_unsigned_to_nat(1u);
v___x_124_ = 1;
v___x_125_ = lean_unsigned_to_nat(10000000u);
v___x_126_ = l_Float_ofScientific(v___x_125_, v___x_124_, v___x_123_);
return v___x_126_;
}
}
LEAN_EXPORT lean_object* _lean_main(){
_start:
{
lean_object* v___x_129_; lean_object* v___x_130_; uint8_t v___x_131_; lean_object* v___x_132_; 
v___x_129_ = lean_io_mono_nanos_now();
v___x_130_ = ((lean_object*)(l_main___closed__0));
v___x_131_ = 1;
v___x_132_ = lean_io_prim_handle_mk(v___x_130_, v___x_131_);
if (lean_obj_tag(v___x_132_) == 0)
{
lean_object* v_a_133_; lean_object* v___x_134_; lean_object* v___x_135_; lean_object* v___x_136_; 
v_a_133_ = lean_ctor_get(v___x_132_, 0);
lean_inc(v_a_133_);
lean_dec_ref_known(v___x_132_, 1);
v___x_134_ = lean_unsigned_to_nat(0u);
v___x_135_ = ((lean_object*)(l_main___closed__1));
v___x_136_ = l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg(v_a_133_, v___x_135_, v___x_134_, v___x_134_);
if (lean_obj_tag(v___x_136_) == 0)
{
lean_object* v_a_137_; lean_object* v___x_138_; 
v_a_137_ = lean_ctor_get(v___x_136_, 0);
lean_inc(v_a_137_);
lean_dec_ref_known(v___x_136_, 1);
v___x_138_ = lean_io_prim_handle_flush(v_a_133_);
lean_dec(v_a_133_);
if (lean_obj_tag(v___x_138_) == 0)
{
lean_object* v___x_139_; lean_object* v___x_140_; double v___x_141_; double v___x_142_; double v___x_143_; lean_object* v___x_144_; lean_object* v___x_145_; lean_object* v___x_146_; lean_object* v___x_147_; 
lean_dec_ref_known(v___x_138_, 1);
v___x_139_ = lean_io_mono_nanos_now();
v___x_140_ = lean_nat_sub(v___x_139_, v___x_129_);
lean_dec(v___x_129_);
lean_dec(v___x_139_);
v___x_141_ = lean_float_of_nat(v___x_140_);
v___x_142_ = lean_float_once(&l_main___closed__2, &l_main___closed__2_once, _init_l_main___closed__2);
v___x_143_ = lean_float_div(v___x_141_, v___x_142_);
v___x_144_ = ((lean_object*)(l_main___closed__3));
v___x_145_ = lean_float_to_string(v___x_143_);
v___x_146_ = lean_string_append(v___x_144_, v___x_145_);
lean_dec_ref(v___x_145_);
v___x_147_ = l_IO_eprintln___at___00__private_Init_System_IO_0__IO_eprintlnAux_spec__0(v___x_146_);
if (lean_obj_tag(v___x_147_) == 0)
{
lean_object* v___x_148_; 
lean_dec_ref_known(v___x_147_, 1);
v___x_148_ = l_IO_println___at___00main_spec__1(v_a_137_);
return v___x_148_;
}
else
{
lean_dec(v_a_137_);
return v___x_147_;
}
}
else
{
lean_dec(v_a_137_);
lean_dec(v___x_129_);
return v___x_138_;
}
}
else
{
lean_object* v_a_149_; lean_object* v___x_151_; uint8_t v_isShared_152_; uint8_t v_isSharedCheck_156_; 
lean_dec(v_a_133_);
lean_dec(v___x_129_);
v_a_149_ = lean_ctor_get(v___x_136_, 0);
v_isSharedCheck_156_ = !lean_is_exclusive(v___x_136_);
if (v_isSharedCheck_156_ == 0)
{
v___x_151_ = v___x_136_;
v_isShared_152_ = v_isSharedCheck_156_;
goto v_resetjp_150_;
}
else
{
lean_inc(v_a_149_);
lean_dec(v___x_136_);
v___x_151_ = lean_box(0);
v_isShared_152_ = v_isSharedCheck_156_;
goto v_resetjp_150_;
}
v_resetjp_150_:
{
lean_object* v___x_154_; 
if (v_isShared_152_ == 0)
{
v___x_154_ = v___x_151_;
goto v_reusejp_153_;
}
else
{
lean_object* v_reuseFailAlloc_155_; 
v_reuseFailAlloc_155_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_155_, 0, v_a_149_);
v___x_154_ = v_reuseFailAlloc_155_;
goto v_reusejp_153_;
}
v_reusejp_153_:
{
return v___x_154_;
}
}
}
}
else
{
lean_object* v_a_157_; lean_object* v___x_159_; uint8_t v_isShared_160_; uint8_t v_isSharedCheck_164_; 
lean_dec(v___x_129_);
v_a_157_ = lean_ctor_get(v___x_132_, 0);
v_isSharedCheck_164_ = !lean_is_exclusive(v___x_132_);
if (v_isSharedCheck_164_ == 0)
{
v___x_159_ = v___x_132_;
v_isShared_160_ = v_isSharedCheck_164_;
goto v_resetjp_158_;
}
else
{
lean_inc(v_a_157_);
lean_dec(v___x_132_);
v___x_159_ = lean_box(0);
v_isShared_160_ = v_isSharedCheck_164_;
goto v_resetjp_158_;
}
v_resetjp_158_:
{
lean_object* v___x_162_; 
if (v_isShared_160_ == 0)
{
v___x_162_ = v___x_159_;
goto v_reusejp_161_;
}
else
{
lean_object* v_reuseFailAlloc_163_; 
v_reuseFailAlloc_163_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_163_, 0, v_a_157_);
v___x_162_ = v_reuseFailAlloc_163_;
goto v_reusejp_161_;
}
v_reusejp_161_:
{
return v___x_162_;
}
}
}
}
}
LEAN_EXPORT lean_object* l_main___boxed(lean_object* v_a_165_){
_start:
{
lean_object* v_res_166_; 
v_res_166_ = _lean_main();
return v_res_166_;
}
}
LEAN_EXPORT lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0(lean_object* v_a_167_, lean_object* v_range_168_, lean_object* v_b_169_, lean_object* v_i_170_, lean_object* v_hs_171_, lean_object* v_hl_172_){
_start:
{
lean_object* v___x_174_; 
v___x_174_ = l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg(v_a_167_, v_range_168_, v_b_169_, v_i_170_);
return v___x_174_;
}
}
LEAN_EXPORT lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___boxed(lean_object* v_a_175_, lean_object* v_range_176_, lean_object* v_b_177_, lean_object* v_i_178_, lean_object* v_hs_179_, lean_object* v_hl_180_, lean_object* v___y_181_){
_start:
{
lean_object* v_res_182_; 
v_res_182_ = l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0(v_a_175_, v_range_176_, v_b_177_, v_i_178_, v_hs_179_, v_hl_180_);
lean_dec_ref(v_range_176_);
lean_dec(v_a_175_);
return v_res_182_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_0015__file__write(uint8_t builtin) {
lean_object * res;
if (_G_initialized) return lean_io_result_mk_ok(lean_box(0));
_G_initialized = true;
lean_initialize_runtime_module();
res = initialize_Init(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_Init(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
char ** lean_setup_args(int argc, char ** argv);
#if defined(WIN32) || defined(_WIN32)
#include <windows.h>
#endif
lean_object* run_main(int argc, char ** argv) {
    return _lean_main();
}
int main(int argc, char ** argv) {
#if defined(WIN32) || defined(_WIN32)
  SetErrorMode(SEM_FAILCRITICALERRORS);
  SetConsoleOutputCP(CP_UTF8);
#endif
  lean_object* res;
  argv = lean_setup_args(argc, argv);
  res = initialize_0015__file__write(1 /* builtin */);
  lean_io_mark_end_initialization();
  if (lean_io_result_is_ok(res)) {
    lean_dec_ref(res);
    lean_init_task_manager();
    res = lean_run_main(&run_main, argc, argv);
  }
  lean_finalize_task_manager();
  if (lean_io_result_is_ok(res)) {
    int ret = 0;
    lean_dec_ref(res);
    return ret;
  } else {
    lean_io_result_show_error(res);
    lean_dec_ref(res);
    return 1;
  }
}
#ifdef __cplusplus
}
#endif
