/-
Axiom audit. Every headline theorem must rest only on Lean's standard base
`[propext, Classical.choice, Quot.sound]` — no `sorry`, no `sorryAx`, no custom axiom,
and no `native_decide`.
-/
import Erdos.Erdos389
import Erdos.Erdos396
import Erdos.Erdos727

namespace Erdos

-- Erdős 389
#print axioms erdosStraus_iff_prod
#print axioms erdosStraus_iff_choose
#print axioms erdosStraus_iff_factorization
#print axioms erdosStraus_iff_digits
#print axioms local_condition_iff
#print axioms two_mul_mod_ge_of_erdosStraus
#print axioms not_dvd_of_erdosStraus
#print axioms smooth_of_erdosStraus
#print axioms Solutions.n1
#print axioms Solutions.n11

-- Erdős 396
#print axioms factorization_centralBinom_of_lt_sq
#print axioms le_two_mul_of_block396
#print axioms smooth_of_block396

-- Erdős 727
#print axioms le_of_egrs
#print axioms egrs_iff_factorization
#print axioms k_le_mod_of_egrs
#print axioms not_dvd_of_egrs
#print axioms sq_le_of_dvd_block
#print axioms Solutions.k2
#print axioms Solutions.k4

end Erdos
