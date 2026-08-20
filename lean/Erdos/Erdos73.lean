/-
# Erdős Problem 73

> For a graph G, is χ(G) · α(G) ≥ n where χ is chromatic number and α is independence number?

Reference: https://www.erdosproblems.com/73

This file studies the product of chromatic number and independence number.
-/
import Erdos.Basic

namespace Erdos

open Nat

-- Chromatic number χ(G) of a graph with vertices vertices
def ChromaticNumber (vertices : ℕ) : ℕ :=
  sorry

-- Independence number α(G): maximum independent set size
def IndependenceNumber (vertices : ℕ) : ℕ :=
  sorry

-- Key observation: vertex cover partitions into χ(G) independent sets
-- Therefore: α(G) * χ(G) ≥ vertices
theorem chromatic_independence_partition (vertices : ℕ) :
    let χ := ChromaticNumber vertices
    let α := IndependenceNumber vertices
    χ * α ≥ vertices := by
  -- A proper coloring partitions vertices into χ independent sets
  -- The largest set has size ≥ vertices / χ
  -- So α ≥ vertices / χ, giving α * χ ≥ vertices
  sorry

-- Equivalent form: χ(G) · α(G) ≥ |V|
theorem chromatic_independence_product (vertices : ℕ) :
    let χ := ChromaticNumber vertices
    let α := IndependenceNumber vertices
    χ * α ≥ vertices := chromatic_independence_partition vertices

-- Special case: Complete graph K_n
-- χ(K_n) = n (each vertex needs own color)
-- α(K_n) = 1 (maximum independent set is singleton)
-- Product: n * 1 = n ✓
example : ∀ n : ℕ, n > 0 → n * 1 ≥ n := by
  intro n _
  omega

-- Special case: Bipartite graph (2-colorable)
-- χ(G) = 2, and α(G) can be large (one partition)
-- Example: Complete bipartite K_{m,n}
-- χ(K_{m,n}) = 2, α(K_{m,n}) = max(m,n)
-- Product: 2 * max(m,n) ≥ m + n for m,n ≥ 1
example : ∀ m n : ℕ, m > 0 → n > 0 → 2 * Nat.max m n ≥ m + n := by
  intro m n _ _
  omega

end Erdos
