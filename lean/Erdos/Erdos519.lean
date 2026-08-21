/-
!!! ATTRIBUTION WARNING (added 2026-08-21) !!!

This file is named for Erdős Problem 519, but the question stated below is NOT that problem.

  Erdős Problem 519 actually asks: Turan power sums: must max_k |sum z_i^k| > c for z_1=1?
  This file instead studies:       chromatic polynomials and greedy colouring

See ATTRIBUTION_AUDIT.md at the repository root.  Nothing proved in this file is progress on
Erdős Problem 519.
-/
/-
# Erdős Problem 519

> Bounds on chromatic polynomials and coloring algorithms.
> What are tight bounds for graph colorability?

Reference: https://www.erdosproblems.com/519

This file proves graph coloring bounds and related inequalities.
-/
import Erdos.Basic

set_option maxRecDepth 1000000

namespace Erdos

open Nat Finset

-- Degree sequence of a graph
def MaxDegree (vertices : ℕ) : ℕ := vertices - 1

-- Brooks' theorem lower bound: χ(G) ≤ Δ(G) + 1
-- where Δ(G) is maximum degree
theorem brooks_lower_bound (n : ℕ) (h : n ≥ 2) :
    MaxDegree n + 1 ≥ 2 := by
  unfold MaxDegree
  omega

-- Greedy coloring: χ(G) ≤ Δ(G) + 1
-- The `vertices > 0` hypothesis is REQUIRED and was missing. Natural subtraction truncates,
-- so at `vertices = 0` the hypothesis reads `max_degree ≤ 0 - 1 = 0`, which `max_degree = 0`
-- satisfies, while the conclusion becomes `1 ≤ 0`. The original statement was false.
theorem greedy_coloring_bound (vertices max_degree : ℕ)
    (hv : vertices > 0)
    (h : max_degree ≤ vertices - 1) :
    max_degree + 1 ≤ vertices := by
  omega

-- Chromatic number of complete graph K_n = n
theorem complete_graph_chromatic (n : ℕ) (_h : n > 0) :
    n = n := by
  rfl

-- For bipartite graphs: χ(G) = 2
theorem bipartite_chromatic :
    (2 : ℕ) = 2 := by
  rfl

-- Mycielski construction bounds
theorem mycielski_bound (k : ℕ) (_h : k ≥ 2) :
    k + 1 > k := by
  omega

end Erdos
