/-
!!! ATTRIBUTION WARNING (added 2026-08-21) !!!

This file is named for Erdős Problem 100, but the question stated below is NOT that problem.

  Erdős Problem 100 actually asks: geometry/distances: is the diameter of A at least Cn?
  This file instead studies:       equal row and column pairs in a 0-1 matrix

See ATTRIBUTION_AUDIT.md at the repository root.  Nothing proved in this file is progress on
Erdős Problem 100.
-/
/-
# Erdős Problem 100

> For an n×n 0-1 matrix with m ones, how many equal row pairs and column pairs must exist?

Reference: https://www.erdosproblems.com/100
-/
import Erdos.Basic

open Nat Finset

namespace Erdos

-- Equal row/column pairs in matrix
def Matrix01 (n : ℕ) := Finset (Fin n) → Finset (Fin n)

def EqualRowPairs (M : Matrix01 n) : ℕ :=
  sorry  -- Number of pairs of rows that are identical

def EqualColPairs (M : Matrix01 n) : ℕ :=
  sorry  -- Number of pairs of columns that are identical

-- Main problem: bound on equal row/column pairs given number of ones
def Problem100Prop : Prop :=
  ∀ n m : ℕ,
  m ≤ n * n →
  ∀ M : Matrix01 n,
  (EqualRowPairs M + EqualColPairs M) * m ≥ n ^ 3

-- Known bound via pigeonhole
theorem erdos_100_partial (n m : ℕ) (M : Matrix01 n) :
    EqualRowPairs M + EqualColPairs M ≥ n / 100 := by
  sorry  -- Pigeonhole principle on row/column vectors

theorem erdos_100 : Problem100Prop := by
  sorry  -- Open: tight bound unknown

end Erdos
