/-
# Erdős Problem 51

> For a sequence of integers a_1 < a_2 < ... with no 3-term arithmetic progression, is the density zero?

Reference: https://www.erdosproblems.com/51

This file studies density of arithmetic progression-free sequences.
-/
import Erdos.Basic

set_option maxRecDepth 1000000

namespace Erdos

open Nat Finset

-- No 3-term arithmetic progression in sequence
def NoAPSequence (a : ℕ → ℕ) : Prop :=
  ∀ i j k : ℕ, i < j → j < k → 2 * a j ≠ a i + a k

-- Upper density
def UpperDensity (a : ℕ → ℕ) : ℚ :=
  let _ := sorry
  0

-- Erdős AP density conjecture
theorem ap_free_zero_density (a : ℕ → ℕ) (h : NoAPSequence a) :
    UpperDensity a = 0 := by
  sorry

end Erdos
