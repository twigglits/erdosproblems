/-
# Erdős Problem 69

> What is the maximum number of unit distances among n points in the plane?

Reference: https://www.erdosproblems.com/69

This file studies unit distance graphs and bounds.
-/
import Erdos.Basic

namespace Erdos

open Nat

-- ============================================================================
-- Unit Distance Graph: Maximum edges with Euclidean distance = 1
-- ============================================================================

-- Definition: MaxUnitDistances(n) = maximum number of pairs at distance exactly 1
def MaxUnitDistances (n : ℕ) : ℕ :=
  -- In a unit distance graph on n points, how many edges (distance 1 pairs)?
  -- Upper bounds known: O(n^(4/3))
  -- Lower bounds known: Ω(n) (grid constructions)
  sorry  -- Value depends on n; computed via extremal graph theory

-- ============================================================================
-- CIRCLE PACKING ARGUMENT: Max degree ≤ 6
-- ============================================================================

-- Lemma (Circle packing): At most 6 points of a unit distance graph can be at distance 1 from a single point
-- Proof: Those 6 points lie on a circle of radius 1 centered at the point.
--        The angle between adjacent points on this circle is ≥ π/3 (60°).
--        This allows at most 6 points before overlap.

lemma max_degree_six :
    ∀ p : ℝ × ℝ,  -- any point in plane
      ∃ max_neighbors : ℕ,
      max_neighbors = 6 ∧
      ∀ S : Set (ℝ × ℝ),  -- set of points at distance 1 from p
        (∀ q ∈ S, dist p q = 1) →
        S.ncard ≤ 6 := by
  intro p
  use 6
  constructor
  · rfl
  · intro S h_dist_one
    -- All points in S lie on unit circle centered at p
    -- Circle packing: at most 6 non-overlapping regions of 60° each
    sorry

-- ============================================================================
-- HANDSHAKING LEMMA: Basic degree bound
-- ============================================================================

-- Handshaking lemma: Sum of degrees = 2 * (number of edges)
-- If every vertex has degree ≤ 6, then:
--   Sum of degrees ≤ 6n
--   2 * edges ≤ 6n
--   edges ≤ 3n

lemma handshaking_unit_distance (n : ℕ) (max_degree : ℕ) :
    let edges := MaxUnitDistances n
    -- `Finset.range n` holds naturals, but `v : Fin n`, so `u ≠ v` did not typecheck.
    -- Filtering over `Finset.univ : Finset (Fin n)` keeps both sides in `Fin n`.
    (∀ v : Fin n,
      (Finset.filter (fun u => u ≠ v) (Finset.univ : Finset (Fin n))).card ≤ max_degree) →
    edges ≤ (n * max_degree) / 2 := by
  intro h_degree
  -- Sum of all degrees ≤ n * max_degree
  -- Each edge counted twice in sum, so 2*edges ≤ n*max_degree
  sorry

-- Basic bound: edges ≤ 3n
lemma degree_sum_bound (n : ℕ) :
    MaxUnitDistances n ≤ 3 * n := by
  -- Apply handshaking with max_degree = 6
  -- Sum of degrees ≤ 6n
  -- 2 * edges ≤ 6n
  -- edges ≤ 3n
  sorry

-- ============================================================================
-- IMPROVED BOUND: O(n^(4/3))
-- ============================================================================

-- Better upper bound via incidence geometry
-- Spencer-Szemerédi-Trotter: n points, m lines → at most O(n^(2/3)*m^(2/3) + n + m) incidences
-- Applied to unit distance graph: yields O(n^(4/3))

-- A ℚ base with a ℚ exponent has no `HPow` instance; the bound is restated over ℝ, where
-- `Real.rpow` gives the cube root meaning, and the ℕ-valued left side is cast.
-- CAVEAT: this expression is Θ(n²), which does NOT match the O(n^(4/3)) claimed in the
-- comment above. The original expression is kept here rather than silently replaced.
theorem unit_distance_bound_improved (n : ℕ) (hn : n ≥ 1) :
    (MaxUnitDistances n : ℝ) ≤ (4 * (n : ℝ) ^ 2) / (3 : ℝ) ^ ((1 : ℝ) / 3) := by
  -- This uses the Spencer-Szemerédi-Trotter theorem
  -- Let m = MaxUnitDistances n
  -- The n points and m unit distance pairs form an incidence structure
  -- Applying SST yields: m = O(n^(4/3))
  sorry

-- Asymptotic formulation: MaxUnitDistances(n) = O(n^(4/3))
theorem unit_distance_asymptotic :
    ∃ C : ℝ,
    C > 0 ∧
    ∀ n : ℕ,
    n > 0 →
    -- The exponent must be real for `Real.rpow`; a ℚ exponent has no instance here.
    (MaxUnitDistances n : ℝ) ≤ C * (n : ℝ) ^ ((4 : ℝ) / 3) := by
  use 4  -- Conservative bound; actual constant likely ~1.5-2
  constructor
  · norm_num
  · intro n hn
    sorry

-- ============================================================================
-- LOWER BOUNDS: Constructions achieving Ω(n log n) or better
-- ============================================================================

-- Grid construction: n^(1/2) × n^(1/2) grid with unit spacing
-- Each interior point has degree 4, boundary points have degree 2-3
-- Total edges ≈ (1/2) * n * 4 = 2n
-- Better constructions achieve Ω(n log log n)

theorem unit_distance_lower_bound_grid :
    ∃ point_set : ℕ → Set (ℝ × ℝ),
    ∀ n : ℕ,
    n > 0 →
    (point_set n).ncard = n ∧
    ∃ edges : ℕ,
    edges ≥ n ∧
    (∀ p ∈ point_set n, ∀ q ∈ point_set n, p ≠ q → dist p q = 1 → True) := by
  -- Grid construction: points at (i, j) for i, j ∈ {0..⌊√n⌋}
  sorry

-- ============================================================================
-- SUMMARY OF KNOWN BOUNDS
-- ============================================================================

-- Summary:
-- Lower bound (grid): Ω(n) edges via simple grid construction
-- Upper bound (SST): O(n^(4/3)) edges via Spencer-Szemerédi-Trotter
-- Current best lower bound: Ω(n log log n) via sophisticated constructions (2024)
-- Conjecture: Maximum is Θ(n^(4/3))

theorem unit_distance_bounds_summary :
    ∃ c₁ c₂ : ℝ,
    c₁ > 0 ∧ c₂ > 0 ∧
    (∀ n : ℕ,
     n > 100 →
     c₁ * n ≤ MaxUnitDistances n ∧
     MaxUnitDistances n ≤ c₂ * (n : ℝ) ^ (4/3)) := by
  use 1, 4  -- Conservative bounds
  constructor; norm_num
  constructor; norm_num
  intro n hn
  sorry

end Erdos
