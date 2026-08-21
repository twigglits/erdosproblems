/* Independent cross-check of verify458.c.
 *
 * verify458.c walks the PRIME POWERS and finds the gap around each one with a next_prime
 * search.  This program does the opposite: it sieves EVERY prime up to X, walks every
 * consecutive pair, and counts the prime powers between them with a binary search.  The two
 * programs share no logic beyond the arithmetic of the criterion itself.
 *
 * Build:  cc -O2 -o crosscheck458 crosscheck458.c -lm
 * Usage:  ./crosscheck458 <X>      (default 10^9)
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <math.h>

typedef uint64_t u64;
typedef struct { u64 val, base; } PP;

static int cmp(const void *a, const void *b) {
    u64 x = ((const PP *)a)->val, y = ((const PP *)b)->val;
    return x < y ? -1 : (x > y ? 1 : 0);
}

int main(int argc, char **argv) {
    u64 X = (argc > 1) ? strtoull(argv[1], NULL, 10) : 1000000000ULL;
    u64 root = (u64)sqrtl((long double)X) + 2;

    /* base primes up to sqrt(X) by a plain sieve */
    char *c = calloc(root + 1, 1);
    for (u64 i = 2; i * i <= root; i++)
        if (!c[i]) for (u64 j = i * i; j <= root; j += i) c[j] = 1;
    size_t bcnt = 0;
    for (u64 i = 2; i <= root; i++) if (!c[i]) bcnt++;
    u64 *bp = malloc(bcnt * sizeof(u64));
    size_t k = 0;
    for (u64 i = 2; i <= root; i++) if (!c[i]) bp[k++] = i;

    /* every prime power p^j <= X with j >= 2 */
    size_t cap = 4096, n = 0;
    PP *pp = malloc(cap * sizeof(PP));
    for (size_t i = 0; i < bcnt; i++) {
        u64 p = bp[i];
        unsigned __int128 v = (unsigned __int128)p * p;
        while (v <= (unsigned __int128)X) {
            if (n == cap) { cap *= 2; pp = realloc(pp, cap * sizeof(PP)); }
            pp[n].val = (u64)v; pp[n].base = p; n++;
            v *= p;
        }
    }
    qsort(pp, n, sizeof(PP), cmp);
    fprintf(stderr, "prime powers with exponent >= 2 below %llu: %zu\n",
            (unsigned long long)X, n);

    /* segmented sieve over [2, X]; walk consecutive primes */
    const u64 SEG = 1u << 22;
    char *seg = malloc(SEG);
    u64 prev = 0;
    long long gaps = 0, multi = 0, fails = 0;
    double worst = 0; u64 worst_p = 0, worst_prod = 0;

    for (u64 lo = 2; lo <= X; lo += SEG) {
        u64 hi = lo + SEG - 1; if (hi > X) hi = X;
        memset(seg, 0, (size_t)(hi - lo + 1));
        for (size_t i = 0; i < bcnt; i++) {
            u64 p = bp[i];
            if (p * p > hi) break;
            u64 s = (lo + p - 1) / p * p;
            if (s < p * p) s = p * p;
            for (u64 j = s; j <= hi; j += p) seg[j - lo] = 1;
        }
        for (u64 v = lo; v <= hi; v++) {
            if (seg[v - lo]) continue;
            if (prev) {
                /* prime powers strictly inside (prev, v) via binary search */
                size_t a = 0, b = n;
                while (a < b) { size_t m = (a + b) / 2; if (pp[m].val <= prev) a = m + 1; else b = m; }
                u64 prod = 1; int cnt = 0;
                for (size_t i = a; i < n && pp[i].val < v; i++) { prod *= pp[i].base; cnt++; }
                gaps++;
                if (cnt > 1) {
                    multi++;
                    printf("  gap (%llu, %llu) product=%llu count=%d\n",
                           (unsigned long long)prev, (unsigned long long)v,
                           (unsigned long long)prod, cnt);
                }
                if (prod >= prev) {
                    fails++;
                    printf("COUNTEREXAMPLE at p_k=%llu product=%llu\n",
                           (unsigned long long)prev, (unsigned long long)prod);
                }
                if (prod > 1 && (double)prod / prev > worst) {
                    worst = (double)prod / prev; worst_p = prev; worst_prod = prod;
                }
            }
            prev = v;
        }
    }
    printf("X=%llu  gaps checked=%lld  gaps with 2+ powers=%lld  counterexamples=%lld\n",
           (unsigned long long)X, gaps, multi, fails);
    printf("worst ratio=%.6f at p_k=%llu product=%llu\n", worst,
           (unsigned long long)worst_p, (unsigned long long)worst_prod);
    return fails ? 1 : 0;
}
