// Lean compiler output
// Module: Erdos
// Imports: public import Init public meta import Init public import Erdos.Basic public import Erdos.Erdos4 public import Erdos.Erdos33 public import Erdos.Erdos51 public import Erdos.Erdos52 public import Erdos.Erdos60 public import Erdos.Erdos69 public import Erdos.Erdos71 public import Erdos.Erdos72 public import Erdos.Erdos73 public import Erdos.Erdos86 public import Erdos.Erdos100 public import Erdos.Erdos116 public import Erdos.Erdos135 public import Erdos.Erdos150 public import Erdos.Erdos162 public import Erdos.Erdos176 public import Erdos.Erdos195 public import Erdos.Erdos197 public import Erdos.Erdos213 public import Erdos.Erdos244 public import Erdos.Erdos250 public import Erdos.Erdos342 public import Erdos.Erdos389 public import Erdos.Erdos396 public import Erdos.Erdos441 public import Erdos.Erdos519 public import Erdos.Erdos548 public import Erdos.Erdos632 public import Erdos.Erdos727 public import Erdos.Erdos458 public import Erdos.Erdos307 public import Erdos.Audit
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
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Basic(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos4(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos33(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos51(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos52(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos60(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos69(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos71(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos72(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos73(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos86(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos100(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos116(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos135(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos150(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos162(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos176(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos195(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos197(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos213(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos244(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos250(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos342(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos389(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos396(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos441(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos519(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos548(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos632(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos727(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos458(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Erdos307(uint8_t builtin);
lean_object* initialize_erdos_Erdos_Audit(uint8_t builtin);
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_erdos_Erdos(uint8_t builtin) {
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
res = initialize_erdos_Erdos_Erdos4(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos33(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos51(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos52(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos60(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos69(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos71(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos72(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos73(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos86(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos100(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos116(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos135(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos150(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos162(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos176(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos195(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos197(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos213(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos244(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos250(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos342(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos389(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos396(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos441(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos519(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos548(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos632(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos727(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos458(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Erdos307(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_erdos_Erdos_Audit(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
