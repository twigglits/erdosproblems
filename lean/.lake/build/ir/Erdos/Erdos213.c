// Lean compiler output
// Module: Erdos.Erdos213
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
lean_object* lean_nat_add(lean_object*, lean_object*);
uint8_t l_Nat_decidable__dvd(lean_object*, lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
lean_object* l_List_range(lean_object*);
lean_object* lp_mathlib_Finset_sum___at___00Fin_accumulate_spec__0___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_erdos_Erdos_SigmaSum___lam__0(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_erdos_Erdos_SigmaSum___lam__0___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_erdos_Erdos_SigmaSum(lean_object*);
LEAN_EXPORT lean_object* lp_erdos_Erdos_SigmaSum___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_erdos_Erdos_SigmaSum___lam__0(lean_object* v_n_1_, lean_object* v_d_2_){
_start:
{
lean_object* v___x_3_; lean_object* v___x_4_; uint8_t v___x_5_; 
v___x_3_ = lean_unsigned_to_nat(1u);
v___x_4_ = lean_nat_add(v_n_1_, v___x_3_);
v___x_5_ = l_Nat_decidable__dvd(v_d_2_, v___x_4_);
lean_dec(v___x_4_);
if (v___x_5_ == 0)
{
lean_object* v___x_6_; 
v___x_6_ = lean_unsigned_to_nat(0u);
return v___x_6_;
}
else
{
lean_inc(v_d_2_);
return v_d_2_;
}
}
}
LEAN_EXPORT lean_object* lp_erdos_Erdos_SigmaSum___lam__0___boxed(lean_object* v_n_7_, lean_object* v_d_8_){
_start:
{
lean_object* v_res_9_; 
v_res_9_ = lp_erdos_Erdos_SigmaSum___lam__0(v_n_7_, v_d_8_);
lean_dec(v_d_8_);
lean_dec(v_n_7_);
return v_res_9_;
}
}
LEAN_EXPORT lean_object* lp_erdos_Erdos_SigmaSum(lean_object* v_n_10_){
_start:
{
lean_object* v_zero_11_; uint8_t v_isZero_12_; 
v_zero_11_ = lean_unsigned_to_nat(0u);
v_isZero_12_ = lean_nat_dec_eq(v_n_10_, v_zero_11_);
if (v_isZero_12_ == 1)
{
return v_zero_11_;
}
else
{
lean_object* v_one_13_; lean_object* v_n_14_; lean_object* v___f_15_; lean_object* v___x_16_; lean_object* v___x_17_; lean_object* v___x_18_; lean_object* v___x_19_; 
v_one_13_ = lean_unsigned_to_nat(1u);
v_n_14_ = lean_nat_sub(v_n_10_, v_one_13_);
lean_inc(v_n_14_);
v___f_15_ = lean_alloc_closure((void*)(lp_erdos_Erdos_SigmaSum___lam__0___boxed), 2, 1);
lean_closure_set(v___f_15_, 0, v_n_14_);
v___x_16_ = lean_unsigned_to_nat(2u);
v___x_17_ = lean_nat_add(v_n_14_, v___x_16_);
lean_dec(v_n_14_);
v___x_18_ = l_List_range(v___x_17_);
v___x_19_ = lp_mathlib_Finset_sum___at___00Fin_accumulate_spec__0___redArg(v___x_18_, v___f_15_);
return v___x_19_;
}
}
}
LEAN_EXPORT lean_object* lp_erdos_Erdos_SigmaSum___boxed(lean_object* v_n_20_){
_start:
{
lean_object* v_res_21_; 
v_res_21_ = lp_erdos_Erdos_SigmaSum(v_n_20_);
lean_dec(v_n_20_);
return v_res_21_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Basic(uint8_t builtin);
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_erdos_Erdos_Erdos213(uint8_t builtin) {
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
