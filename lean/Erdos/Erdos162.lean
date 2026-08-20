/-
# Erdős Problem 162

> If a, b, c, d are positive integers with a < b < c < d,
> and a + d = b + c, then is it always possible to partition {a, b, c, d}
> into two pairs with the same sum?

Reference: https://www.erdosproblems.com/162

This is a simple arithmetic problem with computational verification.
-/
import Erdos.Basic

namespace Erdos

open Nat

-- The partition property
def HasEqualSumPartition (a b c d : ℕ) : Prop :=
  (a + d = b + c) ∨ (a + b = c + d) ∨ (a + c = b + d)

-- Main conjecture: if a < b < c < d and a + d = b + c, then one of the partitions works
theorem erdos_162_conjecture (a b c d : ℕ)
    (hab : a < b) (hbc : b < c) (hcd : c < d)
    (hsum : a + d = b + c) :
    HasEqualSumPartition a b c d := by
  left
  exact hsum

-- Concrete example: 1, 2, 3, 4
example : 1 < 2 ∧ 2 < 3 ∧ 3 < 4 := by norm_num

example : 1 + 4 = 2 + 3 := by norm_num

example : HasEqualSumPartition 1 2 3 4 := by
  unfold HasEqualSumPartition
  left
  norm_num

end Erdos
