/-
!!! ATTRIBUTION WARNING (added 2026-08-21) !!!

This file is named for Erdős Problem 244, but the question stated below is NOT that problem.

  Erdős Problem 244 actually asks: does {p + floor(C^k)} have positive density?
  This file instead studies:       covering the plane with congruent convex copies

See ATTRIBUTION_AUDIT.md at the repository root.  Nothing proved in this file is progress on
Erdős Problem 244.
-/
/-
# Erdős Problem 244

> On covering the plane with congruent copies of a convex region

Reference: https://www.erdosproblems.com/244
-/
import Erdos.Basic

open Nat Finset

namespace Erdos

-- Covering number: minimum copies to cover plane
def CoveringNumber (R : Set (ℝ × ℝ)) : ℕ :=
  sorry  -- Minimum congruent copies of R

-- Density of covering
def CoveringDensity (R : Set (ℝ × ℝ)) : ℝ :=
  sorry  -- Fraction of plane covered (may exceed 1 via overlap)

-- Erdős problem: optimal covering for various shapes
-- For disk of radius 1: optimal covering density ≈ 2/√3

theorem covering_disk :
    CoveringDensity (fun p : ℝ × ℝ => p.1^2 + p.2^2 ≤ 1) ≥ 2 / Real.sqrt 3 := by
  sorry  -- Hexagonal packing gives bound

-- Open: optimal density for regular polygons
def Problem244Prop : Prop :=
  ∀ R : Set (ℝ × ℝ),
  Convex ℝ R →
  ∃ D : ℝ,
  CoveringDensity R ≥ D

theorem erdos_244 : Problem244Prop := by
  sorry  -- Always exists covering density

end Erdos
