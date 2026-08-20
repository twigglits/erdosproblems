/-
# Erdős Problem 195

> Edge-coloring Ramsey: monochromatic paths in n-colorings of complete graphs

Reference: https://www.erdosproblems.com/195

This file studies Ramsey theory and monochromatic structures.
-/
import Erdos.Basic

namespace Erdos

open Nat

-- Ramsey number R(3,3,...,3): minimum n such that any k-coloring of K_n contains monochromatic triangle
def RamseyNumber (k : ℕ) : ℕ := sorry

-- Monochromatic path of length ℓ exists in any k-coloring of K_n for n large enough
theorem monochromatic_path_exists (k ℓ : ℕ) :
    ∃ n₀, ∀ n ≥ n₀, ∀ coloring : ℕ → ℕ, 
      (∃ color : ℕ, color < k ∧ ∃ path : List ℕ, path.length = ℓ ∧
        ∀ i j, i.succ = j → coloring (path.nthLe i sorry) = color) := by
  sorry

end Erdos
