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
uint8_t lean_nat_dec_lt(lean_object*, lean_object*);
lean_object* lean_io_prim_handle_mk(lean_object*, uint8_t);
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
lean_object* lean_io_prim_handle_write(lean_object*, lean_object*);
lean_object* lean_io_prim_handle_flush(lean_object*);
lean_object* lean_nat_mul(lean_object*, lean_object*);
lean_object* lean_io_mono_nanos_now();
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
LEAN_EXPORT lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
static const lean_string_object l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 8, .m_capacity = 8, .m_length = 7, .m_data = "out.bin"};
static const lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg___closed__0 = (const lean_object*)&l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg___closed__0_value;
static const lean_ctor_object l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*3 + 0, .m_other = 3, .m_tag = 0}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)(((size_t)(50) << 1) | 1)),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg___closed__1 = (const lean_object*)&l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg___closed__1_value;
static lean_once_cell_t l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg___closed__2_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg___closed__2;
static lean_once_cell_t l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg___closed__3_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg___closed__3;
LEAN_EXPORT lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__2_spec__2(lean_object*);
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__2_spec__2___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__2(lean_object*);
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__2___boxed(lean_object*, lean_object*);
static const lean_ctor_object l_main___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*3 + 0, .m_other = 3, .m_tag = 0}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)(((size_t)(8) << 1) | 1)),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* l_main___closed__0 = (const lean_object*)&l_main___closed__0_value;
static lean_once_cell_t l_main___closed__1_once = LEAN_ONCE_CELL_INITIALIZER;
static double l_main___closed__1;
static const lean_string_object l_main___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 9, .m_capacity = 9, .m_length = 8, .m_data = "TIME_MS="};
static const lean_object* l_main___closed__2 = (const lean_object*)&l_main___closed__2_value;
LEAN_EXPORT lean_object* _lean_main();
LEAN_EXPORT lean_object* l_main___boxed(lean_object*);
LEAN_EXPORT lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
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
LEAN_EXPORT lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg(lean_object* v_a_70_, lean_object* v_range_71_, lean_object* v_b_72_, lean_object* v_i_73_){
_start:
{
lean_object* v_stop_75_; lean_object* v_step_76_; uint8_t v___x_77_; 
v_stop_75_ = lean_ctor_get(v_range_71_, 1);
v_step_76_ = lean_ctor_get(v_range_71_, 2);
v___x_77_ = lean_nat_dec_lt(v_i_73_, v_stop_75_);
if (v___x_77_ == 0)
{
lean_object* v___x_78_; 
lean_dec(v_i_73_);
v___x_78_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v___x_78_, 0, v_b_72_);
return v___x_78_;
}
else
{
lean_object* v___x_79_; lean_object* v___x_80_; 
v___x_79_ = lean_obj_once(&l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__3, &l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__3_once, _init_l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__3);
v___x_80_ = lean_io_prim_handle_write(v_a_70_, v___x_79_);
if (lean_obj_tag(v___x_80_) == 0)
{
lean_object* v___x_81_; lean_object* v___x_82_; 
lean_dec_ref_known(v___x_80_, 1);
v___x_81_ = lean_box(0);
v___x_82_ = lean_nat_add(v_i_73_, v_step_76_);
lean_dec(v_i_73_);
v_b_72_ = v___x_81_;
v_i_73_ = v___x_82_;
goto _start;
}
else
{
lean_dec(v_i_73_);
return v___x_80_;
}
}
}
}
LEAN_EXPORT lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___boxed(lean_object* v_a_84_, lean_object* v_range_85_, lean_object* v_b_86_, lean_object* v_i_87_, lean_object* v___y_88_){
_start:
{
lean_object* v_res_89_; 
v_res_89_ = l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg(v_a_84_, v_range_85_, v_b_86_, v_i_87_);
lean_dec_ref(v_range_85_);
lean_dec(v_a_84_);
return v_res_89_;
}
}
static lean_object* _init_l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg___closed__2(void){
_start:
{
lean_object* v___x_95_; lean_object* v___x_96_; 
v___x_95_ = lean_obj_once(&l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__3, &l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__3_once, _init_l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg___closed__3);
v___x_96_ = lean_byte_array_size(v___x_95_);
return v___x_96_;
}
}
static lean_object* _init_l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg___closed__3(void){
_start:
{
lean_object* v___x_97_; lean_object* v___x_98_; lean_object* v___x_99_; 
v___x_97_ = lean_obj_once(&l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg___closed__2, &l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg___closed__2_once, _init_l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg___closed__2);
v___x_98_ = lean_unsigned_to_nat(50u);
v___x_99_ = lean_nat_mul(v___x_98_, v___x_97_);
return v___x_99_;
}
}
LEAN_EXPORT lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg(lean_object* v_range_100_, lean_object* v_b_101_, lean_object* v_i_102_){
_start:
{
lean_object* v_stop_104_; lean_object* v_step_105_; uint8_t v___x_106_; 
v_stop_104_ = lean_ctor_get(v_range_100_, 1);
v_step_105_ = lean_ctor_get(v_range_100_, 2);
v___x_106_ = lean_nat_dec_lt(v_i_102_, v_stop_104_);
if (v___x_106_ == 0)
{
lean_object* v___x_107_; 
lean_dec(v_i_102_);
v___x_107_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v___x_107_, 0, v_b_101_);
return v___x_107_;
}
else
{
lean_object* v___x_108_; uint8_t v___x_109_; lean_object* v___x_110_; 
v___x_108_ = ((lean_object*)(l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg___closed__0));
v___x_109_ = 1;
v___x_110_ = lean_io_prim_handle_mk(v___x_108_, v___x_109_);
if (lean_obj_tag(v___x_110_) == 0)
{
lean_object* v_a_111_; lean_object* v___x_112_; lean_object* v___x_113_; lean_object* v___x_114_; lean_object* v___x_115_; 
v_a_111_ = lean_ctor_get(v___x_110_, 0);
lean_inc(v_a_111_);
lean_dec_ref_known(v___x_110_, 1);
v___x_112_ = lean_unsigned_to_nat(0u);
v___x_113_ = ((lean_object*)(l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg___closed__1));
v___x_114_ = lean_box(0);
v___x_115_ = l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg(v_a_111_, v___x_113_, v___x_114_, v___x_112_);
if (lean_obj_tag(v___x_115_) == 0)
{
lean_object* v___x_116_; 
lean_dec_ref_known(v___x_115_, 1);
v___x_116_ = lean_io_prim_handle_flush(v_a_111_);
lean_dec(v_a_111_);
if (lean_obj_tag(v___x_116_) == 0)
{
lean_object* v___x_117_; lean_object* v___x_118_; lean_object* v___x_119_; 
lean_dec_ref_known(v___x_116_, 1);
v___x_117_ = lean_obj_once(&l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg___closed__3, &l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg___closed__3_once, _init_l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg___closed__3);
v___x_118_ = lean_nat_add(v_b_101_, v___x_117_);
lean_dec(v_b_101_);
v___x_119_ = lean_nat_add(v_i_102_, v_step_105_);
lean_dec(v_i_102_);
v_b_101_ = v___x_118_;
v_i_102_ = v___x_119_;
goto _start;
}
else
{
lean_object* v_a_121_; lean_object* v___x_123_; uint8_t v_isShared_124_; uint8_t v_isSharedCheck_128_; 
lean_dec(v_i_102_);
lean_dec(v_b_101_);
v_a_121_ = lean_ctor_get(v___x_116_, 0);
v_isSharedCheck_128_ = !lean_is_exclusive(v___x_116_);
if (v_isSharedCheck_128_ == 0)
{
v___x_123_ = v___x_116_;
v_isShared_124_ = v_isSharedCheck_128_;
goto v_resetjp_122_;
}
else
{
lean_inc(v_a_121_);
lean_dec(v___x_116_);
v___x_123_ = lean_box(0);
v_isShared_124_ = v_isSharedCheck_128_;
goto v_resetjp_122_;
}
v_resetjp_122_:
{
lean_object* v___x_126_; 
if (v_isShared_124_ == 0)
{
v___x_126_ = v___x_123_;
goto v_reusejp_125_;
}
else
{
lean_object* v_reuseFailAlloc_127_; 
v_reuseFailAlloc_127_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_127_, 0, v_a_121_);
v___x_126_ = v_reuseFailAlloc_127_;
goto v_reusejp_125_;
}
v_reusejp_125_:
{
return v___x_126_;
}
}
}
}
else
{
lean_object* v_a_129_; lean_object* v___x_131_; uint8_t v_isShared_132_; uint8_t v_isSharedCheck_136_; 
lean_dec(v_a_111_);
lean_dec(v_i_102_);
lean_dec(v_b_101_);
v_a_129_ = lean_ctor_get(v___x_115_, 0);
v_isSharedCheck_136_ = !lean_is_exclusive(v___x_115_);
if (v_isSharedCheck_136_ == 0)
{
v___x_131_ = v___x_115_;
v_isShared_132_ = v_isSharedCheck_136_;
goto v_resetjp_130_;
}
else
{
lean_inc(v_a_129_);
lean_dec(v___x_115_);
v___x_131_ = lean_box(0);
v_isShared_132_ = v_isSharedCheck_136_;
goto v_resetjp_130_;
}
v_resetjp_130_:
{
lean_object* v___x_134_; 
if (v_isShared_132_ == 0)
{
v___x_134_ = v___x_131_;
goto v_reusejp_133_;
}
else
{
lean_object* v_reuseFailAlloc_135_; 
v_reuseFailAlloc_135_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_135_, 0, v_a_129_);
v___x_134_ = v_reuseFailAlloc_135_;
goto v_reusejp_133_;
}
v_reusejp_133_:
{
return v___x_134_;
}
}
}
}
else
{
lean_object* v_a_137_; lean_object* v___x_139_; uint8_t v_isShared_140_; uint8_t v_isSharedCheck_144_; 
lean_dec(v_i_102_);
lean_dec(v_b_101_);
v_a_137_ = lean_ctor_get(v___x_110_, 0);
v_isSharedCheck_144_ = !lean_is_exclusive(v___x_110_);
if (v_isSharedCheck_144_ == 0)
{
v___x_139_ = v___x_110_;
v_isShared_140_ = v_isSharedCheck_144_;
goto v_resetjp_138_;
}
else
{
lean_inc(v_a_137_);
lean_dec(v___x_110_);
v___x_139_ = lean_box(0);
v_isShared_140_ = v_isSharedCheck_144_;
goto v_resetjp_138_;
}
v_resetjp_138_:
{
lean_object* v___x_142_; 
if (v_isShared_140_ == 0)
{
v___x_142_ = v___x_139_;
goto v_reusejp_141_;
}
else
{
lean_object* v_reuseFailAlloc_143_; 
v_reuseFailAlloc_143_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_143_, 0, v_a_137_);
v___x_142_ = v_reuseFailAlloc_143_;
goto v_reusejp_141_;
}
v_reusejp_141_:
{
return v___x_142_;
}
}
}
}
}
}
LEAN_EXPORT lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg___boxed(lean_object* v_range_145_, lean_object* v_b_146_, lean_object* v_i_147_, lean_object* v___y_148_){
_start:
{
lean_object* v_res_149_; 
v_res_149_ = l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg(v_range_145_, v_b_146_, v_i_147_);
lean_dec_ref(v_range_145_);
return v_res_149_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__2_spec__2(lean_object* v_s_150_){
_start:
{
lean_object* v___x_152_; lean_object* v_putStr_153_; lean_object* v___x_154_; 
v___x_152_ = lean_get_stdout();
v_putStr_153_ = lean_ctor_get(v___x_152_, 4);
lean_inc_ref(v_putStr_153_);
lean_dec_ref(v___x_152_);
v___x_154_ = lean_apply_2(v_putStr_153_, v_s_150_, lean_box(0));
return v___x_154_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__2_spec__2___boxed(lean_object* v_s_155_, lean_object* v_a_156_){
_start:
{
lean_object* v_res_157_; 
v_res_157_ = l_IO_print___at___00IO_println___at___00main_spec__2_spec__2(v_s_155_);
return v_res_157_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__2(lean_object* v_s_158_){
_start:
{
lean_object* v___x_160_; uint32_t v___x_161_; lean_object* v___x_162_; lean_object* v___x_163_; 
v___x_160_ = l_Nat_reprFast(v_s_158_);
v___x_161_ = 10;
v___x_162_ = lean_string_push(v___x_160_, v___x_161_);
v___x_163_ = l_IO_print___at___00IO_println___at___00main_spec__2_spec__2(v___x_162_);
return v___x_163_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__2___boxed(lean_object* v_s_164_, lean_object* v_a_165_){
_start:
{
lean_object* v_res_166_; 
v_res_166_ = l_IO_println___at___00main_spec__2(v_s_164_);
return v_res_166_;
}
}
static double _init_l_main___closed__1(void){
_start:
{
lean_object* v___x_171_; uint8_t v___x_172_; lean_object* v___x_173_; double v___x_174_; 
v___x_171_ = lean_unsigned_to_nat(1u);
v___x_172_ = 1;
v___x_173_ = lean_unsigned_to_nat(10000000u);
v___x_174_ = l_Float_ofScientific(v___x_173_, v___x_172_, v___x_171_);
return v___x_174_;
}
}
LEAN_EXPORT lean_object* _lean_main(){
_start:
{
lean_object* v___x_177_; lean_object* v___x_178_; lean_object* v___x_179_; lean_object* v___x_180_; 
v___x_177_ = lean_io_mono_nanos_now();
v___x_178_ = lean_unsigned_to_nat(0u);
v___x_179_ = ((lean_object*)(l_main___closed__0));
v___x_180_ = l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg(v___x_179_, v___x_178_, v___x_178_);
if (lean_obj_tag(v___x_180_) == 0)
{
lean_object* v_a_181_; lean_object* v___x_182_; lean_object* v___x_183_; double v___x_184_; double v___x_185_; double v___x_186_; lean_object* v___x_187_; lean_object* v___x_188_; lean_object* v___x_189_; lean_object* v___x_190_; 
v_a_181_ = lean_ctor_get(v___x_180_, 0);
lean_inc(v_a_181_);
lean_dec_ref_known(v___x_180_, 1);
v___x_182_ = lean_io_mono_nanos_now();
v___x_183_ = lean_nat_sub(v___x_182_, v___x_177_);
lean_dec(v___x_177_);
lean_dec(v___x_182_);
v___x_184_ = lean_float_of_nat(v___x_183_);
v___x_185_ = lean_float_once(&l_main___closed__1, &l_main___closed__1_once, _init_l_main___closed__1);
v___x_186_ = lean_float_div(v___x_184_, v___x_185_);
v___x_187_ = ((lean_object*)(l_main___closed__2));
v___x_188_ = lean_float_to_string(v___x_186_);
v___x_189_ = lean_string_append(v___x_187_, v___x_188_);
lean_dec_ref(v___x_188_);
v___x_190_ = l_IO_eprintln___at___00__private_Init_System_IO_0__IO_eprintlnAux_spec__0(v___x_189_);
if (lean_obj_tag(v___x_190_) == 0)
{
lean_object* v___x_191_; 
lean_dec_ref_known(v___x_190_, 1);
v___x_191_ = l_IO_println___at___00main_spec__2(v_a_181_);
return v___x_191_;
}
else
{
lean_dec(v_a_181_);
return v___x_190_;
}
}
else
{
lean_object* v_a_192_; lean_object* v___x_194_; uint8_t v_isShared_195_; uint8_t v_isSharedCheck_199_; 
lean_dec(v___x_177_);
v_a_192_ = lean_ctor_get(v___x_180_, 0);
v_isSharedCheck_199_ = !lean_is_exclusive(v___x_180_);
if (v_isSharedCheck_199_ == 0)
{
v___x_194_ = v___x_180_;
v_isShared_195_ = v_isSharedCheck_199_;
goto v_resetjp_193_;
}
else
{
lean_inc(v_a_192_);
lean_dec(v___x_180_);
v___x_194_ = lean_box(0);
v_isShared_195_ = v_isSharedCheck_199_;
goto v_resetjp_193_;
}
v_resetjp_193_:
{
lean_object* v___x_197_; 
if (v_isShared_195_ == 0)
{
v___x_197_ = v___x_194_;
goto v_reusejp_196_;
}
else
{
lean_object* v_reuseFailAlloc_198_; 
v_reuseFailAlloc_198_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_198_, 0, v_a_192_);
v___x_197_ = v_reuseFailAlloc_198_;
goto v_reusejp_196_;
}
v_reusejp_196_:
{
return v___x_197_;
}
}
}
}
}
LEAN_EXPORT lean_object* l_main___boxed(lean_object* v_a_200_){
_start:
{
lean_object* v_res_201_; 
v_res_201_ = _lean_main();
return v_res_201_;
}
}
LEAN_EXPORT lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0(lean_object* v_a_202_, lean_object* v_range_203_, lean_object* v_b_204_, lean_object* v_i_205_, lean_object* v_hs_206_, lean_object* v_hl_207_){
_start:
{
lean_object* v___x_209_; 
v___x_209_ = l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___redArg(v_a_202_, v_range_203_, v_b_204_, v_i_205_);
return v___x_209_;
}
}
LEAN_EXPORT lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0___boxed(lean_object* v_a_210_, lean_object* v_range_211_, lean_object* v_b_212_, lean_object* v_i_213_, lean_object* v_hs_214_, lean_object* v_hl_215_, lean_object* v___y_216_){
_start:
{
lean_object* v_res_217_; 
v_res_217_ = l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__0(v_a_210_, v_range_211_, v_b_212_, v_i_213_, v_hs_214_, v_hl_215_);
lean_dec_ref(v_range_211_);
lean_dec(v_a_210_);
return v_res_217_;
}
}
LEAN_EXPORT lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1(lean_object* v_range_218_, lean_object* v_b_219_, lean_object* v_i_220_, lean_object* v_hs_221_, lean_object* v_hl_222_){
_start:
{
lean_object* v___x_224_; 
v___x_224_ = l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___redArg(v_range_218_, v_b_219_, v_i_220_);
return v___x_224_;
}
}
LEAN_EXPORT lean_object* l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1___boxed(lean_object* v_range_225_, lean_object* v_b_226_, lean_object* v_i_227_, lean_object* v_hs_228_, lean_object* v_hl_229_, lean_object* v___y_230_){
_start:
{
lean_object* v_res_231_; 
v_res_231_ = l___private_Init_Data_Range_Basic_0__Std_Legacy_Range_forIn_x27_loop___at___00main_spec__1(v_range_225_, v_b_226_, v_i_227_, v_hs_228_, v_hl_229_);
lean_dec_ref(v_range_225_);
return v_res_231_;
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
