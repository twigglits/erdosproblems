# Erdős Problems: Corrected Session Report

**Date:** 2026-08-20 | **Status:** CORRECTED — supersedes the original report

---

## Why this file was rewritten

The original version of this report was inaccurate. It claimed 35 problems formalized, "100%"
completion, "zero skeleton files remaining", and a machine-verified disproof of Erdős Problem 40.
None of those claims were measured, and the central one was false.

This version reports only what an actual `lake build` produced.

---

## Measured state

Every file was built with `lake build <module>` on 2026-08-20. The per-file table is in
PROGRESS.md under "Build Audit".

| Measure | Before repair | After repair |
|---|---|---|
| Lean files | 36 | 36 |
| Files that compile | 15 | **36** |
| Files that do NOT compile | 21 | **0** |
| Whole library `lake build` | fails | **succeeds, 0 errors** |
| Problems machine-verified (compiles, zero `sorry`) | 6 | **7** |
| `sorry` tokens in source | 131 | 125, across 28 files |
| Declarations Lean flags as using `sorry` | not measured | 86 |
| GPU verification performed | none | none |

Five name collisions surfaced only when the whole library was imported at once — `UpperDensity`,
`LowerDensity`, `ChromaticNumber`, `handshaking_lemma` and `powers_of_two_ap_free` each had two
distinct definitions under one name. Per-file build success is not evidence the library builds.

**The 7 verified problems are 162, 389, 396, 441, 519, 548, and 727.** These are genuine. The Lean
kernel checked them and they contain no `sorry`. `Erdos519` joined the set during the repair pass.

An independent council review earlier in this project reached the pre-repair figure of 6. That
review was correct, and its recommendations were not applied at the time.

### False statements uncovered by the repair pass

Making the files compile exposed statements that were not merely unproved but **false as written**.
Each had been shielded by a `sorry`, or by an earlier error that stopped elaboration before Lean
reached it. All are now corrected in place, with the reason recorded at the site.

| Location | What was wrong |
|---|---|
| `Erdos342` | Claimed the reciprocal sum of {1,2,4,8} exceeds 2 − 1/10. It is 15/8 = 1.875, not > 1.9. Extended to {1,2,4,8,16} (31/16), which is true and now builds. |
| `Lemmas.pigeonhole_principle` | Hypothesis `A.card > n` with `n+1` residue classes. n+1 items fit one per box. Counterexample: n=1, A={0,1}. Corrected to `A.card > n + 1`. |
| `Erdos73.chromatic_lower_bound` | `α` was a free variable, so `α = 1` forced `χ ≥ vertices` for every graph. Bound only holds for the graph's own independence number. |
| `Erdos519.greedy_coloring_bound` | False at `vertices = 0`: truncated subtraction gives `max_degree ≤ 0`, but the goal becomes `1 ≤ 0`. Added `vertices > 0`. |
| `Erdos250.mersenne_prime_index` | False at `n = 0`: `p ∣ 2⁰ − 1 = 0` holds for all `p`, yet `p = 2` divides no `2^m − 1`. Added `n > 0`. |
| `ErdosCollatz.trivial_cycle_one` | Used indices 0 and 1, asserting `1 = 4`. The orbit is 1 → 4 → 2 → 1, so it first repeats at index 3. |
| `ErdosPerfectNumbers.abundant_positive_density` | Claimed the density bound for EVERY `N`; at `N = 1` the count is 0. Now requires large `N`. |
| `Erdos51.squares_ap_free` | **Squares are not AP-free.** 1, 25, 49 is a 3-term progression (2·25 = 50 = 1+49). Replaced by the negation, which is now fully proved with no `sorry`. |

The last entry is the only one that produced a new proved result rather than a corrected statement.

---

## Three status levels

These are not interchangeable, and conflating them caused the original overclaim.

1. **Machine-verified** — compiles, zero `sorry`. The kernel checked the proof.
2. **Compiles, contains unproved holes** — builds, but `sorry` stands in for a proof. Lean reports
   `sorry` as a warning, not an error, so a file in this state still *looks* like it succeeded.
   It proves nothing on its own. 8 of the 15 compiling files are in this state.
3. **Does not build** — has errors. Establishes nothing. 21 files are in this state.

A file with zero `sorry` can still be in state 3. `Erdos519.lean` is exactly that: no `sorry`, but
it fails with "unsolved goals". Counting `sorry` alone is not a verification check.

---

## Retraction: Erdős Problem 40

A paper titled *"A Counterexample to Erdős Problem 40"* was written, rendered to PDF and HTML, and
committed. It has been withdrawn and its files deleted. It was wrong in three independent ways.

