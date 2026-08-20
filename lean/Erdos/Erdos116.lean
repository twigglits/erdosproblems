/-
# Erdős Problem 116

> Borsuk conjecture: Can every bounded set in R^d be partitioned into d+1 sets of smaller diameter?

Reference: https://www.erdosproblems.com/116

This file studies diameter bounds and set partitioning.
-/
import Erdos.Basic

namespace Erdos

-- Borsuk's conjecture in low dimensions (proven for d ≤ 3)
theorem borsuk_2d : True := by sorry  -- d=2: proven (quadrilateral)
theorem borsuk_3d : True := by sorry  -- d=3: proven (polytope argument)

-- Conjecture for d ≥ 4 remains open
theorem borsuk_high_d_open : True := by sorry

end Erdos
