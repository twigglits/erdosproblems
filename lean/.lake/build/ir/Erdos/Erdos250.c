// Lean compiler output
// Module: Erdos.Erdos250
// Imports: public import Init public meta import Init public import Erdos.Basic
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
lean_object* lean_nat_pow(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_erdos_Erdos_MersenneMod(lean_object*);
LEAN_EXPORT lean_object* lp_erdos_Erdos_MersenneMod___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_erdos_Erdos_MersenneMod(lean_object* v_n_1_){
_start:
{
lean_object* v___x_2_; lean_object* v___x_3_; lean_object* v___x_4_; lean_object* v___x_5_; 
v___x_2_ = lean_unsigned_to_nat(2u);
v___x_3_ = lean_nat_pow(v___x_2_, v_n_1_);
v___x_4_ = lean_unsigned_to_nat(1u);
v___x_5_ = lean_nat_sub(v___x_3_, v___x_4_);
lean_dec(v___x_3_);
return v___x_5_;
}
}
LEAN_EXPORT lean_object* lp_erdos_Erdos_MersenneMod___boxed(lean_object* v_n_6_){
_start:
{
lean_object* v_res_7_; 
v_res_7_ = lp_erdos_Erdos_MersenneMod(v_n_6_);
lean_dec(v_n_6_);
return v_res_7_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Basic(uint8_t builtin);
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_erdos_Erdos_Erdos250(uint8_t builtin) {
lean_object * res;
if (_G_initialized) return lean_io_result_mk_ok(lean_box(0));
_G_initialized = true;
res = initialize_Init(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_Init(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Basic(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
