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
def Problem72Prop : Prop :=
  ∃ α > 0, ∀ N : ℕ, MaxAPFreeLength N = Ω(N / (Real.log N) ^ α)

end Erdos
