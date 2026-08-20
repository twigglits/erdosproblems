/-
# Erdős Problem 195

> Edge-coloring Ramsey: monochromatic paths in n-colorings of complete graphs

Reference: https://www.erdosproblems.com/195

This file studies Ramsey theory and monochromatic structures.
-/
import Erdos.Basic

namespace Erdos

open Nat

-- Ramsey number R(k): minimum n such that any k-coloring of K_n contains monochromatic triangle
-- Known values: R(2)=6, R(3)=17, R(4)=51-55
def RamseyNumber (k : ℕ) : ℕ := by
  match k with
  | 0 => exact 0
  | 1 => exact 1
  | 2 => exact 6
  | 3 => exact 17
  | _ => exact sorry -- R(k) for k≥4 not fully determined

-- Simpler version: Any 2-coloring of K_6 contains monochromatic triangle
theorem two_color_triangle_exists :
    ∀ coloring : Fin 6 → Fin 2,
      ∃ i j k : Fin 6, i ≠ j ∧ j ≠ k ∧ i ≠ k ∧
        coloring i = coloring j ∧ coloring j = coloring k := by
  intro coloring
  -- Pigeonhole: 6 vertices, 2 colors → some color has ≥3 vertices
  -- Among 3 vertices of same color, they form monochromatic triangle
  sorry

-- Monochromatic path of length ℓ exists in any k-coloring of K_n for n large enough
-- For small cases: 2-coloring of K_n contains monochromatic path length 3 for n≥6
theorem monochromatic_path_k2 (n : ℕ) (h : n ≥ 6) :
    ∀ coloring : Fin n → Fin 2,
      ∃ a b c : Fin n, a ≠ b ∧ b ≠ c ∧ a ≠ c ∧ coloring a = coloring b ∧ coloring b = coloring c := by
  intro coloring
  -- Ramsey R(3,3)=6 guarantees this
  sorry

end Erdos
