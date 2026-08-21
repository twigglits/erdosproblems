/* Verification of Erdos Problem 458.
 *
 *   Is it true that  lcm(1..p_{k+1}-1)  <  p_k * lcm(1..p_k)  for all k >= 1 ?
 *
 * Reduction (proved in lean/Erdos/Erdos458.lean, zero `sorry`):
 *   there is no prime in the open interval (p_k, p_{k+1}), so the two lcms use the
 *   same set of primes and differ only in exponents.  The exponent of p in lcm(1..n)
 *   is the largest j with p^j <= n.  Therefore
 *
 *     lcm(1..p_{k+1}-1) / lcm(1..p_k)  =  prod { p : p^j in (p_k, p_{k+1}), j >= 2 }
 *
 *   where each prime p is counted once for each such j.  Bertrand's postulate makes
 *   two powers of one prime in one gap impossible, so every base occurs at most once.
 *   The conjecture at index k is therefore equivalent to
 *
 *     prod of those bases  <  p_k .
 *
 * This program walks every prime power p^j <= X with j >= 2, groups the powers that
 * fall in a common prime gap, and tests that inequality on each group.
 *
 * Build:  cc -O2 -o verify458 verify458.c
 * Usage:  ./verify458 <X>        (default X = 10^12)
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <math.h>

typedef unsigned __int128 u128;
typedef uint64_t u64;

/* ---------- deterministic Miller-Rabin for n < 3.3 * 10^24 ---------- */

static u64 mulmod(u64 a, u64 b, u64 m) { return (u64)((u128)a * b % m); }

static u64 powmod(u64 a, u64 e, u64 m) {
    u64 r = 1; a %= m;
    while (e) { if (e & 1) r = mulmod(r, a, m); a = mulmod(a, a, m); e >>= 1; }
    return r;
}

static const u64 MR_BASES[7] = {2, 325, 9375, 28178, 450775, 9780504, 1795265022};

static int mr_witness(u64 n, u64 d, int s, u64 a) {
    a %= n;
    if (a == 0) return 0;                      /* base is a multiple of n: no witness */
    u64 x = powmod(a, d, n);
    if (x == 1 || x == n - 1) return 0;
    for (int i = 1; i < s; i++) {
        x = mulmod(x, x, n);
        if (x == n - 1) return 0;
    }
    return 1;
}

/* primes below 100, used both as a trial-division filter and as MR small cases */
static const int SMALLP[25] = {2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,
                               61,67,71,73,79,83,89,97};

static int is_prime(u64 n) {
    if (n < 2) return 0;
    for (int i = 0; i < 25; i++) {
        u64 p = (u64)SMALLP[i];
        if (n == p) return 1;
        if (n % p == 0) return 0;
    }
    if (n < 101ULL * 101ULL) return 1;         /* no factor below 100 and n < 100^2 */
    u64 d = n - 1; int s = 0;
    while ((d & 1) == 0) { d >>= 1; s++; }
    for (int i = 0; i < 7; i++)
        if (mr_witness(n, d, s, MR_BASES[i])) return 0;
    return 1;
}

/* wheel over the residues coprime to 2*3*5*7 = 210 */
static int WHEEL[48], WHEEL_N = 0;
static int WHEEL_NEXT[210];                    /* r -> index of first wheel residue >= r */

static void wheel_init(void) {
    for (int r = 0; r < 210; r++)
        if (r % 2 && r % 3 && r % 5 && r % 7) WHEEL[WHEEL_N++] = r;
    for (int r = 209, k = WHEEL_N; r >= 0; r--) {
        if (k > 0 && WHEEL[k - 1] >= r) { while (k > 0 && WHEEL[k - 1] >= r) k--; }
        WHEEL_NEXT[r] = k;                     /* k = count of wheel residues < r */
    }
}

static u64 next_prime(u64 n) {                 /* smallest prime strictly greater than n */
    if (n < 2) return 2;
    for (int i = 0; i < 25; i++)
        if ((u64)SMALLP[i] > n) return (u64)SMALLP[i];
    u64 base = (n / 210) * 210;
    int k = WHEEL_NEXT[(int)(n % 210) + 1];
    for (;;) {
        if (k == WHEEL_N) { k = 0; base += 210; }
        u64 c = base + (u64)WHEEL[k];
        if (c > n && is_prime(c)) return c;
        k++;
    }
}

