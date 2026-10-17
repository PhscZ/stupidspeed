// Lean compiler output
// Module: «14_file_read»
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
lean_object* lean_io_prim_handle_read(lean_object*, size_t);
uint8_t l_ByteArray_isEmpty(lean_object*);
lean_object* lean_byte_array_size(lean_object*);
uint8_t lean_nat_dec_lt(lean_object*, lean_object*);
uint8_t lean_nat_dec_le(lean_object*, lean_object*);
size_t lean_usize_of_nat(lean_object*);
uint8_t lean_usize_dec_eq(size_t, size_t);
uint8_t lean_byte_array_uget(lean_object*, size_t);
uint64_t lean_uint8_to_uint64(uint8_t);
uint64_t lean_uint64_add(uint64_t, uint64_t);
size_t lean_usize_add(size_t, size_t);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_io_prim_handle_mk(lean_object*, uint8_t);
lean_object* lean_nat_sub(lean_object*, lean_object*);
lean_object* lean_io_mono_nanos_now();
double lean_float_of_nat(lean_object*);
double l_Float_ofScientific(lean_object*, uint8_t, lean_object*);
double lean_float_div(double, double);
lean_object* lean_float_to_string(double);
lean_object* lean_string_append(lean_object*, lean_object*);
lean_object* l_IO_eprintln___at___00__private_Init_System_IO_0__IO_eprintlnAux_spec__0(lean_object*);
uint64_t lean_uint64_mod(uint64_t, uint64_t);
lean_object* lean_uint64_to_nat(uint64_t);
lean_object* l_Nat_reprFast(lean_object*);
lean_object* lean_string_push(lean_object*, uint32_t);
lean_object* lean_get_stdout();
LEAN_EXPORT uint64_t l_ByteArray_foldlMUnsafe_fold___at___00sumBytes_spec__0(lean_object*, size_t, size_t, uint64_t);
LEAN_EXPORT lean_object* l_ByteArray_foldlMUnsafe_fold___at___00sumBytes_spec__0___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint64_t l_sumBytes(lean_object*);
LEAN_EXPORT lean_object* l_sumBytes___boxed(lean_object*);
LEAN_EXPORT lean_object* l_readAll(lean_object*, uint64_t);
LEAN_EXPORT lean_object* l_readAll___boxed(lean_object*, lean_object*, lean_object*);
static const lean_string_object l_readPasses___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 9, .m_capacity = 9, .m_length = 8, .m_data = "data.bin"};
static const lean_object* l_readPasses___closed__0 = (const lean_object*)&l_readPasses___closed__0_value;
LEAN_EXPORT lean_object* l_readPasses(lean_object*, uint64_t);
LEAN_EXPORT lean_object* l_readPasses___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(lean_object*);
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0(uint64_t);
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0___boxed(lean_object*, lean_object*);
static lean_once_cell_t l_main___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static double l_main___closed__0;
static const lean_string_object l_main___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 9, .m_capacity = 9, .m_length = 8, .m_data = "TIME_MS="};
static const lean_object* l_main___closed__1 = (const lean_object*)&l_main___closed__1_value;
LEAN_EXPORT lean_object* _lean_main();
LEAN_EXPORT lean_object* l_main___boxed(lean_object*);
LEAN_EXPORT uint64_t l_ByteArray_foldlMUnsafe_fold___at___00sumBytes_spec__0(lean_object* v_as_1_, size_t v_i_2_, size_t v_stop_3_, uint64_t v_b_4_){
_start:
{
uint8_t v___x_5_; 
v___x_5_ = lean_usize_dec_eq(v_i_2_, v_stop_3_);
if (v___x_5_ == 0)
{
uint8_t v___x_6_; uint64_t v___x_7_; uint64_t v___x_8_; size_t v___x_9_; size_t v___x_10_; 
v___x_6_ = lean_byte_array_uget(v_as_1_, v_i_2_);
v___x_7_ = lean_uint8_to_uint64(v___x_6_);
v___x_8_ = lean_uint64_add(v_b_4_, v___x_7_);
v___x_9_ = ((size_t)1ULL);
v___x_10_ = lean_usize_add(v_i_2_, v___x_9_);
v_i_2_ = v___x_10_;
v_b_4_ = v___x_8_;
goto _start;
}
else
{
return v_b_4_;
}
}
}
LEAN_EXPORT lean_object* l_ByteArray_foldlMUnsafe_fold___at___00sumBytes_spec__0___boxed(lean_object* v_as_12_, lean_object* v_i_13_, lean_object* v_stop_14_, lean_object* v_b_15_){
_start:
{
size_t v_i_boxed_16_; size_t v_stop_boxed_17_; uint64_t v_b_boxed_18_; uint64_t v_res_19_; lean_object* v_r_20_; 
v_i_boxed_16_ = lean_unbox_usize(v_i_13_);
lean_dec(v_i_13_);
v_stop_boxed_17_ = lean_unbox_usize(v_stop_14_);
lean_dec(v_stop_14_);
v_b_boxed_18_ = lean_unbox_uint64(v_b_15_);
lean_dec_ref(v_b_15_);
v_res_19_ = l_ByteArray_foldlMUnsafe_fold___at___00sumBytes_spec__0(v_as_12_, v_i_boxed_16_, v_stop_boxed_17_, v_b_boxed_18_);
lean_dec_ref(v_as_12_);
v_r_20_ = lean_box_uint64(v_res_19_);
return v_r_20_;
}
}
LEAN_EXPORT uint64_t l_sumBytes(lean_object* v_b_21_){
_start:
{
lean_object* v___x_22_; uint64_t v___x_23_; lean_object* v___x_24_; uint8_t v___x_25_; 
v___x_22_ = lean_unsigned_to_nat(0u);
v___x_23_ = 0ULL;
v___x_24_ = lean_byte_array_size(v_b_21_);
v___x_25_ = lean_nat_dec_lt(v___x_22_, v___x_24_);
if (v___x_25_ == 0)
{
return v___x_23_;
}
else
{
uint8_t v___x_26_; 
v___x_26_ = lean_nat_dec_le(v___x_24_, v___x_24_);
if (v___x_26_ == 0)
{
if (v___x_25_ == 0)
{
return v___x_23_;
}
else
{
size_t v___x_27_; size_t v___x_28_; uint64_t v___x_29_; 
v___x_27_ = ((size_t)0ULL);
v___x_28_ = lean_usize_of_nat(v___x_24_);
v___x_29_ = l_ByteArray_foldlMUnsafe_fold___at___00sumBytes_spec__0(v_b_21_, v___x_27_, v___x_28_, v___x_23_);
return v___x_29_;
}
}
else
{
size_t v___x_30_; size_t v___x_31_; uint64_t v___x_32_; 
v___x_30_ = ((size_t)0ULL);
v___x_31_ = lean_usize_of_nat(v___x_24_);
v___x_32_ = l_ByteArray_foldlMUnsafe_fold___at___00sumBytes_spec__0(v_b_21_, v___x_30_, v___x_31_, v___x_23_);
return v___x_32_;
}
}
}
}
LEAN_EXPORT lean_object* l_sumBytes___boxed(lean_object* v_b_33_){
_start:
{
uint64_t v_res_34_; lean_object* v_r_35_; 
v_res_34_ = l_sumBytes(v_b_33_);
lean_dec_ref(v_b_33_);
v_r_35_ = lean_box_uint64(v_res_34_);
return v_r_35_;
}
}
LEAN_EXPORT lean_object* l_readAll(lean_object* v_h_36_, uint64_t v_total_37_){
_start:
{
size_t v___x_39_; lean_object* v___x_40_; 
v___x_39_ = ((size_t)1048576ULL);
v___x_40_ = lean_io_prim_handle_read(v_h_36_, v___x_39_);
if (lean_obj_tag(v___x_40_) == 0)
{
lean_object* v_a_41_; lean_object* v___x_43_; uint8_t v_isShared_44_; uint8_t v_isSharedCheck_53_; 
v_a_41_ = lean_ctor_get(v___x_40_, 0);
v_isSharedCheck_53_ = !lean_is_exclusive(v___x_40_);
if (v_isSharedCheck_53_ == 0)
{
v___x_43_ = v___x_40_;
v_isShared_44_ = v_isSharedCheck_53_;
goto v_resetjp_42_;
}
else
{
lean_inc(v_a_41_);
lean_dec(v___x_40_);
v___x_43_ = lean_box(0);
v_isShared_44_ = v_isSharedCheck_53_;
goto v_resetjp_42_;
}
v_resetjp_42_:
{
uint8_t v___x_45_; 
v___x_45_ = l_ByteArray_isEmpty(v_a_41_);
if (v___x_45_ == 0)
{
uint64_t v___x_46_; uint64_t v___x_47_; 
lean_del_object(v___x_43_);
v___x_46_ = l_sumBytes(v_a_41_);
lean_dec(v_a_41_);
v___x_47_ = lean_uint64_add(v_total_37_, v___x_46_);
v_total_37_ = v___x_47_;
goto _start;
}
else
{
lean_object* v___x_49_; lean_object* v___x_51_; 
lean_dec(v_a_41_);
v___x_49_ = lean_box_uint64(v_total_37_);
if (v_isShared_44_ == 0)
{
lean_ctor_set(v___x_43_, 0, v___x_49_);
v___x_51_ = v___x_43_;
goto v_reusejp_50_;
}
else
{
lean_object* v_reuseFailAlloc_52_; 
v_reuseFailAlloc_52_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_52_, 0, v___x_49_);
v___x_51_ = v_reuseFailAlloc_52_;
goto v_reusejp_50_;
}
v_reusejp_50_:
{
return v___x_51_;
}
}
}
}
else
{
lean_object* v_a_54_; lean_object* v___x_56_; uint8_t v_isShared_57_; uint8_t v_isSharedCheck_61_; 
v_a_54_ = lean_ctor_get(v___x_40_, 0);
v_isSharedCheck_61_ = !lean_is_exclusive(v___x_40_);
if (v_isSharedCheck_61_ == 0)
{
v___x_56_ = v___x_40_;
v_isShared_57_ = v_isSharedCheck_61_;
goto v_resetjp_55_;
}
else
{
lean_inc(v_a_54_);
lean_dec(v___x_40_);
v___x_56_ = lean_box(0);
v_isShared_57_ = v_isSharedCheck_61_;
goto v_resetjp_55_;
}
v_resetjp_55_:
{
lean_object* v___x_59_; 
if (v_isShared_57_ == 0)
{
v___x_59_ = v___x_56_;
goto v_reusejp_58_;
}
else
{
lean_object* v_reuseFailAlloc_60_; 
v_reuseFailAlloc_60_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_60_, 0, v_a_54_);
v___x_59_ = v_reuseFailAlloc_60_;
goto v_reusejp_58_;
}
v_reusejp_58_:
{
return v___x_59_;
}
}
}
}
}
LEAN_EXPORT lean_object* l_readAll___boxed(lean_object* v_h_62_, lean_object* v_total_63_, lean_object* v_a_64_){
_start:
{
uint64_t v_total_boxed_65_; lean_object* v_res_66_; 
v_total_boxed_65_ = lean_unbox_uint64(v_total_63_);
lean_dec_ref(v_total_63_);
v_res_66_ = l_readAll(v_h_62_, v_total_boxed_65_);
lean_dec(v_h_62_);
return v_res_66_;
}
}
LEAN_EXPORT lean_object* l_readPasses(lean_object* v_passes_68_, uint64_t v_total_69_){
_start:
{
lean_object* v___x_71_; uint8_t v___x_72_; 
v___x_71_ = lean_unsigned_to_nat(0u);
v___x_72_ = lean_nat_dec_eq(v_passes_68_, v___x_71_);
if (v___x_72_ == 0)
{
lean_object* v___x_73_; uint8_t v___x_74_; lean_object* v___x_75_; 
v___x_73_ = ((lean_object*)(l_readPasses___closed__0));
v___x_74_ = 0;
v___x_75_ = lean_io_prim_handle_mk(v___x_73_, v___x_74_);
if (lean_obj_tag(v___x_75_) == 0)
{
lean_object* v_a_76_; lean_object* v___x_77_; 
v_a_76_ = lean_ctor_get(v___x_75_, 0);
lean_inc(v_a_76_);
lean_dec_ref_known(v___x_75_, 1);
v___x_77_ = l_readAll(v_a_76_, v_total_69_);
lean_dec(v_a_76_);
if (lean_obj_tag(v___x_77_) == 0)
{
lean_object* v_a_78_; lean_object* v___x_79_; lean_object* v___x_80_; uint64_t v___x_81_; 
v_a_78_ = lean_ctor_get(v___x_77_, 0);
lean_inc(v_a_78_);
lean_dec_ref_known(v___x_77_, 1);
v___x_79_ = lean_unsigned_to_nat(1u);
v___x_80_ = lean_nat_sub(v_passes_68_, v___x_79_);
lean_dec(v_passes_68_);
v___x_81_ = lean_unbox_uint64(v_a_78_);
lean_dec(v_a_78_);
v_passes_68_ = v___x_80_;
v_total_69_ = v___x_81_;
goto _start;
}
else
{
lean_dec(v_passes_68_);
return v___x_77_;
}
}
else
{
lean_object* v_a_83_; lean_object* v___x_85_; uint8_t v_isShared_86_; uint8_t v_isSharedCheck_90_; 
lean_dec(v_passes_68_);
v_a_83_ = lean_ctor_get(v___x_75_, 0);
v_isSharedCheck_90_ = !lean_is_exclusive(v___x_75_);
if (v_isSharedCheck_90_ == 0)
{
v___x_85_ = v___x_75_;
v_isShared_86_ = v_isSharedCheck_90_;
goto v_resetjp_84_;
}
else
{
lean_inc(v_a_83_);
lean_dec(v___x_75_);
v___x_85_ = lean_box(0);
v_isShared_86_ = v_isSharedCheck_90_;
goto v_resetjp_84_;
}
v_resetjp_84_:
{
lean_object* v___x_88_; 
if (v_isShared_86_ == 0)
{
v___x_88_ = v___x_85_;
goto v_reusejp_87_;
}
else
{
lean_object* v_reuseFailAlloc_89_; 
v_reuseFailAlloc_89_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_89_, 0, v_a_83_);
v___x_88_ = v_reuseFailAlloc_89_;
goto v_reusejp_87_;
}
v_reusejp_87_:
{
return v___x_88_;
}
}
}
}
else
{
lean_object* v___x_91_; lean_object* v___x_92_; 
lean_dec(v_passes_68_);
v___x_91_ = lean_box_uint64(v_total_69_);
v___x_92_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v___x_92_, 0, v___x_91_);
return v___x_92_;
}
}
}
LEAN_EXPORT lean_object* l_readPasses___boxed(lean_object* v_passes_93_, lean_object* v_total_94_, lean_object* v_a_95_){
_start:
{
uint64_t v_total_boxed_96_; lean_object* v_res_97_; 
v_total_boxed_96_ = lean_unbox_uint64(v_total_94_);
lean_dec_ref(v_total_94_);
v_res_97_ = l_readPasses(v_passes_93_, v_total_boxed_96_);
return v_res_97_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(lean_object* v_s_98_){
_start:
{
lean_object* v___x_100_; lean_object* v_putStr_101_; lean_object* v___x_102_; 
v___x_100_ = lean_get_stdout();
v_putStr_101_ = lean_ctor_get(v___x_100_, 4);
lean_inc_ref(v_putStr_101_);
lean_dec_ref(v___x_100_);
v___x_102_ = lean_apply_2(v_putStr_101_, v_s_98_, lean_box(0));
return v___x_102_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__0_spec__0___boxed(lean_object* v_s_103_, lean_object* v_a_104_){
_start:
{
lean_object* v_res_105_; 
v_res_105_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v_s_103_);
return v_res_105_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0(uint64_t v_s_106_){
_start:
{
lean_object* v___x_108_; lean_object* v___x_109_; uint32_t v___x_110_; lean_object* v___x_111_; lean_object* v___x_112_; 
v___x_108_ = lean_uint64_to_nat(v_s_106_);
v___x_109_ = l_Nat_reprFast(v___x_108_);
v___x_110_ = 10;
v___x_111_ = lean_string_push(v___x_109_, v___x_110_);
v___x_112_ = l_IO_print___at___00IO_println___at___00main_spec__0_spec__0(v___x_111_);
return v___x_112_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__0___boxed(lean_object* v_s_113_, lean_object* v_a_114_){
_start:
{
uint64_t v_s_boxed_115_; lean_object* v_res_116_; 
v_s_boxed_115_ = lean_unbox_uint64(v_s_113_);
lean_dec_ref(v_s_113_);
v_res_116_ = l_IO_println___at___00main_spec__0(v_s_boxed_115_);
return v_res_116_;
}
}
static double _init_l_main___closed__0(void){
_start:
{
lean_object* v___x_117_; uint8_t v___x_118_; lean_object* v___x_119_; double v___x_120_; 
v___x_117_ = lean_unsigned_to_nat(1u);
v___x_118_ = 1;
v___x_119_ = lean_unsigned_to_nat(10000000u);
v___x_120_ = l_Float_ofScientific(v___x_119_, v___x_118_, v___x_117_);
return v___x_120_;
}
}
LEAN_EXPORT lean_object* _lean_main(){
_start:
{
lean_object* v___x_123_; lean_object* v___x_124_; uint64_t v___x_125_; lean_object* v___x_126_; 
v___x_123_ = lean_io_mono_nanos_now();
v___x_124_ = lean_unsigned_to_nat(8u);
v___x_125_ = 0ULL;
v___x_126_ = l_readPasses(v___x_124_, v___x_125_);
if (lean_obj_tag(v___x_126_) == 0)
{
lean_object* v_a_127_; lean_object* v___x_128_; lean_object* v___x_129_; double v___x_130_; double v___x_131_; double v___x_132_; lean_object* v___x_133_; lean_object* v___x_134_; lean_object* v___x_135_; lean_object* v___x_136_; 
v_a_127_ = lean_ctor_get(v___x_126_, 0);
lean_inc(v_a_127_);
lean_dec_ref_known(v___x_126_, 1);
v___x_128_ = lean_io_mono_nanos_now();
v___x_129_ = lean_nat_sub(v___x_128_, v___x_123_);
lean_dec(v___x_123_);
lean_dec(v___x_128_);
v___x_130_ = lean_float_of_nat(v___x_129_);
v___x_131_ = lean_float_once(&l_main___closed__0, &l_main___closed__0_once, _init_l_main___closed__0);
v___x_132_ = lean_float_div(v___x_130_, v___x_131_);
v___x_133_ = ((lean_object*)(l_main___closed__1));
v___x_134_ = lean_float_to_string(v___x_132_);
v___x_135_ = lean_string_append(v___x_133_, v___x_134_);
lean_dec_ref(v___x_134_);
v___x_136_ = l_IO_eprintln___at___00__private_Init_System_IO_0__IO_eprintlnAux_spec__0(v___x_135_);
if (lean_obj_tag(v___x_136_) == 0)
{
uint64_t v___x_137_; uint64_t v___x_138_; uint64_t v___x_139_; lean_object* v___x_140_; 
lean_dec_ref_known(v___x_136_, 1);
v___x_137_ = 4294967296ULL;
v___x_138_ = lean_unbox_uint64(v_a_127_);
lean_dec(v_a_127_);
v___x_139_ = lean_uint64_mod(v___x_138_, v___x_137_);
v___x_140_ = l_IO_println___at___00main_spec__0(v___x_139_);
return v___x_140_;
}
else
{
lean_dec(v_a_127_);
return v___x_136_;
}
}
else
{
lean_object* v_a_141_; lean_object* v___x_143_; uint8_t v_isShared_144_; uint8_t v_isSharedCheck_148_; 
lean_dec(v___x_123_);
v_a_141_ = lean_ctor_get(v___x_126_, 0);
v_isSharedCheck_148_ = !lean_is_exclusive(v___x_126_);
if (v_isSharedCheck_148_ == 0)
{
v___x_143_ = v___x_126_;
v_isShared_144_ = v_isSharedCheck_148_;
goto v_resetjp_142_;
}
else
{
lean_inc(v_a_141_);
lean_dec(v___x_126_);
v___x_143_ = lean_box(0);
v_isShared_144_ = v_isSharedCheck_148_;
goto v_resetjp_142_;
}
v_resetjp_142_:
{
lean_object* v___x_146_; 
if (v_isShared_144_ == 0)
{
v___x_146_ = v___x_143_;
goto v_reusejp_145_;
}
else
{
lean_object* v_reuseFailAlloc_147_; 
v_reuseFailAlloc_147_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_147_, 0, v_a_141_);
v___x_146_ = v_reuseFailAlloc_147_;
goto v_reusejp_145_;
}
v_reusejp_145_:
{
return v___x_146_;
}
}
}
}
}
LEAN_EXPORT lean_object* l_main___boxed(lean_object* v_a_149_){
_start:
{
lean_object* v_res_150_; 
v_res_150_ = _lean_main();
return v_res_150_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_0014__file__read(uint8_t builtin) {
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
  res = initialize_0014__file__read(1 /* builtin */);
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
