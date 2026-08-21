/-
!!! ATTRIBUTION WARNING (added 2026-08-21) !!!

This file is named for Erdős Problem 197, but the question stated below is NOT that problem.

  Erdős Problem 197 actually asks: can N be split into two sets each permutable to avoid monotone 3-term APs?
  This file instead studies:       chromatic number of euclidean distance graphs

See ATTRIBUTION_AUDIT.md at the repository root.  Nothing proved in this file is progress on
Erdős Problem 197.
-/
/-
# Erdős Problem 197

> On the chromatic number of distance graphs in euclidean space

Reference: https://www.erdosproblems.com/197
-/
import Erdos.Basic

open Nat Finset

namespace Erdos

-- Distance graph: vertices are points, edges connect points at distance r
def DistanceGraph (r : ℝ) : Set (ℝ × ℝ × (ℝ × ℝ)) :=
  sorry  -- Graph of points with unit distances

-- Chromatic number of unit distance graph in plane
def ChromaticDistanceGraph (d : ℕ) : ℕ :=
  sorry  -- Chromatic number for dimension d

-- Known: χ(ℝ²) ≥ 5 (explicit coloring, not all points 2-colorable at unit distance)
theorem chromatic_plane_lower :
    ChromaticDistanceGraph 2 ≥ 5 := by
  sorry  -- 5-coloring exists for unit distance graph in ℝ²

-- Upper bound: χ(ℝ²) ≤ 7
theorem chromatic_plane_upper :
    ChromaticDistanceGraph 2 ≤ 7 := by
  sorry  -- 7-coloring known; optimal value unknown

-- Erdős problem: exact chromatic number
def Problem197Prop : Prop :=
  ChromaticDistanceGraph 2 = 5 ∨
  ChromaticDistanceGraph 2 = 6 ∨
  ChromaticDistanceGraph 2 = 7

theorem erdos_197 : Problem197Prop := by
  sorry  -- Open: exact value unknown (conjectured 5 or 6)

end Erdos
