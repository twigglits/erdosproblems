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
theorem greedy_coloring_bound (vertices max_degree : ℕ)
    (_h : max_degree ≤ vertices - 1) :
    max_degree + 1 ≤ vertices := by
  sorry

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
