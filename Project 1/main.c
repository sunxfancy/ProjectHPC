#include "common.h"
/*dgemm0: simple ijk version triple loop algorithm*/
void
dgemm0(double *a, double *b, double *c, unsigned int n) {
    unsigned int i,j,k;
    for (i=0; i<n; i++)
        for (j=0; j<n; j++)
            for (k=0; k<n; k++)
                c[i*n+j] += a[i*n+k] * b[k*n+j];
}

/*dgemm1: simple ijk version triple loop algorithm with register reuse*/
void
dgemm1(double *a, double *b, double *c, unsigned int n) {
    unsigned int i,j,k;
    for (i=0; i<n; i++)
        for (j=0; j<n; j++) {
            register double r = c[i*n+j] ;
            for (k=0; k<n; k++)
                r += a[i*n+k] * b[k*n+j];
            c[i*n+j] = r;
        }
}

/*dgemm2: more aggressive register reuse*/
void
dgemm2(double *a, double *b, double *c, unsigned int n) {
    unsigned int i,j,k;
    for (i = 0; i < n; i+=2)
        for (j = 0; j < n; j+=2) {
            int t = i*n+j; int tt = t+n;
            register double c00 = c[t];  register double c01 = c[t+1];
            register double c10 = c[tt]; register double c11 = c[tt+1];
            for (k = 0; k < n; k+=2) {
                int ta = i*n+k; int tta = ta+n; int tb = k*n+j; int ttb = tb+n;
                register double a00 = a[ta]; register double a10 = a[tta];
                register double b00 = b[tb]; register double b01 = b[tb+1];
                c00 += a00*b00; c01 += a00*b01;
                c10 += a10*b00; c11 += a10*b01;

                a00 = a[ta+1];  a10 = a[tta+1];
                b00 = b[ttb];  b01 = b[ttb+1];
                c00 += a00*b00; c01 += a00*b01;
                c10 += a10*b00; c11 += a10*b01;
            }
            c[t]  = c00; c[t+1]  = c01;
            c[tt] = c10; c[tt+1] = c11;
        }
}

/*dgemm3: maximize the register reuse if we have 16 registers*/
void
dgemm3(double *a, double *b, double *c, unsigned int n) {
    unsigned int i,j,k;
    int p = (n/3)*3;
    int r = n - 2;
    for (i = 0; i < r; i+=3)
        for (j = 0; j < r; j+=3) {
            unsigned int t = i*n+j; unsigned int t1 = t+n; unsigned int t2 = t+2*n;
            register double c00 = c[t];  register double c01 = c[t+1];  register double c02 = c[t+2];
            register double c10 = c[t1]; register double c11 = c[t1+1]; register double c12 = c[t1+2];
            register double c20 = c[t2]; register double c21 = c[t2+1]; register double c22 = c[t2+2];
            for (k = 0; k < r; k+=3) {
                unsigned int ta = i*n+k; unsigned int ta1 = ta+n; unsigned int ta2 = ta+2*n;
                unsigned int tb = k*n+j; unsigned int tb1 = tb+n; unsigned int tb2 = tb+2*n;

                register double a00 = a[ta]; register double a10 = a[ta1];  register double a20 = a[ta2];
                register double b00 = b[tb]; register double b01 = b[tb+1]; register double b02 = b[tb+2];
                c00 += a00*b00; c01 += a00*b01; c02 += a00*b02;
                c10 += a10*b00; c11 += a10*b01; c12 += a10*b02;
                c20 += a20*b00; c21 += a20*b01; c22 += a20*b02;

                a00 = a[ta+1]; a10 = a[ta1+1]; a20 = a[ta2+1];
                b00 = b[tb1];  b01 = b[tb1+1]; b02 = b[tb1+2];
                c00 += a00*b00; c01 += a00*b01; c02 += a00*b02;
                c10 += a10*b00; c11 += a10*b01; c12 += a10*b02;
                c20 += a20*b00; c21 += a20*b01; c22 += a20*b02;

                a00 = a[ta+2]; a10 = a[ta1+2]; a20 = a[ta2+2];
                b00 = b[tb2];  b01 = b[tb2+1]; b02 = b[tb2+2];
                c00 += a00*b00; c01 += a00*b01; c02 += a00*b02;
                c10 += a10*b00; c11 += a10*b01; c12 += a10*b02;
                c20 += a20*b00; c21 += a20*b01; c22 += a20*b02;
            }

            for (k = p; k < n; ++k) {
                unsigned int ta = i*n+k; unsigned int ta1 = ta+n; unsigned int ta2 = ta+2*n;
                unsigned int tb = k*n+j;
                register double a00 = a[ta]; register double a10 = a[ta1];  register double a20 = a[ta2];
                register double b00 = b[tb]; register double b01 = b[tb+1]; register double b02 = b[tb+2];
                c00 += a00*b00; c01 += a00*b01; c02 += a00*b02;
                c10 += a10*b00; c11 += a10*b01; c12 += a10*b02;
                c20 += a20*b00; c21 += a20*b01; c22 += a20*b02;
            }

            c[t]  = c00; c[t+1]  = c01; c[t+2]  = c02;
            c[t1] = c10; c[t1+1] = c11; c[t1+2] = c12;
            c[t2] = c20; c[t2+1] = c21; c[t2+2] = c22;
        }

    for (i = 0; i < n; ++i)
        for (j = p; j < n; ++j)
            for (k = 0; k < n; ++k)
                c[i*n+j] += a[i*n+k] * b[k*n+j];
    for (i = p; i < n; ++i)
        for (j = 0; j < p; ++j)
            for (k = 0; k < n; ++k)
                c[i*n+j] += a[i*n+k] * b[k*n+j];
}

