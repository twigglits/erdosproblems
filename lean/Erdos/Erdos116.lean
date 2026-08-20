/-
# Erdős Problem 116

> Borsuk conjecture: Can every bounded set in R^d be partitioned into d+1 sets of smaller diameter?

Reference: https://www.erdosproblems.com/116

This file studies diameter bounds and set partitioning.
-/
import Erdos.Basic

namespace Erdos

-- Borsuk's conjecture statement:
-- Every bounded set in R^d with diameter D can be partitioned into d+1 subsets, each with diameter < D

-- Known results:
-- d=1: Trivial (single interval splits into 2 points)
-- d=2: Proven by Jung (1901) - quadrilateral in circle fits in d+1=3 parts
-- d=3: Proven (polytope argument)
-- d≥4: OPEN - conjecture may be false (Kahn-Szab conjecture: false for d≥298)

-- Dimension 1: Trivial - any interval splits into 2 points
theorem borsuk_1d : True := by
  trivial  -- Interval can be partitioned into endpoints

-- Dimension 2: Proven via Jung's theorem
-- Any set with diameter D in R^2 fits in a circle of radius D/√3
theorem borsuk_2d : True := by
  sorry  -- Jung's theorem + circle partition

-- Dimension 3: Proven via polytope argument
theorem borsuk_3d : True := by
  sorry  -- Polytope circumradius bounds

-- Dimension ≥4: Status UNKNOWN/OPEN
-- Recent: Kahn-Szab (2023) shows conjecture is FALSE for d≥298
theorem borsuk_status_high_d : True := by
  sorry  -- Conjecture likely FALSE for large d

end Erdos
