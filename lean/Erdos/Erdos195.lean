/-
# Erdős Problem 195

> Edge-coloring Ramsey: monochromatic paths in n-colorings of complete graphs

Reference: https://www.erdosproblems.com/195

This file studies Ramsey theory and monochromatic structures.
-/
import Erdos.Basic

namespace Erdos

open Nat

-- Ramsey number R(k): minimum n such that any k-coloring of edges of K_n contains monochromatic triangle
-- Known values: R(2)=6, R(3)=17, R(4)=51-55
-- Note: R(2) means 2 colors, edge coloring (not vertex coloring)
def RamseyNumber (k : ℕ) : ℕ := by
  match k with
  | 0 => exact 0
  | 1 => exact 1
  | 2 => exact 6        -- R(3,3) = 6: K_6 with 2-colored edges contains monochromatic K_3
  | 3 => exact 17       -- R(3,3,3) = 17 (estimated)
  | _ => exact sorry    -- R(k) for k≥4 not fully determined

-- ============================================================================
-- CORE THEOREM: Ramsey R(3,3) = 6
-- Any 2-coloring of edges of K_6 contains monochromatic triangle
-- ============================================================================

-- First, prove pigeonhole principle for vertex-color assignment
lemma pigeonhole_six_vertices (coloring : Fin 6 → Fin 2) :
    ∃ c : Fin 2, ∃ S : Finset (Fin 6), (S.card ≥ 3) ∧ (∀ v ∈ S, coloring v = c) := by
  -- 6 vertices, 2 colors → by pigeonhole, some color has ≥ ⌈6/2⌉ = 3 vertices
  by_contra h
  push_neg at h
  -- Suppose all colors have < 3 vertices each
  -- Then total vertices ≤ 2 * 2 = 4 < 6 contradiction
  sorry

-- Key insight: Among 3 vertices of same color, we can find monochromatic triangle
-- (This requires analyzing edge colorings among the monochromatic vertex set)
lemma three_vertices_contain_triangle (v1 v2 v3 : Fin 6) (h : v1 ≠ v2 ∧ v2 ≠ v3 ∧ v1 ≠ v3) :
    -- Three vertices span THREE pairs, so the index type must be `Fin 3`, not `Fin 2`.
    -- As written, `(⟨2, _⟩ : Fin 2)` demanded a proof of `2 < 2`, which does not exist.
    -- NOTE: even well-typed, this statement is trivially true (it only asks that SOME
    -- colouring exist), so it does not capture the intended pigeonhole argument.
    ∃ edge_color : (Fin 3 → Fin 2),  -- one colour per pair of the three vertices
      ∃ mono_color : Fin 2,
        (edge_color 0 = mono_color) ∨
        (edge_color 1 = mono_color) ∨
        (edge_color 2 = mono_color) := by
  sorry

-- Main Ramsey theorem: R(3,3) = 6
theorem ramsey_two_color_triangle :
    ∀ edge_coloring : (Fin 6 → Fin 6 → Fin 2),
      (∀ i, edge_coloring i i = 0) →  -- no self-loops
      (∀ i j, edge_coloring i j = edge_coloring j i) →  -- symmetric
      ∃ color : Fin 2,
        ∃ i j k : Fin 6, i ≠ j ∧ j ≠ k ∧ i ≠ k ∧
          edge_coloring i j = color ∧
          edge_coloring j k = color ∧
          edge_coloring i k = color := by
  intro edge_coloring h_diag h_symm
  -- Apply pigeonhole to find monochromatic vertex set
  -- Then analyze triangle formation among those vertices
  sorry

-- Vertex-coloring version (alternative formulation)
theorem two_color_triangle_vertex (vertex_coloring : Fin 6 → Fin 2) :
    ∃ i j k : Fin 6, i ≠ j ∧ j ≠ k ∧ i ≠ k ∧
      vertex_coloring i = vertex_coloring j ∧
      vertex_coloring j = vertex_coloring k := by
  -- Pigeonhole: 6 vertices, 2 colors → some color has ≥3 vertices
  obtain ⟨c, S, hcard, hcolors⟩ := pigeonhole_six_vertices vertex_coloring
  -- Extract 3 distinct vertices from S
  have h3 := Finset.card_pos.mp (by omega : S.card > 0)
  sorry

-- Monochromatic path of length 3 in any 2-coloring of edges of K_6
theorem monochromatic_path_2color (n : ℕ) (h : n ≥ 6) :
    ∀ edge_coloring : (Fin n → Fin n → Fin 2),
      (∀ i, edge_coloring i i = 0) →
      (∀ i j, edge_coloring i j = edge_coloring j i) →
      ∃ a b c : Fin n, a ≠ b ∧ b ≠ c ∧ a ≠ c ∧
        edge_coloring a b = edge_coloring b c ∧
        edge_coloring a b = edge_coloring a c := by
  intro edge_coloring h_diag h_symm
  -- Restrict to first 6 vertices and apply Ramsey R(3,3)=6
  -- This gives monochromatic triangle, which is a path of length 3
  sorry

-- Generalization: k-coloring of edges requires larger n
-- `Fin k` only has a `0` when `k ≠ 0`, so the `NeZero k` instance is required for
-- `edge_coloring i i = 0` to elaborate.
theorem monochromatic_path_kcolor (k n : ℕ) [NeZero k] (h : n ≥ RamseyNumber k) :
    ∀ edge_coloring : (Fin n → Fin n → Fin k),
      (∀ i, edge_coloring i i = 0) →
      (∀ i j, edge_coloring i j = edge_coloring j i) →
      ∃ color : Fin k,
        ∃ a b c : Fin n, a ≠ b ∧ b ≠ c ∧ a ≠ c ∧
          edge_coloring a b = color ∧
          edge_coloring b c = color ∧
          edge_coloring a c = color := by
  sorry

end Erdos
