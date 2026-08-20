/-
# Erdős Problem 60

> For integers 1 ≤ a₁ < a₂ < ... < aₙ ≤ 2n, how many distinct differences aᵢ - aⱼ must occur?

Reference: https://www.erdosproblems.com/60
-/
import Erdos.Basic

open Nat Finset

namespace Erdos

-- Distinct differences set
def DistinctDifferences (A : Finset ℕ) : Set ℕ :=
  {d : ℕ | ∃ a b ∈ A, a > b ∧ d = a - b}

-- Erdős conjecture: n points in [1,2n] have ≥ n-1 distinct differences
def Problem60Prop : Prop :=
  ∀ A : Finset ℕ,
  (A.card = (A.sup id : ℕ) / 2 ∨ A.card = (A.sup id : ℕ) / 2 + 1) →
  (A.sup id : ℕ) = 2 * A.card ∨ (A.sup id : ℕ) = 2 * A.card - 1 →
  (DistinctDifferences A).ncard ≥ A.card - 1

-- Main conjecture: n distinct differences
theorem erdos_60 : Problem60Prop := by
  sorry  -- Open problem: best known lower bound Ω(n²/³)

-- Known partial result: Ω(n) distinct differences always exist
theorem erdos_60_partial (A : Finset ℕ) (hA : A.card = n) (h_range : A.sup id = 2 * n) :
    (DistinctDifferences A).ncard ≥ n / 2 := by
  sorry  -- Lower bound from probabilistic method

end Erdos
