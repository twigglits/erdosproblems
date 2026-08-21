/-
!!! ATTRIBUTION WARNING (added 2026-08-21) !!!

This file is named for Erdős Problem 52, but the question stated below is NOT that problem.

  Erdős Problem 52 actually asks: sum-product: max(|A+A|,|AA|) >> |A|^{2-eps} ($250)
  This file instead studies:       maximum number of unit distances among n points

See ATTRIBUTION_AUDIT.md at the repository root.  Nothing proved in this file is progress on
Erdős Problem 52.
-/
/-
# Erdős Problem 52

> Consider n points in the plane. What is the maximum number of unit distances determined?

Reference: https://www.erdosproblems.com/52
-/
import Erdos.Basic

namespace Erdos

-- Points in plane with unit distance graph
def UnitDistanceGraph (n : ℕ) : ℕ :=
  sorry  -- Maximum edges with distance exactly 1

-- Upper bound: O(n^(4/3)) from incidence geometry
-- A ℕ base with a ℚ exponent has no `HPow` instance. The bound is stated over ℝ,
-- where `Real.rpow` gives the fractional power its meaning.
theorem problem_52_upper_bound (n : ℕ) :
    (UnitDistanceGraph n : ℝ) ≤ 4 * (n : ℝ) ^ ((4 : ℝ) / 3) := by
  sorry  -- Spencer-Szemerédi-Trotter theorem

-- Lower bound: Ω(n log log n) from constructions
theorem problem_52_lower_bound (n : ℕ) :
    UnitDistanceGraph n ≥ n * (Real.log (Real.log n)) / 100 := by
  sorry  -- Grid construction

-- Main conjecture: exact exponent
-- Conjecture: maximum is Θ(n^(4/3))
theorem problem_52_conjecture :
    ∃ C₁ C₂ : ℝ, ∀ n : ℕ,
    C₁ * (n : ℝ) ^ (4/3) ≤ UnitDistanceGraph n ∧
    UnitDistanceGraph n ≤ C₂ * (n : ℝ) ^ (4/3) := by
  sorry  -- Open problem: exact bounds unknown

end Erdos
