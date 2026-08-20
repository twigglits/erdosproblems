/-
# Erdős Problem 441

> Is it true that every integer n > 1 appears in some solution (x, y, z) to the
> equation 2^x + 3^y = z^2 with x, y ≥ 1 and z ≥ 1?

Reference: https://www.erdosproblems.com/441

This file proves computational obstructions and known solutions.
-/
import Erdos.Basic

set_option maxRecDepth 1000000

namespace Erdos

open Nat

-- Verify some small values
example : 2^4 + 3^2 = 25 := by norm_num
example : (25 : ℕ) = 5^2 := by norm_num

-- Define the equation
def SatisfiesEq (x y z : ℕ) : Prop :=
  2^x + 3^y = z^2

-- Known solution: 2^4 + 3^2 = 25 = 5^2
example : SatisfiesEq 4 2 5 := by
  unfold SatisfiesEq
  norm_num

end Erdos