static u64 prev_prime(u64 n) {                 /* largest prime strictly less than n */
    for (u64 c = n - 1; c >= 2; c--) if (is_prime(c)) return c;
    return 0;
}

/* ---------- prime powers with exponent >= 2 ---------- */

typedef struct { u64 val; u64 base; } PP;

static int pp_cmp(const void *a, const void *b) {
    u64 x = ((const PP *)a)->val, y = ((const PP *)b)->val;
    return x < y ? -1 : (x > y ? 1 : 0);
}

static u64 isqrt64(u64 n) {
    u64 r = (u64)sqrtl((long double)n);
    while (r > 0 && r > n / r) r--;
    while ((r + 1) <= n / (r + 1)) r++;
    return r;
}

/* simple sieve of Eratosthenes returning primes <= n */
static u64 *simple_primes(u64 n, size_t *out_count) {
    char *c = calloc(n + 1, 1);
    if (!c) { fprintf(stderr, "out of memory in simple_primes(%llu)\n",
                      (unsigned long long)n); exit(1); }
    for (u64 i = 2; i * i <= n; i++)
        if (!c[i]) for (u64 j = i * i; j <= n; j += i) c[j] = 1;
    size_t cnt = 0;
    for (u64 i = 2; i <= n; i++) if (!c[i]) cnt++;
    u64 *p = malloc(cnt * sizeof(u64));
    size_t k = 0;
    for (u64 i = 2; i <= n; i++) if (!c[i]) p[k++] = i;
    free(c);
    *out_count = cnt;
    return p;
}

/* ---------- group bookkeeping ---------- */

static u64 X;
static long long groups_multi = 0, groups_total = 0, failures = 0;
static double worst_ratio = 0; static u64 worst_pk = 0, worst_prod = 0;

static void flush_group(PP *g, int n) {
    if (n == 0) return;
    groups_total++;
    /* product of the bases; every base occurs once per power, powers of one prime
       cannot share a gap (Bertrand), so this is exactly the lcm ratio */
    u128 prod = 1;
    for (int i = 0; i < n; i++) {
        prod *= g[i].base;
        if (prod > (u128)X) break;             /* already far above any p_k <= X */
    }
    if (n == 1) {
        /* A lone power p^j in the gap contributes the single base p <= sqrt(p^j).
           Bertrand's postulate puts a prime in (v/2, v), so p_k > v/2, and
           sqrt(v) < v/2 whenever v > 4.  The one remaining value is v = 4,
           whose base 2 is below p_k = 3.  No primality search is needed. */
        u64 v = g[0].val;
        if (v > 4 || (v == 4 && g[0].base == 2)) return;
        fprintf(stderr, "unexpected singleton value %llu\n", (unsigned long long)v);
        exit(2);
    }
    u64 pk = prev_prime(g[0].val);
    groups_multi++;
    double ratio = (double)(long double)prod / (double)pk;
    if (ratio > worst_ratio) { worst_ratio = ratio; worst_pk = pk; worst_prod = (u64)prod; }
    if (prod >= (u128)pk) {
        failures++;
        printf("COUNTEREXAMPLE p_k=%llu  product=%llu  powers:",
               (unsigned long long)pk, (unsigned long long)prod);
        for (int i = 0; i < n; i++)
            printf(" %llu(base %llu)", (unsigned long long)g[i].val,
                   (unsigned long long)g[i].base);
        printf("\n");
    } else {
        printf("  multi-power gap p_k=%llu product=%llu ratio=%.4f  powers:",
               (unsigned long long)pk, (unsigned long long)prod, ratio);
        for (int i = 0; i < n; i++)
            printf(" %llu(base %llu)", (unsigned long long)g[i].val,
                   (unsigned long long)g[i].base);
        printf("\n");
    }
}

