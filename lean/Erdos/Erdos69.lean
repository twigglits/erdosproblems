/-
# Erdős Problem 69

> What is the maximum number of unit distances among n points in the plane?

Reference: https://www.erdosproblems.com/69

This file studies unit distance graphs and bounds.
-/
import Erdos.Basic

namespace Erdos

open Nat

-- Points at unit distance
def UnitDistancePairs (n : ℕ) : ℕ :=
  sorry

-- Erdős unit distance bound
theorem unit_distance_bound (n : ℕ) :
    UnitDistancePairs n ≤ n^(4/3) := by
  sorry

end Erdos
