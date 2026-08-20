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

-- Sumset must be infinite or have positive density
theorem sumset_density (A B : Set ℕ) (hA : PositiveDensity A) (hB : PositiveDensity B) :
    Set.Infinite (Sumset A B) ∨ PositiveDensity (Sumset A B) := by
  sorry

end Erdos