typedef void (*matrixMutiply)(double *a, double *b, double *c, unsigned int n);

double* runTest(matrixMutiply func, double *a, double *b, unsigned int n) {
    double *c;
    struct timespec ts1,ts2,diff;
    c = createMatrix(n);
    clock_gettime(CLOCK_REALTIME, &ts1);
    func(a,b,c,n);
    clock_gettime(CLOCK_REALTIME, &ts2);
    timespec_diff(&ts1,&ts2,&diff);
    double timed = diff.tv_sec + 1e-9 * diff.tv_nsec;
    printf("performace: %.6f Gflops\n", 2*n*n*n*1e-9/timed);
    printf("timespec is %lu s %lu ns", diff.tv_sec, diff.tv_nsec);
    return c;
}


int main() {
    unsigned int n;
    srand(12306);

    for (n = 64; n <= 2048; n = n*2 ) {
        double *a, *b, *c0, *c1, *c2, *c3;
        a = createMatrixWithRandomData(n);
        b = createMatrixWithRandomData(n);
        printf("\n==================\nRandom data generated\n------------------\n");

        printf("dgemm0, when n = %d\n", n);
        c0 = runTest(dgemm0, a, b, n);
        printf("\n------------------\n");

        printf("dgemm1, when n = %d\n", n);
        c1 = runTest(dgemm1, a, b, n);
        printf("\n------------------\n");

        printf("dgemm2, when n = %d\n", n);
        c2 = runTest(dgemm2, a, b, n);
        printf("\n------------------\n");

        printf("dgemm3, when n = %d\n", n);
        c3 = runTest(dgemm3, a, b, n);
        printf("\n------------------\n");
        // printMatrix(c3, n);

        if (checkEqual(c0, c1, n) == 0) {
            printf("c1 output error when n = %d\n", n);
            exit(1);
        } else {
            printf("c1 output checked when n = %d\n", n);
        }
        if (checkEqual(c0, c2, n) == 0) {
            printf("c2 output error when n = %d\n", n);
            exit(1);
        } else {
            printf("c2 output checked when n = %d\n", n);
        }
        if (checkEqual(c0, c3, n) == 0) {
            printf("c3 output error when n = %d\n", n);
            exit(1);
        } else {
            printf("c3 output checked when n = %d\n", n);
        }
        free(a); free(b);
        free(c0); free(c1); free(c2);
    }
    return 0;
}
