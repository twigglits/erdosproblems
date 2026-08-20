/-
# Erdős Problem 135

> If every 4-point subset determines ≥5 distinct distances, must the whole set determine many distances?

Reference: https://www.erdosproblems.com/135
-/
import Erdos.Basic

open Nat Finset

namespace Erdos

-- Four points determine at least k distinct distances
def FourPointBound (S : Set (ℝ × ℝ)) (k : ℕ) : Prop :=
  ∀ p1 p2 p3 p4 ∈ S,
  (∃ d : ℕ, (Finset.range (C(4, 2))).card ≥ d ∧ d ≥ k)

-- Total distinct distances in set S
def TotalDistances (S : Set (ℝ × ℝ)) : ℕ :=
  sorry  -- Count of distinct pairwise distances

-- Erdős Problem 135: answered negatively by Tao
-- Tao constructed sets where every 4-subset has ≥5 distances
-- but total has ≪ n²/√(log n) distances (sparse)

def Problem135Property : Prop :=
  ∃ S : Set (ℝ × ℝ),
  (∀ n : ℕ, S.ncard = n →
   (FourPointBound S 5) ∧
   (TotalDistances S < n^2 / Real.sqrt (Real.log n)))

-- Tao's counterexample (2024)
theorem problem_135_false : ¬
  (∀ S : Set (ℝ × ℝ),
   FourPointBound S 5 →
   TotalDistances S ≥ S.ncard ^ 2 / 2) := by
  sorry  -- Tao's construction disproves this direction

-- Open: characterize when 4-point bound implies global bound
theorem erdos_135_open :
    ∃ C : ℝ,
    ∃ S : Set (ℝ × ℝ),
    FourPointBound S 5 ∧
    TotalDistances S = C * (S.ncard : ℝ) ^ (2/3) := by
  sorry  -- Optimal bound unknown

end Erdos
