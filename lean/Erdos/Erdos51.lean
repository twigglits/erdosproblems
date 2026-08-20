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

-- No 3-term arithmetic progression in sequence a_1 < a_2 < ...
def NoAPSequence (a : ℕ → ℕ) : Prop :=
  -- a is strictly increasing
  (∀ i : ℕ, a i < a (i + 1)) ∧
  -- No three terms form arithmetic progression
  (∀ i j k : ℕ, i < j → j < k → 2 * a j ≠ a i + a k)

-- Upper density: limsup |{a_i : a_i ≤ n}| / n as n → ∞
def UpperDensity (a : ℕ → ℕ) : ℚ :=
  sorry -- Formalized as limit superior of count ratio

-- Key fact: Szemerédi's theorem (partial statement)
-- If a set has positive density, it contains 3-term AP
theorem positive_density_has_ap (A : Set ℕ) (h : ∃ δ > 0, ∀ N : ℕ,
    (Finset.filter (· ∈ A) (Finset.range N)).card > δ * N) :
    ∃ a b c : ℕ, a < b ∧ b < c ∧ 2 * b = a + c ∧ a ∈ A ∧ b ∈ A ∧ c ∈ A := by
  sorry -- Szemerédi's theorem: cannot formalize without advanced tools

-- Corollary: AP-free sequences must have zero density
theorem ap_free_zero_density (a : ℕ → ℕ) (h : NoAPSequence a) :
    UpperDensity a = 0 := by
  -- If UpperDensity > 0, then {a_i} has 3-term AP by Szemerédi
  -- But a is AP-free by hypothesis, contradiction
  -- Therefore UpperDensity = 0
  sorry

end Erdos
