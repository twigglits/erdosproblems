/-
# Erdős Problem 195

> If all finite graphs have the property that every edge-coloring with n colors contains a monochromatic path of length 2^n, what is the minimum n?

Reference: https://www.erdosproblems.com/195

This file formalizes Ramsey-theoretic bounds for monochromatic paths.
-/
import Erdos.Basic

set_option maxRecDepth 1000000

namespace Erdos

open Nat

-- Monochromatic path of length k in an n-coloring
def MonochromaticPath (n k : ℕ) : Prop :=
  ∀ coloring : ℕ → ℕ, (∃ color c : ℕ, c < n ∧ ∀ i ∈ Finset.range k, coloring i = c)

-- Ramsey-theoretic bound: existence of monochromatic structure
theorem monochromatic_path_bound (n : ℕ) :
    ∃ k, MonochromaticPath n k := by
  sorry

end Erdos
