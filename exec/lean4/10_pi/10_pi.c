// Lean compiler output
// Module: «10_pi»
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
lean_object* lean_nat_to_int(lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
uint8_t lean_nat_dec_le(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
lean_object* lean_int_mul(lean_object*, lean_object*);
lean_object* lean_int_add(lean_object*, lean_object*);
lean_object* lean_int_sub(lean_object*, lean_object*);
uint8_t lean_int_dec_lt(lean_object*, lean_object*);
lean_object* lean_int_ediv(lean_object*, lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
lean_object* l_Int_toNat(lean_object*);
lean_object* l_IO_lazyPure___redArg(lean_object*);
lean_object* lean_io_mono_nanos_now();
lean_object* lean_nat_mul(lean_object*, lean_object*);
lean_object* l_Nat_reprFast(lean_object*);
lean_object* lean_string_append(lean_object*, lean_object*);
double lean_float_of_nat(lean_object*);
double l_Float_ofScientific(lean_object*, uint8_t, lean_object*);
double lean_float_div(double, double);
lean_object* lean_float_to_string(double);
lean_object* l_IO_eprintln___at___00__private_Init_System_IO_0__IO_eprintlnAux_spec__0(lean_object*);
lean_object* lean_string_push(lean_object*, uint32_t);
lean_object* lean_get_stdout();
static lean_once_cell_t l_instInhabitedSt_default___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_instInhabitedSt_default___closed__0;
static lean_once_cell_t l_instInhabitedSt_default___closed__1_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_instInhabitedSt_default___closed__1;
LEAN_EXPORT lean_object* l_instInhabitedSt_default;
LEAN_EXPORT lean_object* l_instInhabitedSt;
static lean_once_cell_t l_spigot_go___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_spigot_go___closed__0;
static lean_once_cell_t l_spigot_go___closed__1_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_spigot_go___closed__1;
static lean_once_cell_t l_spigot_go___closed__2_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_spigot_go___closed__2;
static lean_once_cell_t l_spigot_go___closed__3_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_spigot_go___closed__3;
static lean_once_cell_t l_spigot_go___closed__4_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_spigot_go___closed__4;
static lean_once_cell_t l_spigot_go___closed__5_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_spigot_go___closed__5;
LEAN_EXPORT lean_object* l_spigot_go(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_spigot_go___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
static lean_once_cell_t l_spigot___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_spigot___closed__0;
LEAN_EXPORT lean_object* l_spigot(lean_object*);
LEAN_EXPORT lean_object* l_spigot___boxed(lean_object*);
LEAN_EXPORT lean_object* l_forceIO___redArg(lean_object*);
LEAN_EXPORT lean_object* l_forceIO___redArg___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_forceIO(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_forceIO___boxed(lean_object*, lean_object*, lean_object*);
static lean_once_cell_t l_main___lam__0___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_main___lam__0___closed__0;
LEAN_EXPORT lean_object* l_main___lam__0(lean_object*);
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(lean_object*);
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0(lean_object*);
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0___boxed(lean_object*, lean_object*);
static const lean_closure_object l_main___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)l_main___lam__0, .m_arity = 1, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* l_main___closed__0 = (const lean_object*)&l_main___closed__0_value;
static const lean_string_object l_main___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 22, .m_capacity = 22, .m_length = 21, .m_data = "spigot stopped after "};
static const lean_object* l_main___closed__1 = (const lean_object*)&l_main___closed__1_value;
static const lean_string_object l_main___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 8, .m_capacity = 8, .m_length = 7, .m_data = " digits"};
static const lean_object* l_main___closed__2 = (const lean_object*)&l_main___closed__2_value;
static const lean_string_object l_main___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 9, .m_capacity = 9, .m_length = 8, .m_data = "TIME_MS="};
static const lean_object* l_main___closed__3 = (const lean_object*)&l_main___closed__3_value;
LEAN_EXPORT lean_object* _lean_main();
LEAN_EXPORT lean_object* l_main___boxed(lean_object*);
static lean_object* _init_l_instInhabitedSt_default___closed__0(void){
_start:
{
lean_object* v___x_1_; lean_object* v___x_2_; 
v___x_1_ = lean_unsigned_to_nat(0u);
v___x_2_ = lean_nat_to_int(v___x_1_);
return v___x_2_;
}
}
static lean_object* _init_l_instInhabitedSt_default___closed__1(void){
_start:
{
lean_object* v___x_3_; lean_object* v___x_4_; 
v___x_3_ = lean_obj_once(&l_instInhabitedSt_default___closed__0, &l_instInhabitedSt_default___closed__0_once, _init_l_instInhabitedSt_default___closed__0);
v___x_4_ = lean_alloc_ctor(0, 6, 0);
lean_ctor_set(v___x_4_, 0, v___x_3_);
lean_ctor_set(v___x_4_, 1, v___x_3_);
lean_ctor_set(v___x_4_, 2, v___x_3_);
lean_ctor_set(v___x_4_, 3, v___x_3_);
lean_ctor_set(v___x_4_, 4, v___x_3_);
lean_ctor_set(v___x_4_, 5, v___x_3_);
return v___x_4_;
}
}
static lean_object* _init_l_instInhabitedSt_default(void){
_start:
{
lean_object* v___x_5_; 
v___x_5_ = lean_obj_once(&l_instInhabitedSt_default___closed__1, &l_instInhabitedSt_default___closed__1_once, _init_l_instInhabitedSt_default___closed__1);
return v___x_5_;
}
}
static lean_object* _init_l_instInhabitedSt(void){
_start:
{
lean_object* v___x_6_; 
v___x_6_ = l_instInhabitedSt_default;
return v___x_6_;
}
}
static lean_object* _init_l_spigot_go___closed__0(void){
_start:
{
lean_object* v___x_7_; lean_object* v___x_8_; 
v___x_7_ = lean_unsigned_to_nat(4u);
v___x_8_ = lean_nat_to_int(v___x_7_);
return v___x_8_;
}
}
static lean_object* _init_l_spigot_go___closed__1(void){
_start:
{
lean_object* v___x_9_; lean_object* v___x_10_; 
v___x_9_ = lean_unsigned_to_nat(2u);
v___x_10_ = lean_nat_to_int(v___x_9_);
return v___x_10_;
}
}
static lean_object* _init_l_spigot_go___closed__2(void){
_start:
{
lean_object* v_one_11_; lean_object* v___x_12_; 
v_one_11_ = lean_unsigned_to_nat(1u);
v___x_12_ = lean_nat_to_int(v_one_11_);
return v___x_12_;
}
}
static lean_object* _init_l_spigot_go___closed__3(void){
_start:
{
lean_object* v___x_13_; lean_object* v___x_14_; 
v___x_13_ = lean_unsigned_to_nat(7u);
v___x_14_ = lean_nat_to_int(v___x_13_);
return v___x_14_;
}
}
static lean_object* _init_l_spigot_go___closed__4(void){
_start:
{
lean_object* v___x_15_; lean_object* v___x_16_; 
v___x_15_ = lean_unsigned_to_nat(10u);
v___x_16_ = lean_nat_to_int(v___x_15_);
return v___x_16_;
}
}
static lean_object* _init_l_spigot_go___closed__5(void){
_start:
{
lean_object* v___x_17_; lean_object* v___x_18_; 
v___x_17_ = lean_unsigned_to_nat(3u);
v___x_18_ = lean_nat_to_int(v___x_17_);
return v___x_18_;
}
}
LEAN_EXPORT lean_object* l_spigot_go(lean_object* v_digits_19_, lean_object* v_a_20_, lean_object* v_a_21_, lean_object* v_a_22_, lean_object* v_a_23_){
_start:
{
lean_object* v_zero_24_; uint8_t v_isZero_25_; 
v_zero_24_ = lean_unsigned_to_nat(0u);
v_isZero_25_ = lean_nat_dec_eq(v_a_20_, v_zero_24_);
if (v_isZero_25_ == 1)
{
lean_object* v___x_26_; 
lean_dec_ref(v_a_21_);
lean_dec(v_a_20_);
v___x_26_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_26_, 0, v_a_23_);
lean_ctor_set(v___x_26_, 1, v_a_22_);
return v___x_26_;
}
else
{
uint8_t v___x_27_; 
v___x_27_ = lean_nat_dec_le(v_digits_19_, v_a_22_);
if (v___x_27_ == 0)
{
lean_object* v_q_28_; lean_object* v_r_29_; lean_object* v_t_30_; lean_object* v_k_31_; lean_object* v_n_32_; lean_object* v_l_33_; lean_object* v___x_35_; uint8_t v_isShared_36_; uint8_t v_isSharedCheck_83_; 
v_q_28_ = lean_ctor_get(v_a_21_, 0);
v_r_29_ = lean_ctor_get(v_a_21_, 1);
v_t_30_ = lean_ctor_get(v_a_21_, 2);
v_k_31_ = lean_ctor_get(v_a_21_, 3);
v_n_32_ = lean_ctor_get(v_a_21_, 4);
v_l_33_ = lean_ctor_get(v_a_21_, 5);
v_isSharedCheck_83_ = !lean_is_exclusive(v_a_21_);
if (v_isSharedCheck_83_ == 0)
{
v___x_35_ = v_a_21_;
v_isShared_36_ = v_isSharedCheck_83_;
goto v_resetjp_34_;
}
else
{
lean_inc(v_l_33_);
lean_inc(v_n_32_);
lean_inc(v_k_31_);
lean_inc(v_t_30_);
lean_inc(v_r_29_);
lean_inc(v_q_28_);
lean_dec(v_a_21_);
v___x_35_ = lean_box(0);
v_isShared_36_ = v_isSharedCheck_83_;
goto v_resetjp_34_;
}
v_resetjp_34_:
{
lean_object* v_one_37_; lean_object* v_n_38_; lean_object* v___x_39_; lean_object* v___x_40_; lean_object* v___x_41_; lean_object* v___x_42_; lean_object* v___x_43_; uint8_t v___x_44_; 
v_one_37_ = lean_unsigned_to_nat(1u);
v_n_38_ = lean_nat_sub(v_a_20_, v_one_37_);
lean_dec(v_a_20_);
v___x_39_ = lean_obj_once(&l_spigot_go___closed__0, &l_spigot_go___closed__0_once, _init_l_spigot_go___closed__0);
v___x_40_ = lean_int_mul(v___x_39_, v_q_28_);
v___x_41_ = lean_int_add(v___x_40_, v_r_29_);
lean_dec(v___x_40_);
v___x_42_ = lean_int_sub(v___x_41_, v_t_30_);
lean_dec(v___x_41_);
v___x_43_ = lean_int_mul(v_n_32_, v_t_30_);
v___x_44_ = lean_int_dec_lt(v___x_42_, v___x_43_);
lean_dec(v___x_42_);
if (v___x_44_ == 0)
{
lean_object* v___x_45_; lean_object* v___x_46_; lean_object* v___x_47_; lean_object* v___x_48_; lean_object* v___x_49_; lean_object* v___x_50_; lean_object* v___x_51_; lean_object* v___x_52_; lean_object* v___x_53_; lean_object* v___x_54_; lean_object* v___x_55_; lean_object* v___x_56_; lean_object* v___x_57_; lean_object* v___x_58_; lean_object* v___x_59_; lean_object* v___x_60_; lean_object* v___x_62_; 
lean_dec(v___x_43_);
lean_dec(v_n_32_);
v___x_45_ = lean_int_mul(v_q_28_, v_k_31_);
v___x_46_ = lean_obj_once(&l_spigot_go___closed__1, &l_spigot_go___closed__1_once, _init_l_spigot_go___closed__1);
v___x_47_ = lean_int_mul(v___x_46_, v_q_28_);
v___x_48_ = lean_int_add(v___x_47_, v_r_29_);
lean_dec(v___x_47_);
v___x_49_ = lean_int_mul(v___x_48_, v_l_33_);
lean_dec(v___x_48_);
v___x_50_ = lean_int_mul(v_t_30_, v_l_33_);
lean_dec(v_t_30_);
v___x_51_ = lean_obj_once(&l_spigot_go___closed__2, &l_spigot_go___closed__2_once, _init_l_spigot_go___closed__2);
v___x_52_ = lean_int_add(v_k_31_, v___x_51_);
v___x_53_ = lean_obj_once(&l_spigot_go___closed__3, &l_spigot_go___closed__3_once, _init_l_spigot_go___closed__3);
v___x_54_ = lean_int_mul(v___x_53_, v_k_31_);
lean_dec(v_k_31_);
v___x_55_ = lean_int_add(v___x_54_, v___x_46_);
lean_dec(v___x_54_);
v___x_56_ = lean_int_mul(v_q_28_, v___x_55_);
lean_dec(v___x_55_);
lean_dec(v_q_28_);
v___x_57_ = lean_int_mul(v_r_29_, v_l_33_);
lean_dec(v_r_29_);
v___x_58_ = lean_int_add(v___x_56_, v___x_57_);
lean_dec(v___x_57_);
lean_dec(v___x_56_);
v___x_59_ = lean_int_ediv(v___x_58_, v___x_50_);
lean_dec(v___x_58_);
v___x_60_ = lean_int_add(v_l_33_, v___x_46_);
lean_dec(v_l_33_);
if (v_isShared_36_ == 0)
{
lean_ctor_set(v___x_35_, 5, v___x_60_);
lean_ctor_set(v___x_35_, 4, v___x_59_);
lean_ctor_set(v___x_35_, 3, v___x_52_);
lean_ctor_set(v___x_35_, 2, v___x_50_);
lean_ctor_set(v___x_35_, 1, v___x_49_);
lean_ctor_set(v___x_35_, 0, v___x_45_);
v___x_62_ = v___x_35_;
goto v_reusejp_61_;
}
else
{
lean_object* v_reuseFailAlloc_64_; 
v_reuseFailAlloc_64_ = lean_alloc_ctor(0, 6, 0);
lean_ctor_set(v_reuseFailAlloc_64_, 0, v___x_45_);
lean_ctor_set(v_reuseFailAlloc_64_, 1, v___x_49_);
lean_ctor_set(v_reuseFailAlloc_64_, 2, v___x_50_);
lean_ctor_set(v_reuseFailAlloc_64_, 3, v___x_52_);
lean_ctor_set(v_reuseFailAlloc_64_, 4, v___x_59_);
lean_ctor_set(v_reuseFailAlloc_64_, 5, v___x_60_);
v___x_62_ = v_reuseFailAlloc_64_;
goto v_reusejp_61_;
}
v_reusejp_61_:
{
v_a_20_ = v_n_38_;
v_a_21_ = v___x_62_;
goto _start;
}
}
else
{
lean_object* v___x_65_; lean_object* v___x_66_; lean_object* v___x_67_; lean_object* v___x_68_; lean_object* v___x_69_; lean_object* v___x_70_; lean_object* v___x_71_; lean_object* v___x_72_; lean_object* v___x_73_; lean_object* v___x_74_; lean_object* v___x_75_; lean_object* v___x_77_; 
v___x_65_ = lean_obj_once(&l_spigot_go___closed__4, &l_spigot_go___closed__4_once, _init_l_spigot_go___closed__4);
v___x_66_ = lean_int_mul(v___x_65_, v_q_28_);
v___x_67_ = lean_int_sub(v_r_29_, v___x_43_);
lean_dec(v___x_43_);
v___x_68_ = lean_int_mul(v___x_65_, v___x_67_);
lean_dec(v___x_67_);
v___x_69_ = lean_obj_once(&l_spigot_go___closed__5, &l_spigot_go___closed__5_once, _init_l_spigot_go___closed__5);
v___x_70_ = lean_int_mul(v___x_69_, v_q_28_);
lean_dec(v_q_28_);
v___x_71_ = lean_int_add(v___x_70_, v_r_29_);
lean_dec(v_r_29_);
lean_dec(v___x_70_);
v___x_72_ = lean_int_mul(v___x_65_, v___x_71_);
lean_dec(v___x_71_);
v___x_73_ = lean_int_ediv(v___x_72_, v_t_30_);
lean_dec(v___x_72_);
v___x_74_ = lean_int_mul(v___x_65_, v_n_32_);
v___x_75_ = lean_int_sub(v___x_73_, v___x_74_);
lean_dec(v___x_74_);
lean_dec(v___x_73_);
if (v_isShared_36_ == 0)
{
lean_ctor_set(v___x_35_, 4, v___x_75_);
lean_ctor_set(v___x_35_, 1, v___x_68_);
lean_ctor_set(v___x_35_, 0, v___x_66_);
v___x_77_ = v___x_35_;
goto v_reusejp_76_;
}
else
{
lean_object* v_reuseFailAlloc_82_; 
v_reuseFailAlloc_82_ = lean_alloc_ctor(0, 6, 0);
lean_ctor_set(v_reuseFailAlloc_82_, 0, v___x_66_);
lean_ctor_set(v_reuseFailAlloc_82_, 1, v___x_68_);
lean_ctor_set(v_reuseFailAlloc_82_, 2, v_t_30_);
lean_ctor_set(v_reuseFailAlloc_82_, 3, v_k_31_);
lean_ctor_set(v_reuseFailAlloc_82_, 4, v___x_75_);
lean_ctor_set(v_reuseFailAlloc_82_, 5, v_l_33_);
v___x_77_ = v_reuseFailAlloc_82_;
goto v_reusejp_76_;
}
v_reusejp_76_:
{
lean_object* v___x_78_; lean_object* v___x_79_; lean_object* v___x_80_; 
v___x_78_ = lean_nat_add(v_a_22_, v_one_37_);
lean_dec(v_a_22_);
v___x_79_ = l_Int_toNat(v_n_32_);
lean_dec(v_n_32_);
v___x_80_ = lean_nat_add(v_a_23_, v___x_79_);
lean_dec(v___x_79_);
lean_dec(v_a_23_);
v_a_20_ = v_n_38_;
v_a_21_ = v___x_77_;
v_a_22_ = v___x_78_;
v_a_23_ = v___x_80_;
goto _start;
}
}
}
}
else
{
lean_object* v___x_84_; 
lean_dec_ref(v_a_21_);
lean_dec(v_a_20_);
v___x_84_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_84_, 0, v_a_23_);
lean_ctor_set(v___x_84_, 1, v_a_22_);
return v___x_84_;
}
}
}
}
LEAN_EXPORT lean_object* l_spigot_go___boxed(lean_object* v_digits_85_, lean_object* v_a_86_, lean_object* v_a_87_, lean_object* v_a_88_, lean_object* v_a_89_){
_start:
{
lean_object* v_res_90_; 
v_res_90_ = l_spigot_go(v_digits_85_, v_a_86_, v_a_87_, v_a_88_, v_a_89_);
lean_dec(v_digits_85_);
return v_res_90_;
}
}
static lean_object* _init_l_spigot___closed__0(void){
_start:
{
lean_object* v___x_91_; lean_object* v___x_92_; lean_object* v___x_93_; lean_object* v___x_94_; 
v___x_91_ = lean_obj_once(&l_spigot_go___closed__5, &l_spigot_go___closed__5_once, _init_l_spigot_go___closed__5);
v___x_92_ = lean_obj_once(&l_instInhabitedSt_default___closed__0, &l_instInhabitedSt_default___closed__0_once, _init_l_instInhabitedSt_default___closed__0);
v___x_93_ = lean_obj_once(&l_spigot_go___closed__2, &l_spigot_go___closed__2_once, _init_l_spigot_go___closed__2);
v___x_94_ = lean_alloc_ctor(0, 6, 0);
lean_ctor_set(v___x_94_, 0, v___x_93_);
lean_ctor_set(v___x_94_, 1, v___x_92_);
lean_ctor_set(v___x_94_, 2, v___x_93_);
lean_ctor_set(v___x_94_, 3, v___x_93_);
lean_ctor_set(v___x_94_, 4, v___x_91_);
lean_ctor_set(v___x_94_, 5, v___x_91_);
return v___x_94_;
}
}
LEAN_EXPORT lean_object* l_spigot(lean_object* v_digits_95_){
_start:
{
lean_object* v___x_96_; lean_object* v___x_97_; lean_object* v___x_98_; lean_object* v___x_99_; lean_object* v___x_100_; 
v___x_96_ = lean_unsigned_to_nat(1000u);
v___x_97_ = lean_nat_mul(v_digits_95_, v___x_96_);
v___x_98_ = lean_unsigned_to_nat(0u);
v___x_99_ = lean_obj_once(&l_spigot___closed__0, &l_spigot___closed__0_once, _init_l_spigot___closed__0);
v___x_100_ = l_spigot_go(v_digits_95_, v___x_97_, v___x_99_, v___x_98_, v___x_98_);
return v___x_100_;
}
}
LEAN_EXPORT lean_object* l_spigot___boxed(lean_object* v_digits_101_){
_start:
{
lean_object* v_res_102_; 
v_res_102_ = l_spigot(v_digits_101_);
lean_dec(v_digits_101_);
return v_res_102_;
}
}
LEAN_EXPORT lean_object* l_forceIO___redArg(lean_object* v_x_103_){
_start:
{
lean_object* v___x_105_; 
v___x_105_ = l_IO_lazyPure___redArg(v_x_103_);
return v___x_105_;
}
}
LEAN_EXPORT lean_object* l_forceIO___redArg___boxed(lean_object* v_x_106_, lean_object* v_a_107_){
_start:
{
lean_object* v_res_108_; 
v_res_108_ = l_forceIO___redArg(v_x_106_);
return v_res_108_;
}
}
LEAN_EXPORT lean_object* l_forceIO(lean_object* v_00_u03b1_109_, lean_object* v_x_110_){
_start:
{
lean_object* v___x_112_; 
v___x_112_ = l_forceIO___redArg(v_x_110_);
return v___x_112_;
}
}
LEAN_EXPORT lean_object* l_forceIO___boxed(lean_object* v_00_u03b1_113_, lean_object* v_x_114_, lean_object* v_a_115_){
_start:
{
lean_object* v_res_116_; 
v_res_116_ = l_forceIO(v_00_u03b1_113_, v_x_114_);
return v_res_116_;
}
}
static lean_object* _init_l_main___lam__0___closed__0(void){
_start:
{
lean_object* v___x_117_; lean_object* v___x_118_; 
v___x_117_ = lean_unsigned_to_nat(1000u);
v___x_118_ = l_spigot(v___x_117_);
return v___x_118_;
}
}
LEAN_EXPORT lean_object* l_main___lam__0(lean_object* v_x_119_){
_start:
{
lean_object* v___x_120_; 
v___x_120_ = lean_obj_once(&l_main___lam__0___closed__0, &l_main___lam__0___closed__0_once, _init_l_main___lam__0___closed__0);
return v___x_120_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(lean_object* v_s_121_){
_start:
{
lean_object* v___x_123_; lean_object* v_putStr_124_; lean_object* v___x_125_; 
v___x_123_ = lean_get_stdout();
v_putStr_124_ = lean_ctor_get(v___x_123_, 4);
lean_inc_ref(v_putStr_124_);
lean_dec_ref(v___x_123_);
v___x_125_ = lean_apply_2(v_putStr_124_, v_s_121_, lean_box(0));
return v___x_125_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0___boxed(lean_object* v_s_126_, lean_object* v_a_127_){
_start:
{
lean_object* v_res_128_; 
v_res_128_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v_s_126_);
return v_res_128_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0(lean_object* v_s_129_){
_start:
{
lean_object* v___x_131_; uint32_t v___x_132_; lean_object* v___x_133_; lean_object* v___x_134_; 
v___x_131_ = l_Nat_reprFast(v_s_129_);
v___x_132_ = 10;
v___x_133_ = lean_string_push(v___x_131_, v___x_132_);
v___x_134_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v___x_133_);
return v___x_134_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0___boxed(lean_object* v_s_135_, lean_object* v_a_136_){
_start:
{
lean_object* v_res_137_; 
v_res_137_ = l_IO_println___at___00main_spec__0(v_s_135_);
return v_res_137_;
}
}
LEAN_EXPORT lean_object* _lean_main(){
_start:
{
lean_object* v___x_143_; lean_object* v___f_144_; lean_object* v___x_145_; lean_object* v_a_146_; lean_object* v___x_148_; uint8_t v_isShared_149_; uint8_t v_isSharedCheck_175_; 
v___x_143_ = lean_io_mono_nanos_now();
v___f_144_ = ((lean_object*)(l_main___closed__0));
v___x_145_ = l_forceIO___redArg(v___f_144_);
v_a_146_ = lean_ctor_get(v___x_145_, 0);
v_isSharedCheck_175_ = !lean_is_exclusive(v___x_145_);
if (v_isSharedCheck_175_ == 0)
{
v___x_148_ = v___x_145_;
v_isShared_149_ = v_isSharedCheck_175_;
goto v_resetjp_147_;
}
else
{
lean_inc(v_a_146_);
lean_dec(v___x_145_);
v___x_148_ = lean_box(0);
v_isShared_149_ = v_isSharedCheck_175_;
goto v_resetjp_147_;
}
v_resetjp_147_:
{
lean_object* v_fst_150_; lean_object* v_snd_151_; lean_object* v___x_152_; uint8_t v___x_153_; 
v_fst_150_ = lean_ctor_get(v_a_146_, 0);
lean_inc(v_fst_150_);
v_snd_151_ = lean_ctor_get(v_a_146_, 1);
lean_inc(v_snd_151_);
lean_dec(v_a_146_);
v___x_152_ = lean_unsigned_to_nat(1000u);
v___x_153_ = lean_nat_dec_eq(v_snd_151_, v___x_152_);
if (v___x_153_ == 0)
{
lean_object* v___x_154_; lean_object* v___x_155_; lean_object* v___x_156_; lean_object* v___x_157_; lean_object* v___x_158_; lean_object* v___x_159_; lean_object* v___x_161_; 
lean_dec(v_fst_150_);
lean_dec(v___x_143_);
v___x_154_ = ((lean_object*)(l_main___closed__1));
v___x_155_ = l_Nat_reprFast(v_snd_151_);
v___x_156_ = lean_string_append(v___x_154_, v___x_155_);
lean_dec_ref(v___x_155_);
v___x_157_ = ((lean_object*)(l_main___closed__2));
v___x_158_ = lean_string_append(v___x_156_, v___x_157_);
v___x_159_ = lean_alloc_ctor(18, 1, 0);
lean_ctor_set(v___x_159_, 0, v___x_158_);
if (v_isShared_149_ == 0)
{
lean_ctor_set_tag(v___x_148_, 1);
lean_ctor_set(v___x_148_, 0, v___x_159_);
v___x_161_ = v___x_148_;
goto v_reusejp_160_;
}
else
{
lean_object* v_reuseFailAlloc_162_; 
v_reuseFailAlloc_162_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_162_, 0, v___x_159_);
v___x_161_ = v_reuseFailAlloc_162_;
goto v_reusejp_160_;
}
v_reusejp_160_:
{
return v___x_161_;
}
}
else
{
lean_object* v___x_163_; lean_object* v___x_164_; double v___x_165_; lean_object* v___x_166_; lean_object* v___x_167_; double v___x_168_; double v___x_169_; lean_object* v___x_170_; lean_object* v___x_171_; lean_object* v___x_172_; lean_object* v___x_173_; 
lean_dec(v_snd_151_);
lean_del_object(v___x_148_);
v___x_163_ = lean_io_mono_nanos_now();
v___x_164_ = lean_nat_sub(v___x_163_, v___x_143_);
lean_dec(v___x_143_);
lean_dec(v___x_163_);
v___x_165_ = lean_float_of_nat(v___x_164_);
v___x_166_ = lean_unsigned_to_nat(10000000u);
v___x_167_ = lean_unsigned_to_nat(1u);
v___x_168_ = l_Float_ofScientific(v___x_166_, v___x_153_, v___x_167_);
v___x_169_ = lean_float_div(v___x_165_, v___x_168_);
v___x_170_ = ((lean_object*)(l_main___closed__3));
v___x_171_ = lean_float_to_string(v___x_169_);
v___x_172_ = lean_string_append(v___x_170_, v___x_171_);
lean_dec_ref(v___x_171_);
v___x_173_ = l_IO_eprintln___at___00__private_Init_System_IO_0__IO_eprintlnAux_spec__0(v___x_172_);
if (lean_obj_tag(v___x_173_) == 0)
{
lean_object* v___x_174_; 
lean_dec_ref_known(v___x_173_, 1);
v___x_174_ = l_IO_println___at___00main_spec__0(v_fst_150_);
return v___x_174_;
}
else
{
lean_dec(v_fst_150_);
return v___x_173_;
}
}
}
}
}
LEAN_EXPORT lean_object* l_main___boxed(lean_object* v_a_176_){
_start:
{
lean_object* v_res_177_; 
v_res_177_ = _lean_main();
return v_res_177_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_0010__pi(uint8_t builtin) {
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
l_instInhabitedSt_default = _init_l_instInhabitedSt_default();
lean_mark_persistent(l_instInhabitedSt_default);
l_instInhabitedSt = _init_l_instInhabitedSt();
lean_mark_persistent(l_instInhabitedSt);
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
  res = initialize_0010__pi(1 /* builtin */);
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
