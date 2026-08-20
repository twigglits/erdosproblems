# Erdős Problem #634 — status, solution of the resolved core, and a machine-checked proof

## The problem

> **Find all `n` such that there is at least one triangle which can be cut into `n`
> congruent triangles.**

Let `𝒯 = { n ≥ 1 : some triangle ABC can be dissected into n triangles all congruent to a
single tile T }`.

## Honest status: the full problem is OPEN

`𝒯` is **not** known. The smallest undecided value is **`n = 19`**: it is not known whether
any triangle can be cut into 19 congruent triangles. So #634 cannot be "closed" here, and
this document does not claim to. What *is* settled is a clean arithmetic skeleton, and
**that skeleton is what we prove and machine-verify** (see [`erdos634/Erdos634.lean`](erdos634/Erdos634.lean)).

**Status confirmed June 2026 (literature check).** `n = 19` is still open:
the newest relevant work, Yan X. Zhang, *Tiling Triangles with `2π/3` Angles*
([arXiv:2512.22696](https://arxiv.org/abs/2512.22696), Dec 2025), constructs `2π/3`-tile
families for six *sporadic* triangles and only *conjectures* the achievable `N` — it does
not settle `19`. The sibling problem **#633** *was* resolved — Beeson, Laczkovich & Zhang,
*Solution of Erdős Problem 633* ([arXiv:2604.03609](https://arxiv.org/abs/2604.03609), Apr
2026) — but #634 is not. Since a machine-checked proof of `19 ∈ 𝒯` would require knowing the
answer, the verifiability requirement *itself* makes an honest "closing" of #634 impossible
today; we instead verify everything that is genuinely settled.

What is known (Soifer; Snover–Waiveris–Williams; Laczkovich; Beeson; Zhang — see
`../633/NoSevenTiling.pdf`):

| fact | who |
|---|---|
| every square `n²` works (any triangle; subdivide each side into `n`) | classical |
| `a² + b²`, `2n²`, `3n²`, `6n²` work | Soifer |
| `𝒯` is closed under multiplication by squares (subdivide each tile into `m²`) | classical |
| **`7 ∉ 𝒯` and `11 ∉ 𝒯`** (proved) | Beeson 2018 |
| conjecture: no prime `≡ 3 (mod 4)` is in `𝒯` | Beeson |
| **`19` is open** | — |
| `n²ab ∈ 𝒯` for `n ≥ 3⌈(a²+b²+ab−a−b)/(ab)⌉` (tile has a `120°` angle) | Zhang |

## The resolved core (what we prove)

All the *constructions* above use a tile whose three angles are **commensurable** (rational
multiples of `2π`). Beeson's **Theorem 7** says that for such a tile the count `N` must be

> **a square, a sum of two squares, or `2`, `3`, or `6` times a square.**

Call a number with this shape a **Beeson form**. The entire question then turns on a single
piece of classical number theory.

**Theorem A (collapse).** The five families reduce to three:
`BeesonForm n ↔ (n is a sum of two squares) ∨ n = 3·□ ∨ n = 6·□`,
because every square is `k² + 0²` and every `2k²` is `k² + k²`.

**Theorem B (closure).** Beeson forms are closed under `× k²` — the arithmetic shadow of
"subdivide every tile into `k²` copies."

**Theorem C (the dividing line — Fermat).** For a *prime* `p`,
```
   p is a Beeson form  ⇔  p = 2 ∨ p = 3 ∨ p ≡ 1 (mod 4).
```
The "⇐" for `p ≡ 1` is **Fermat's two-square theorem**; the "⇒" is the elementary fact that
a sum of two squares is never `≡ 3 (mod 4)`.

**Corollary D (the obstruction).** The primes excluded by *every* classical construction are
exactly the primes `≡ 3 (mod 4)` other than `3`:
```
   7, 11, 19, 23, 31, 43, 47, …
```
This is **why** `7`, `11`, `19` are the hard cases. Beeson *proved* `7, 11 ∉ 𝒯`; for `19` and
the rest the conjecture `∉ 𝒯` remains open.

**Theorem E (general/composite obstruction — Beeson's Remark).** If `3 ∤ n` and some prime
`q ≡ 3 (mod 4)` divides `n` to an odd power, then `n` is not a Beeson form. (Uses the
prime-factorization characterization, Beeson's Lemma 2 = Mathlib's `Nat.eq_sq_add_sq_iff`.)

### Small values (`BeesonForm` vs. truth)

```
n :  1  2  3  4  5  6  7  8  9 10 11 12 13 …  19 …
𝒯 :  ✓  ✓  ✓  ✓  ✓  ✓  ✗  ✓  ✓  ✓  ✗  ✓  ✓     ?
BF:  ✓  ✓  ✓  ✓  ✓  ✓  ✗  ✓  ✓  ✓  ✗  ✓  ✓     ✗
```
`BeesonForm` and `𝒯` agree on every value shown. They are **not** equal in general:
`BeesonForm ⊊ 𝒯`, because Zhang's `120°` tilings reach counts outside `BeesonForm`
(e.g. `7·n²` for large `n`). That gap — non-commensurable `γ = 2π/3` tiles — is precisely
where `n = 19` still hides, and why the `7`/`11` impossibility proof does not settle it.

## The machine-checked artifact

[`erdos634/Erdos634.lean`](erdos634/Erdos634.lean) is a Lean 4 + Mathlib development that
proves all of the above with **no `sorry` and no extra axioms**:

| Lean name | statement |
|---|---|
| `beesonForm_iff` | Theorem A (collapse to three families) |
| `beesonForm_mul_sq` | Theorem B (closed under `× k²`) |
| `beesonForm_of_prime` | Theorem C, "⇐" (incl. Fermat via `Nat.Prime.sq_add_sq`) |
| `prime_beesonForm_iff` | Theorem C (the iff) |
| `not_beesonForm_of_prime_mod_four` | Corollary D |
| `not_beesonForm_seven / _eleven / _nineteen` | `7, 11, 19 ∉ BeesonForm` |
| `not_beesonForm_of_oddPow` | Theorem E (Beeson's Remark) |
| `ClassicalTiling` (inductive) + `classicalTiling_iff_beesonForm` | the classical constructions realize **exactly** the Beeson forms (for `n ≥ 1`) |
| `not_classicalTiling_seven / _eleven / _nineteen` | no classical construction tiles `7`, `11`, `19` |
| `sum2SqB_iff`, `mulSqB_iff`, `DecidablePred BeesonForm` | a **decision procedure**: `BeesonForm n` is computable, so `decide` settles any concrete `n` |
| (machine-checked example) | the `n ≤ 30` outside every classical construction are **exactly** `{7,11,14,15,19,21,22,23,28,30}` — proved by `decide` |
| `SnoverForm`, `prime_snoverForm_iff`, `snoverForm_le_beesonForm` | the **fully resolved** Snover–Waiveris–Williams classification (tiles *similar* to `ABC`: exactly `n² ∪ n²+m² ∪ 3n²`), sharing the same Fermat dividing line, and strictly inside the congruent case |

**Scope (honest).** The Lean file formalizes the *arithmetic* of the problem, not Euclidean
dissection from scratch (a much larger project). The existence of each geometric
construction is the content of Beeson's figures and is encoded as the meaning of the
`ClassicalTiling` constructors. The file does **not** resolve `19 ∈ 𝒯?` — it proves
`19 ∉ BeesonForm`, i.e. no *classical* construction reaches it, which is exactly the known
state of the art.

### Build & verify

```bash
cd erdos634
lake exe cache get      # prebuilt Mathlib oleans (already present here)
lake build Erdos634     # ⇒ "Build completed successfully (2971 jobs)."
```

Axiom audit (`#print axioms`): every headline theorem reduces to only
`[propext, Classical.choice, Quot.sound]` — Lean/Mathlib's standard base — with
`beesonForm_iff` and `classicalTiling_iff_beesonForm` needing only `[propext]`.

## References

- Michael Beeson, *No triangle can be cut into seven congruent triangles*
  ([arXiv:1811.09723](https://arxiv.org/abs/1811.09723); local `../633/NoSevenTiling.pdf`) —
  esp. **Theorem 7**, **Corollary 1**, **Lemma 2**, and **Table 6** (status of `N ≤ 100`).
- S. Snover, C. Waiveris, J. Williams, *Rep-tiling for triangles*, Discrete Math. 91 (1991) —
  the similar-tile classification (`n²`, `n²+m²`, `3n²`).
- M. Beeson, M. Laczkovich, Y. X. Zhang, *Solution of Erdős Problem 633*
  ([arXiv:2604.03609](https://arxiv.org/abs/2604.03609), 2026).
- Yan X. Zhang, *Tiling Triangles with `2π/3` Angles*
  ([arXiv:2512.22696](https://arxiv.org/abs/2512.22696), 2025) — newest work on the
  non-commensurable escape route; does **not** settle `n = 19`.
- Fermat's two-square theorem: `Mathlib.NumberTheory.SumTwoSquares`
  (`Nat.Prime.sq_add_sq`, `Nat.eq_sq_add_sq_iff`).

## Verifying the axiom base

```
#print axioms prime_beesonForm_iff   -- [propext, Classical.choice, Quot.sound]
#print axioms classicalTiling_iff_beesonForm  -- [propext]
#print axioms sum2SqB_iff             -- [propext, Quot.sound]
```
No `sorry`, no `sorryAx`, no `native_decide`, no custom axioms — kernel-checked throughout.
