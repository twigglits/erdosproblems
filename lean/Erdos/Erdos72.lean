/-
!!! ATTRIBUTION WARNING (added 2026-08-21) !!!

This file is named for Erdős Problem 72, but the question stated below is NOT that problem.

  Erdős Problem 72 actually asks: graph theory, cycles ($100, proved) - statement not the one in this file
  This file instead studies:       maximum size of an AP-free subset of {1,...,N}

See ATTRIBUTION_AUDIT.md at the repository root.  Nothing proved in this file is progress on
Erdős Problem 72.
-/
/-
# Erdős Problem 72

> For a sequence 1 ≤ a₁ < a₂ < ... < aₙ ≤ N with no 3-term AP, what is the maximum n?

Reference: https://www.erdosproblems.com/72
-/
import Erdos.Basic

open Nat Finset

namespace Erdos

-- AP-free sequence bound
def MaxAPFreeLength (N : ℕ) : ℕ :=
  sorry  -- Maximum |A| where A ⊆ [1,N] with no 3-term AP

-- Lower bound: via random/constructive methods
theorem erdos_72_lower (N : ℕ) :
    MaxAPFreeLength N ≥ N / (Real.log (Real.log N) + 1) := by
  sorry  -- Szemerédi + probabilistic construction

-- Upper bound: via density argument
theorem erdos_72_upper (N : ℕ) :
    MaxAPFreeLength N ≤ N / (Real.log N) ^ (1/3) := by
  sorry  -- Density bounds (best known 2023)

-- Main problem: close the gap between bounds
-- `Ω(...)` is asymptotic notation, not Lean syntax, and `=` is the wrong relation for it.
-- "f is Ω(g)" unfolds to: some positive constant `c` and threshold `N₀` exist with
-- `f N ≥ c * g N` for every `N ≥ N₀`. `MaxAPFreeLength` is ℕ-valued, so it is cast to ℝ.
def Problem72Prop : Prop :=
  ∃ α > 0, ∃ c > 0, ∃ N₀ : ℕ, ∀ N ≥ N₀,
    (MaxAPFreeLength N : ℝ) ≥ c * ((N : ℝ) / (Real.log N) ^ α)

end Erdos
