// CUDA helper for machine-verified Erdős problem computations
// Uses CUDA for high-throughput factorization and congruence verification

#include <stdio.h>
#include <cuda_runtime.h>
#include <stdint.h>

#define BLOCK_SIZE 256
#define MAX_PRIMES 10000

// Device memory for precomputed primes
__device__ uint32_t d_primes[MAX_PRIMES];
__device__ int d_prime_count = 0;

// Kernel to compute Legendre's formula: v_p(n!) = sum_{i=1}^∞ floor(n/p^i)
__global__ void compute_legendre_kernel(uint32_t n, uint32_t p, uint32_t *result) {
    uint32_t val = 0;
    uint32_t power = p;
    while (power <= n) {
        val += n / power;
        if (power > UINT32_MAX / p) break; // Prevent overflow
        power *= p;
    }
    *result = val;
}

// Kernel to check if a number is prime using trial division
__global__ void is_prime_kernel(uint32_t n, int *result) {
    if (n < 2) {
        *result = 0;
        return;
    }
    if (n == 2) {
        *result = 1;
        return;
    }
    if (n % 2 == 0) {
        *result = 0;
        return;
    }

    uint32_t limit = (uint32_t)sqrtf((float)n) + 1;
    for (uint32_t i = 3; i <= limit; i += 2) {
        if (n % i == 0) {
            *result = 0;
            return;
        }
    }
    *result = 1;
}

// Kernel to compute gcd(a, b)
__global__ void gcd_kernel(uint64_t a, uint64_t b, uint64_t *result) {
    while (b != 0) {
        uint64_t temp = b;
        b = a % b;
        a = temp;
    }
    *result = a;
}

// Kernel to verify divisibility: check if a % b == 0
__global__ void divisibility_kernel(uint64_t a, uint64_t b, int *result) {
    *result = (a % b == 0) ? 1 : 0;
}

// Kernel for modular exponentiation: (base^exp) % mod
__global__ void modexp_kernel(uint64_t base, uint64_t exp, uint64_t mod, uint64_t *result) {
    uint64_t res = 1;
    base = base % mod;
    while (exp > 0) {
        if (exp % 2 == 1) {
            res = (__uint128_t)res * base % mod;
        }
        exp = exp >> 1;
        base = (__uint128_t)base * base % mod;
    }
    *result = res;
}

// Host wrapper for computing Legendre's formula
uint32_t compute_legendre(uint32_t n, uint32_t p) {
    uint32_t *d_result;
    cudaMalloc(&d_result, sizeof(uint32_t));
    compute_legendre_kernel<<<1, 1>>>(n, p, d_result);
    cudaDeviceSynchronize();
    uint32_t result;
    cudaMemcpy(&result, d_result, sizeof(uint32_t), cudaMemcpyDeviceToHost);
    cudaFree(d_result);
    return result;
}

// Host wrapper for primality test
int is_prime(uint32_t n) {
    int *d_result;
    cudaMalloc(&d_result, sizeof(int));
    is_prime_kernel<<<1, 1>>>(n, d_result);
    cudaDeviceSynchronize();
    int result;
    cudaMemcpy(&result, d_result, sizeof(int), cudaMemcpyDeviceToHost);
    cudaFree(d_result);
    return result;
}

// Host wrapper for GCD
uint64_t gcd(uint64_t a, uint64_t b) {
    uint64_t *d_result;
    cudaMalloc(&d_result, sizeof(uint64_t));
    gcd_kernel<<<1, 1>>>(a, b, d_result);
    cudaDeviceSynchronize();
    uint64_t result;
    cudaMemcpy(&result, d_result, sizeof(uint64_t), cudaMemcpyDeviceToHost);
    cudaFree(d_result);
    return result;
}

// Host wrapper for divisibility check
int check_divisible(uint64_t a, uint64_t b) {
    int *d_result;
    cudaMalloc(&d_result, sizeof(int));
    divisibility_kernel<<<1, 1>>>(a, b, d_result);
    cudaDeviceSynchronize();
    int result;
    cudaMemcpy(&result, d_result, sizeof(int), cudaMemcpyDeviceToHost);
    cudaFree(d_result);
    return result;
}

// Host wrapper for modular exponentiation
uint64_t modexp(uint64_t base, uint64_t exp, uint64_t mod) {
    uint64_t *d_result;
    cudaMalloc(&d_result, sizeof(uint64_t));
    modexp_kernel<<<1, 1>>>(base, exp, mod, d_result);
    cudaDeviceSynchronize();
    uint64_t result;
    cudaMemcpy(&result, d_result, sizeof(uint64_t), cudaMemcpyDeviceToHost);
    cudaFree(d_result);
    return result;
}

// Main verification routines
int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: cuda_verify <command> [args]\n");
        printf("Commands:\n");
        printf("  legendre <n> <p>  - Compute v_p(n!)\n");
        printf("  isprime <n>        - Check if n is prime\n");
        printf("  gcd <a> <b>        - Compute gcd(a, b)\n");
        printf("  divisible <a> <b>  - Check if a is divisible by b\n");
        printf("  modexp <base> <exp> <mod> - Compute (base^exp) % mod\n");
        return 1;
    }

    char *cmd = argv[1];

    if (strcmp(cmd, "legendre") == 0 && argc >= 4) {
        uint32_t n = atoi(argv[2]);
        uint32_t p = atoi(argv[3]);
        uint32_t result = compute_legendre(n, p);
        printf("%u\n", result);
    } else if (strcmp(cmd, "isprime") == 0 && argc >= 3) {
        uint32_t n = atoi(argv[2]);
        int result = is_prime(n);
        printf("%d\n", result);
    } else if (strcmp(cmd, "gcd") == 0 && argc >= 4) {
        uint64_t a = strtoull(argv[2], NULL, 10);
        uint64_t b = strtoull(argv[3], NULL, 10);
        uint64_t result = gcd(a, b);
        printf("%llu\n", result);
    } else if (strcmp(cmd, "divisible") == 0 && argc >= 4) {
        uint64_t a = strtoull(argv[2], NULL, 10);
        uint64_t b = strtoull(argv[3], NULL, 10);
        int result = check_divisible(a, b);
        printf("%d\n", result);
    } else if (strcmp(cmd, "modexp") == 0 && argc >= 5) {
        uint64_t base = strtoull(argv[2], NULL, 10);
        uint64_t exp = strtoull(argv[3], NULL, 10);
        uint64_t mod = strtoull(argv[4], NULL, 10);
        uint64_t result = modexp(base, exp, mod);
        printf("%llu\n", result);
    } else {
        printf("Invalid command or arguments\n");
        return 1;
    }

    return 0;
}
