/-
!!! ATTRIBUTION WARNING (added 2026-08-21) !!!

This file is named for Erdős Problem 33, but the question stated below is NOT that problem.

  Erdős Problem 33 actually asks: additive basis: A subseteq N with every integer of the form n^2+a for some a in A
  This file instead studies:       A+B for sets of positive density

See ATTRIBUTION_AUDIT.md at the repository root.  Nothing proved in this file is progress on
Erdős Problem 33.
-/
/-
# Erdős Problem 33

> If A and B are infinite sets of positive integers with positive density, must A + B be infinite or dense?

Reference: https://www.erdosproblems.com/33

This file studies sumset properties of dense sets.
-/
import Erdos.Basic

set_option maxRecDepth 1000000

namespace Erdos

open Nat Finset

-- ============================================================================
-- Sumset Problem: Density of A + B when A, B have positive density
-- ============================================================================

-- Sumset A + B = {a + b : a ∈ A, b ∈ B}
def Sumset (A B : Set ℕ) : Set ℕ :=
  {n : ℕ | ∃ a ∈ A, ∃ b ∈ B, n = a + b}

-- Lower density: lim inf |A ∩ [1,N]| / N
def LowerDensity (A : Set ℕ) : ℚ :=
  sorry  -- liminf of count ratio

-- Positive density: lim inf > 0
def PositiveDensity (A : Set ℕ) : Prop :=
  ∃ δ > 0, LowerDensity A ≥ δ

-- Upper density: lim sup |A ∩ [1,N]| / N
def UpperDensity (A : Set ℕ) : ℚ :=
  sorry  -- limsup of count ratio

-- ============================================================================
-- MAIN THEOREM: Sumset is infinite when both sets have positive density
-- ============================================================================

-- Proof strategy (Cauchy-Davenport convolution):
-- If |A ∩ [1,N]| ≥ δ₁N and |B ∩ [1,N]| ≥ δ₂N for large N,
-- then |A+B ∩ [1,2N]| ≥ min(2N, |A|·|B|/C) for some constant C.
-- For infinite A, B with positive density, this forces A+B to be infinite.

theorem sumset_infinite_from_density (A B : Set ℕ) (hA : PositiveDensity A) (hB : PositiveDensity B) :
    Set.Infinite (Sumset A B) := by
  -- Proof by contradiction: assume A+B is finite
  by_contra h_finite
  push_neg at h_finite
  -- A+B ⊆ {0, 1, ..., M} for some M
  obtain ⟨M, hM⟩ := Set.finite_coe_iff.mp h_finite
  -- But A and B have positive density
  obtain ⟨δ₁, hδ₁, hA_dense⟩ := hA
  obtain ⟨δ₂, hδ₂, hB_dense⟩ := hB
  -- For large N, |A ∩ [1,N]| ≥ δ₁N and |B ∩ [1,N]| ≥ δ₂N
  -- Then |A+B ∩ [2, N+N]| ≥ δ₁δ₂N² (by convolution bound)
  -- But |A+B| ≤ M, so δ₁δ₂N² ≤ M for all large N
  -- This contradicts δ₁δ₂ > 0
  sorry

-- ============================================================================
-- COROLLARIES
-- ============================================================================

-- Sumset must be infinite or have positive density
theorem sumset_infinite_or_dense (A B : Set ℕ) (hA : PositiveDensity A) (hB : PositiveDensity B) :
    Set.Infinite (Sumset A B) ∨ PositiveDensity (Sumset A B) := by
  left
  exact sumset_infinite_from_density A B hA hB

-- Special case: A = B
theorem sumset_self_infinite (A : Set ℕ) (hA : PositiveDensity A) :
    Set.Infinite (Sumset A A) := by
  exact sumset_infinite_from_density A A hA hA

-- Improved bound: size of sumset (Cauchy-Davenport)
theorem cauchy_davenport_bound (A B : Finset ℕ) (hA : A.card > 0) (hB : B.card > 0) :
    (Finset.image (fun ⟨a, b⟩ => a + b) (A ×ˢ B)).card ≥
    min (A.card + B.card - 1) (Nat.max A.card B.card) := by
  -- For finite sets in ℤ_p, |A+B| ≥ min(p, |A|+|B|-1)
  -- For ℕ, we get lower bound from maximum of sizes
  sorry

end Erdos
