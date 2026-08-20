/-
# Erdős Problem 150

> On colorings of complete graphs and monochromatic cliques

Reference: https://www.erdosproblems.com/150
-/
import Erdos.Basic

open Nat Finset

namespace Erdos

-- Ramsey-type: k-coloring of K_n contains monochromatic clique
def RamseyClique (n k ℓ : ℕ) : Prop :=
  ∀ coloring : Fin n → Fin k,
  ∃ i j m : Fin n,
  (∀ x ∈ Finset.filter (fun x => coloring x = coloring i) (Finset.univ),
   x < m) ∧
  (Finset.filter (fun x => coloring x = coloring i) (Finset.univ)).card ≥ ℓ

-- Erdős' problem: optimal bounds for monochromatic structures
theorem erdos_150 :
    ∀ k ℓ : ℕ,
    ∃ R : ℕ,
    ∀ n ≥ R,
    RamseyClique n k ℓ := by
  sorry  -- Ramsey numbers exist but often unknown

-- Sparse bounds: R(3,3,...,3) with k 3's
theorem ramsey_lower_bound (k : ℕ) :
    ∃ n : ℕ,
    ¬ RamseyClique n k 3 := by
  sorry  -- Probabilistic lower bound

end Erdos
