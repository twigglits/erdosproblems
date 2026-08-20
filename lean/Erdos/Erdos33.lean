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

-- Sumset A + B = {a + b : a ∈ A, b ∈ B}
def Sumset (A B : Set ℕ) : Set ℕ :=
  {n : ℕ | ∃ a ∈ A, ∃ b ∈ B, n = a + b}

-- Positive lower density
def PositiveDensity (A : Set ℕ) : Prop :=
  ∃ δ > 0, ∀ N : ℕ, (Finset.filter (· ∈ A) (Finset.range N)).card > δ * N

-- Key lemma: Sumset is infinite if both sets have positive density
lemma sumset_infinite_from_density (A B : Set ℕ) (hA : PositiveDensity A) (hB : PositiveDensity B) :
    Set.Infinite (Sumset A B) := by
  -- Suppose Sumset A+B is finite, bound by M
  by_contra h_finite
  push_neg at h_finite
  -- Then A+B ⊆ {0, 1, ..., M}
  have hM : ∀ n ∈ Sumset A B, n ≤ M := sorry -- from finiteness
  -- For large N, we can count |A ∩ [1,N]| ≥ δ₁N and |B ∩ [1,N]| ≥ δ₂N
  -- Then |A+B ∩ [2, 2N]| ≥ (δ₁N)(δ₂N) / |A| × |B| by convolution
  -- But A+B has only M elements, contradiction for large N
  sorry

-- Sumset must be infinite or have positive density
theorem sumset_density (A B : Set ℕ) (hA : PositiveDensity A) (hB : PositiveDensity B) :
    Set.Infinite (Sumset A B) ∨ PositiveDensity (Sumset A B) := by
  left
  exact sumset_infinite_from_density A B hA hB

end Erdos