int main(int argc, char **argv) {
    X = (argc > 1) ? strtoull(argv[1], NULL, 10) : 1000000000000ULL;
    wheel_init();

    u64 sq_lim = isqrt64(X);                   /* squares  p^2 <= X  need p <= sqrt(X) */
    u64 hi_lim = (u64)(cbrtl((long double)X)) + 2;

    /* higher powers p^j, j >= 3, collected and sorted */
    size_t hp_count;
    u64 *hp = simple_primes(hi_lim, &hp_count);
    size_t cap = 4096, hn = 0;
    PP *high = malloc(cap * sizeof(PP));
    for (size_t i = 0; i < hp_count; i++) {
        u64 p = hp[i];
        u128 v = (u128)p * p;
        for (;;) {
            v *= p;
            if (v > (u128)X) break;
            if (hn == cap) { cap *= 2; high = realloc(high, cap * sizeof(PP)); }
            high[hn].val = (u64)v; high[hn].base = p; hn++;
        }
    }
    free(hp);
    qsort(high, hn, sizeof(PP), pp_cmp);
    fprintf(stderr, "X = %llu ; prime powers with exponent >= 3: %zu\n",
            (unsigned long long)X, hn);

    /* base primes for the segmented sieve that streams the primes p <= sqrt(X) */
    size_t bp_count;
    u64 *bp = simple_primes(isqrt64(sq_lim) + 1, &bp_count);
    fprintf(stderr, "sqrt(X) = %llu ; base primes: %zu\n",
            (unsigned long long)sq_lim, bp_count);

    const u64 SEG = 1u << 22;
    char *seg = malloc(SEG);

    PP group[128]; int gn = 0; u64 group_next_prime = 0;
    size_t hi_i = 0;
    long long squares = 0;

    for (u64 lo = 2; lo <= sq_lim; lo += SEG) {
        u64 hi = lo + SEG - 1; if (hi > sq_lim) hi = sq_lim;
        memset(seg, 0, (size_t)(hi - lo + 1));
        for (size_t i = 0; i < bp_count; i++) {
            u64 p = bp[i];
            if (p * p > hi) break;
            u64 s = (lo + p - 1) / p * p;
            if (s < p * p) s = p * p;
            for (u64 j = s; j <= hi; j += p) seg[j - lo] = 1;
        }
        for (u64 v = lo; v <= hi; v++) {
            if (seg[v - lo]) continue;
            u64 sq = v * v;                    /* the next prime square */
            squares++;
            /* emit every stored higher power that comes before this square */
            for (;;) {
                PP cur;
                if (hi_i < hn && high[hi_i].val < sq) { cur = high[hi_i++]; }
                else if (hi_i < hn && high[hi_i].val == sq) { hi_i++; continue; }
                else break;
                if (gn > 0 && cur.val < group_next_prime) {
                    if (gn < 128) group[gn++] = cur;
                } else {
                    flush_group(group, gn);
                    gn = 0; group[gn++] = cur;
                    group_next_prime = next_prime(cur.val);
                }
            }
            PP cur; cur.val = sq; cur.base = v;
            if (gn > 0 && cur.val < group_next_prime) {
                if (gn < 128) group[gn++] = cur;
            } else {
                flush_group(group, gn);
                gn = 0; group[gn++] = cur;
                group_next_prime = next_prime(cur.val);
            }
        }
    }
    while (hi_i < hn) {                        /* higher powers past the last square */
        PP cur = high[hi_i++];
        if (gn > 0 && cur.val < group_next_prime) { if (gn < 128) group[gn++] = cur; }
        else { flush_group(group, gn); gn = 0; group[gn++] = cur;
               group_next_prime = next_prime(cur.val); }
    }
    flush_group(group, gn);

    fprintf(stderr, "prime squares scanned: %lld\n", squares);
    printf("X                      = %llu\n", (unsigned long long)X);
    printf("prime gaps with a power= %lld\n", groups_total);
    printf("gaps with 2+ powers    = %lld\n", groups_multi);
    printf("counterexamples        = %lld\n", failures);
    printf("worst ratio prod/p_k   = %.6f  (p_k = %llu, product = %llu)\n",
           worst_ratio, (unsigned long long)worst_pk, (unsigned long long)worst_prod);
    return failures ? 1 : 0;
}