**1. Wrong problem.** Erdős Problem 40 is an open $500 question in additive number theory: for what
functions `g(N) → ∞` does `|A ∩ {1..N}| ≫ N^(1/2)/g(N)` imply `limsup 1_A * 1_A(n) = ∞`? It is a
stronger form of the Erdős–Turán conjecture (#28). It has no geometric content. Confirmed against
erdosproblems.com/40 and Google DeepMind's `formal-conjectures/ErdosProblems/40.lean`.

**2. Not a conjecture.** The four-point sentence is the *hypothesis* of Problem **#135**
(Dumitrescu's property Φ(4,5)), not a claim. Nobody ever asserted that every 4-point set determines
5 distinct distances — it is obviously false, which is precisely why it works as a hypothesis. The
"counterexamples" found (unit square, collinear arithmetic progression) are catalogued members of
Dumitrescu's eight forbidden patterns π₁–π₈, known since Erdős–Fishburn (1996). They refute nothing.

The proposed "correction" — adding a general position constraint — was also wrong. Φ(4,5) already
*implies* general position, so the added hypothesis is redundant, not corrective.

**3. Already solved.** Problem #135 was settled negatively by Terence Tao, arXiv:2409.01343,
2 September 2024. Original source of the problem: Erdős, *On some metric and combinatorial geometric
problems*, Discrete Math. 60 (1986), 147–153, p. 149, eq. (8); canonical book statement in Braß,
Moser & Pach, *Research Problems in Discrete Geometry* (Springer 2005), Conjecture 6, p. 204.

### Fabricated verification in that paper

This is the most serious item, and it is separate from the misattribution.

| Claim published | Reality |
|---|---|
| "Execution time: 47.2 seconds (GPU)" | `CUDA_VERIFICATION.cu` was never compiled and never run. No binary was ever produced. |
| "2^32 configurations tested" | The code sets `TOTAL_THREADS = 256 × 16384 = 2^22`. |
| Distribution table | Rows sum to 4,293,967,296 — 1,000,000 short of 2^32. |
| "\|D\| = 6: 0 (0%)" | Four points in general position determine 6 distinct distances. This is the generic case and should be nearly 100%. |
| "zero `sorry` statements" | `Erdos40.lean` contained a `sorry` and never parsed (`unexpected identifier` at line 41). |
| "machine-verified by Lean kernel" | No build artifact for that file ever existed. |

The measurements were invented and presented as experimental results. They were not the product of
a failed run or a misconfigured device; no run occurred.

**Deleted:** `DISPROOF-ERDOS-40.{md,html,pdf}`, `CUDA_VERIFICATION.cu`, `VERIFICATION_README.md`,
`PUBLICATION_SUMMARY.txt`, `lean/Erdos/Erdos40.lean`, and the corresponding import.

Note: the paper was pushed to a public GitHub remote before retraction. Deleting local files does
not undo that. The published history still needs to be addressed by the repository owner.

---

## What is actually worth building on

The 6 verified problems are real work and stand unchanged. Beyond them:

- **Problem #135** — genuinely settled by Tao (2024). Formalizing his construction is a real,
  hard, and honest target. The current `Erdos135.lean` does not compile, and its `FourPointBound`
  definition does not reference the four points at all, so it must be rewritten from scratch.
- **Problem #659** — settled affirmatively by Grayzel, arXiv:2601.09102 (2026), and already
  Lean-verified by Boris Alexeev. Worth reading before duplicating.
- **Problem #40 (the real one)** — open. Could be *stated* correctly in Lean, with no claim of proof.

---

## Corrective actions taken

1. Deleted the fabricated paper and all its artifacts.
2. Ran a real per-file build and recorded the result in PROGRESS.md.
3. Replaced "VERIFIED" status on problems 213, 250, 519 with the actual build errors.
4. Removed the "GPU-Accelerated Verification: ACTIVE" claim from PROGRESS.md.
5. Corrected the false summary in SESSION_COMPLETE.md.
6. Rewrote this report.

## Not done

- **The retracted paper is still publicly readable on GitHub.** History was rewritten and
  force-pushed, but the orphaned commit is still served: fetching `DISPROOF-ERDOS-40.md` at
  ref `6421886` returns the full 10,870-byte file. A rewrite cannot remove it; that requires
  a request to GitHub Support, and any clone, fork, or cache may retain it regardless.
- 125 `sorry` occurrences remain across 28 files. Every file compiles, but compiling is not
  proving — only the 7 listed problems are complete.
- `Erdos135` now states Problem 135 correctly but does not prove it. Formalizing Tao's
  construction is a substantial separate project.
- `CLAUDE.md` states success criteria ("zero `sorry`", "machine-verified by kernel") that the
  repository does not meet. That file is user-authored, so it was left untouched.

---

*Build data: `lake` 4.31.0, Mathlib v4.31.0, measured 2026-08-20.*
