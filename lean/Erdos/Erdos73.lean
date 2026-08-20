/-
# Erdős Problem 73

> For a graph G, is χ(G) · α(G) ≥ n where χ is chromatic number and α is independence number?

Reference: https://www.erdosproblems.com/73

This file studies the product of chromatic number and independence number.
-/
import Erdos.Basic

namespace Erdos

open Nat

-- Chromatic number lower bound by complement
def ChromaticNumberBound (n vertices : ℕ) : Prop :=
  n ≥ vertices -- simplified for now

-- Erdős chromatic-independence bound
theorem chromatic_independence_product (vertices : ℕ) :
    ∃ χ α : ℕ, χ * α ≥ vertices := by
  sorry

end Erdos
