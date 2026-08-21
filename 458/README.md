# Erdős Problem 458

> Let `[1,...,n]` denote the least common multiple of `{1,...,n}`.  Is it true that, for all
> `k ≥ 1`,
>
>     [1,...,p_{k+1} - 1]  <  p_k · [1,...,p_k]  ?

Source: [erdosproblems.com/458](https://www.erdosproblems.com/458).  Status in the community
database: **open**, tagged **falsifiable** — a finite counterexample would settle it.

Erdős and Graham call it 'almost certainly' true and name two obstructions: ruling out many
primes `r` with `p_k < r² < p_{k+1}` (close to Legendre's conjecture), and "the small primes
also cause trouble".

**The problem is not solved here.**  What follows is an exact reduction, machine-checked, plus
a search.

---

## 1. The reduction

No prime lies strictly between `p_k` and `p_{k+1}`.  So `[1,...,p_{k+1}-1]` and `[1,...,p_k]`
are built from the *same* primes and differ only in exponents.  The exponent of `r` in
`[1,...,n]` is the largest `j` with `r^j ≤ n`.  Writing `p = p_k` and `q = p_{k+1}`:

```
[1,...,q-1]  =  gapFactor(p,q) · [1,...,p]        where
gapFactor(p,q) = ∏ over primes r ≤ p of  r ^ ( log_r(q-1) − log_r(p) )
```

Bertrand's postulate rules out two powers of one prime in one gap, so every exponent in that
product is `0` or `1`.  Therefore

```
gapFactor(p,q) = product of the DISTINCT primes r that have some power r^j (j ≥ 2)
                 lying strictly inside the gap (p, q)
```

Call those primes the **contributors**.  Since `[1,...,p] > 0`:

> **Erdős 458 at index k  ⟺  (product of the contributors)  <  p_k.**

## 2. What the Lean file proves

`../lean/Erdos/Erdos458.lean` — 25 theorems, **zero `sorry`**, **zero `native_decide`**, zero
warnings.  Every one of them is audited in `../lean/Erdos/Audit.lean` and rests on
`[propext, Classical.choice, Quot.sound]` only.

| Theorem | Statement |
|---|---|
| `gapFactor_mul` | `gapFactor p q * lcmUpto p = lcmUpto (q-1)` |
| `erdos458_iff` | the problem at `k` ⟺ `gapFactor p q < p` |
| `log_sub_log_le_one` | every exponent in the product is `0` or `1` |
| `gapFactor_eq_prod` | `gapFactor` is the product of the distinct contributors |
| `contributor_lt` | every contributor is `< p` |
| `erdos458_of_card_le_one` | **holds** whenever the gap has at most one contributor |
| `erdos458_of_card_le_two` | **holds** with two contributors, unless both put a square in the gap (needs `32 ≤ p`) |
| `fails_of_two_prime_squares` | **fails** if the gap holds the squares of two distinct primes |
| `erdos458_iff_no_two_prime_squares` | the two above combined: an exact answer for any gap with at most two prime powers |
| `sq_gap_gt_of_two_squares` | two prime squares in one gap force `4p < (q-p)²`, a gap longer than `2√p` |
| `erdos458_of_gap_bound` | so a Legendre-strength gap bound `p_{k+1} - p_k ≤ 2√(p_k)` implies the problem, for gaps with at most two prime powers |
| `erdos458_iff_gapFactor` | the equivalence phrased for `Nat.nth Nat.Prime` |
| `erdos458_at_exceptional_gaps` | the inequality at each of the five exceptional gaps |

The last line of the argument for two contributors is worth stating plainly.  If contributor
`r` keeps `r² ≤ p` then its *cube* is in the gap, so `r³ < q ≤ 2p`.  If `s` puts a square in
the gap then `s² < q ≤ 2p`.  Then

```
(r·s)^6 = (r³)² · (s²)³ < (2p)² · (2p)³ = 32 p^5 ≤ p^6      for p ≥ 32,
```

so `r·s < p`.  Two squares, by contrast, give `r² > p` and `s² > p`, hence `(rs)² > p²` and
`rs > p` — the inequality fails.  **Two prime squares in one gap is the only way to break the
problem when the gap holds at most two prime powers.**

## 3. The search

`verify458.c` walks every prime power `r^j ≤ X` with `j ≥ 2`, groups those that fall in a
common prime gap, and tests `product of bases < p_k` on each group.

A lone prime power needs no test: its base is at most `√(r^j)`, and Bertrand puts a prime above
`(r^j)/2`, so the base is below `p_k` whenever `r^j > 4`.  Only groups of size two or more are
tested, and each such group is printed.

Two limits of the program, stated plainly:

* A group is capped at 128 members.  No group anywhere in the range exceeded 2, so the cap never
  bound; but it is a silent truncation if a future run ever hits it.
* Enumerating every prime power `≤ X` covers every prime gap that lies **entirely** below `X`.
  The single gap straddling `X` may hold a power above `X` that was not enumerated.

```
cc -O2 -o verify458 verify458.c -lm
./verify458 10000000000000000000        # X = 10^19
```

### Result

RESULTS_PLACEHOLDER

### The exceptional gaps

Exactly five prime gaps below `10^19` hold more than one prime power:

| `p_k` | `p_{k+1}` | prime powers inside | product | product / `p_k` |
|---|---|---|---|---|
| 7     | 11    | `8 = 2³`, `9 = 3²`              | 6   | 0.857 |
| 23    | 29    | `25 = 5²`, `27 = 3³`            | 15  | 0.652 |
| 113   | 127   | `121 = 11²`, `125 = 5³`         | 55  | 0.487 |
| 2179  | 2203  | `2187 = 3⁷`, `2197 = 13³`       | 39  | 0.018 |
| 32749 | 32771 | `32761 = 181²`, `32768 = 2¹⁵`   | 362 | 0.011 |

None of the five holds two prime *squares*, which is exactly why the inequality survives.  All
five `gapFactor` values are checked by the Lean kernel — see `gapFactor_7_11` through
`gapFactor_32749_32771`.  The kernel cannot evaluate `contributors 2179 2203` directly, so
`contributors_eq_filter` first bounds the contributor set by `√q`, which cuts the search from
2179 candidates to 46.

The tightest case in the entire range is the smallest one, `k = 3`: the ratio is `6` against
`p_k = 7`.

### The OEIS reading of the criterion

The reduction lines the problem up exactly with four existing OEIS sequences.

| Sequence | What it is | Role here |
|---|---|---|
| [A025475](https://oeis.org/A025475) | `1` and the prime powers `p^m`, `m ≥ 2` (primes excluded) | the terms whose presence in a gap makes `gapFactor > 1` |
| [A053607](https://oeis.org/A053607) | primes `p` with a pure prime power between `p` and the next prime | exactly the `k` where `gapFactor(p_k, p_{k+1}) > 1` |
| [A053706](https://oeis.org/A053706) | primes `p` with **two** prime powers in that gap | the only indices `erdos458_of_card_le_one` does not already settle |
| [A056604](https://oeis.org/A056604) | `lcm(1, ..., p_n)` | the right-hand side of the inequality |

So the criterion reads:

> Erdős 458 holds at every `k` outside A053706.  On A053706 it holds unless the two prime
> powers are the squares of two primes.

A053706 has five known terms — `7, 23, 113, 2179, 32749` — and its OEIS entry records "no other
terms < 2^63" (Donovan Johnson, 2013).  The run reported above reaches `10^19 > 2^63` and finds
the same five, so it reproduces that computation independently and extends it a little.

**A concrete contribution to make:** the community database
[teorth/erdosproblems](https://github.com/teorth/erdosproblems) currently links problem 458 to
A056604 only.  A053607, A053706 and A025475 all belong there, and the reduction above is the
reason why.  That project asks for exactly this kind of link.

### Cross-checks

* `crosscheck458.c` uses the **opposite** algorithm: it sieves every prime up to `X`, walks
  every consecutive pair, and counts the prime powers between them by binary search.
  `verify458.c` instead walks the prime powers and finds each one's gap by a `next_prime`
  search.  The two share no logic beyond the arithmetic of the criterion.

  ```
  $ ./crosscheck458 100000000000
  prime powers with exponent >= 2 below 100000000000: 28156
    gap (7, 11) product=6 count=2
    gap (23, 29) product=15 count=2
    gap (113, 127) product=55 count=2
    gap (2179, 2203) product=39 count=2
    gap (32749, 32771) product=362 count=2
  X=100000000000  gaps checked=4118054812  gaps with 2+ powers=5  counterexamples=0
  worst ratio=0.857143 at p_k=7 product=6
  ```

  It walked 4,118,054,812 gaps, and `4118054812 + 1 = π(10^11)` exactly — an independent check
  that the sieve missed no prime.  Same five gaps, same products, same worst ratio.
* A third implementation, in Python with `sympy`, walks every prime gap below `10^7` from the
  definition and reproduces the same five groups and the same products.
* For every prime gap below `3000`, `[1,...,q-1] / [1,...,p]` was computed directly from the
  lcm and matched against `gapFactor` term by term.

## 4. What is still open

Two gaps remain between the Lean result and a proof:

1. **No prime gap holds two prime squares.**  Two prime squares `r² < s²` in one gap force a
   gap of length at least `4√(p_k)`.  The best unconditional bound on prime gaps is
   `O(x^0.525)` (Baker–Harman–Pintz), and `x^0.525` exceeds `4√x`, so it does not suffice.
   `p_{k+1} − p_k < 2√(p_k)` would do it; that is essentially Legendre's conjecture.
2. **Gaps with three or more prime powers.**  `erdos458_of_card_le_two` says nothing there.
   Three cubes `r³, s³, t³` in one gap would give `r·s·t ≈ p_k`, which is genuinely borderline.
   No such gap exists below `10^19`, but the case is not ruled out.

So Erdős 458 is now: *prove that no prime gap holds two prime squares, and bound the product
for gaps with three or more prime powers.* The first half is the Erdős–Graham remark, now with
a machine-checked derivation.

## 5. Honest accounting

| Claim | Kind of evidence |
|---|---|
| The reduction, and the two settled cases | Lean 4 proof, kernel-checked, standard axioms only |
| The five exceptional gaps and their `gapFactor` values | Lean 4 proof, kernel-checked |
| "No counterexample below `10^19`" | C program, cross-checked against Python below `10^7` — **not a proof** |
| Erdős 458 itself | **open** |
