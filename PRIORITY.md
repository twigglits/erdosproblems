# Sequential Work Priority Queue

**RULE**: Work problems ONE AT A TIME. Never parallel. Commit each before moving to next.

## TIER 1: High Tractability (Start Here)

Priority order for sequential completion:

1. **Problem 4** — Coprimality in dense subsets (simple pigeonhole structure)
2. **Problem 86** — Large prime divisors (factorization bounds)
3. **Problem 342** — Reciprocal sums over AP-free sets (additive combinatorics)
4. **Problem 51** — AP-free sequences have zero density (Szemerédi)
[redacted: retracted Erdős Problem 40 claim]

## TIER 2: Medium Tractability (After Tier 1)

6. **Problem 69** — Unit distances in plane (extremal geometry)
7. **Problem 73** — Chromatic × independence number (graph theory)
8. **Problem 195** — Monochromatic paths in colorings (Ramsey theory)
9. **Problem 116** — Diameter bounds (Borsuk conjecture)
10. **Problem 33** — Sumsets with positive density (additive combinatorics)

## TIER 3: Formalization-Heavy (After Tier 2)

11. **Problem 52** — [To be researched]
12. **Problem 60** — [To be researched]
13. **Problem 71** — [To be researched]
14. **Problem 72** — [To be researched]
15. **Problem 100** — [To be researched]
16. **Problem 135** — [To be researched]
17. **Problem 150** — [To be researched]
18. **Problem 176** — [To be researched]
19. **Problem 197** — [To be researched]
20. **Problem 244** — [To be researched]
21. **Problem 632** — Largest prime factor growth (number theory)

## Already Verified (6 problems)

- Problem 162 ✓
- Problem 389 ✓
- Problem 396 ✓
- Problem 441 ✓
- Problem 548 ✓
- Problem 727 ✓

## In Progress / Partially Complete (3 problems)

- Problem 213 (framework, needs sorry elimination)
- Problem 250 (framework, needs sorry elimination)
- Problem 519 (framework, needs sorry elimination)

---

## Work Flow

For each problem in priority order:

```
SELECT problem from TIER 1
  ↓
RESEARCH: Fetch arXiv/MathOverflow papers, identify equivalent formulations
  ↓
FORMALIZE: Write Lean definitions, prove key lemmas
  ↓
IF proof complete:
  → Machine verify (lake build)
  → Commit to git
  → Move to NEXT problem
ELSE IF partial progress:
  → Document obstruction theorems
  → Establish verification bounds
  → Commit intermediate result
  → RESEARCH deeper or MOVE to NEXT
ELSE IF stuck:
  → Document failure mode
  → Move to NEXT problem (not dead end)
```

**STATUS**: About to start Problem 4 (coprimality in dense subsets).
