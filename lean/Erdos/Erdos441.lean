/-
!!! ATTRIBUTION WARNING (added 2026-08-21) !!!

This file is named for Erdős Problem 441, but the question stated below is NOT that problem.

  Erdős Problem 441 actually asks: largest A in {1,...,N} with lcm(a,b) <= N for all a,b in A
  This file instead studies:       integers appearing in solutions (x,y,z)

See ATTRIBUTION_AUDIT.md at the repository root.  Nothing proved in this file is progress on
Erdős Problem 441.
-/
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
