#include "common.h"

void
dgemm_ijk(double *a, double *b, double *c, unsigned int n) {
    unsigned int i,j,k;
    /* ijk – simple triple loop algorithm with simple single register reuse*/
    for (i=0; i<n; i++)
        for (j=0; j<n; j++) {
            register double r=c[i*n+j];
            for (k=0; k<n; k++)
                r += a[i*n+k] * b[k*n+j];
            c[i*n+j]=r;
        }
}

void
dgemm_jik(double *a, double *b, double *c, unsigned int n) {
    unsigned int i,j,k;
    for (j=0; j<n; j++)
        for (i=0; i<n; i++) {
            register double r=c[i*n+j];
            for (k=0; k<n; k++)
                r += a[i*n+k] * b[k*n+j];
            c[i*n+j]=r;
        }
}


void
dgemm_kij(double *a, double *b, double *c, unsigned int n) {
    unsigned int i,j,k;
    for (k=0; k<n; k++)
        for (i=0; i<n; i++) {
            register double r = a[i*n+k];
            for (j=0; j<n; j++)
                c[i*n+j] += r * b[k*n+j];
        }
}


void
dgemm_ikj(double *a, double *b, double *c, unsigned int n) {
    unsigned int i,j,k;
    for (i=0; i<n; i++)
        for (k=0; k<n; k++) {
            register double r = a[i*n+k];
            for (j=0; j<n; j++)
                c[i*n+j] += r * b[k*n+j];
        }
}

void
dgemm_jki(double *a, double *b, double *c, unsigned int n) {
    unsigned int i,j,k;
    for (j=0; j<n; j++)
        for (k=0; k<n; k++) {
            register double r = b[k*n+j];
            for (i=0; i<n; i++)
                c[i*n+j] += a[i*n+k] * r;
        }
}

void
dgemm_kji(double *a, double *b, double *c, unsigned int n) {
    unsigned int i,j,k;
    for (k=0; k<n; k++) 
        for (j=0; j<n; j++) {
            register double r = b[k*n+j];
            for (i=0; i<n; i++)
                c[i*n+j] += a[i*n+k] * r;
        }
}



void
dgemm_blocked_ikj(double *a, double *b, double *c, unsigned int n, unsigned int B) {
    unsigned int i, j, k, i1, j1, k1, m;
    /* ikj – blocked version algorithm*/
    m = n/B*B;
    for (i = 0; i < m; i+=B)
        for (k = 0; k < m; k+=B) 
            for (j = 0; j < m; j+=B) 
                /* B x B mini matrix multiplications */
                for (i1 = i; i1 < i+B; ++i1)
                    for (k1 = k; k1 < k+B; ++k1) {
                        register double r=a[i1 * n + k1];
                        for (j1 = j; j1 < j+B; ++j1) 
                            c[i1 * n + j1] += r * b[k1 * n + j1];
                    }
    if (m != n) {
        for (i = 0; i < m; i+=B)
            for (k = m; k < n; ++k) 
                for (j = 0; j < m; j+=B)  
                    /* B x B mini matrix multiplications */
                    for (i1 = i; i1 < i+B; ++i1) {
                        register double r=a[i1 * n + k];
                        for (j1 = j; j1 < j+B; ++j1) 
                            c[i1 * n + j1] += r * b[k * n + j1];
                    }
        for (i = 0; i < m; ++i) 
            for (k = 0; k < n; ++k)
                for (j = m; j< n; ++j)
                    c[i * n + j] += a[i * n + k] * b[k * n + j]; 
        for (i = m; i < n; ++i)
            for (k = 0; k < n; ++k)
                for (j = 0; j< n; ++j)
                    c[i * n + j] += a[i * n + k] * b[k * n + j]; 
    }
}



void
dgemm_mixed(double *a, double *b, double *c, unsigned int n, unsigned int B) {
    unsigned int i, j, k, i1, j1, k1, m, r, p;
    /* ikj – blocked version algorithm*/
    m = n/B*B;
    p = (B/3)*3;
    r = B - 2;
    for (i = 0; i < m; i+=B)
        for (k = 0; k < m; k+=B) 
            for (j = 0; j < m; j+=B) 
                /* B x B mini matrix multiplications */
                {
                    for (i1 = i; i1 < i+r; i1+=3)
                        for (j1 = j; j1 < j+r; j1+=3) {
                            unsigned int t = i1*n+j1; unsigned int t1 = t+n; unsigned int t2 = t+2*n;
                            register double c00 = c[t];  register double c01 = c[t+1];  register double c02 = c[t+2];
                            register double c10 = c[t1]; register double c11 = c[t1+1]; register double c12 = c[t1+2];
                            register double c20 = c[t2]; register double c21 = c[t2+1]; register double c22 = c[t2+2];
                            for (k1 = k; k1 < k+r; k1+=3) {
                                unsigned int ta = i1*n+k1; unsigned int ta1 = ta+n; unsigned int ta2 = ta+2*n;
                                unsigned int tb = k1*n+j1; unsigned int tb1 = tb+n; unsigned int tb2 = tb+2*n;
                
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
                
                            for (k1 = k+p; k1 < k+B; ++k1) {
                                unsigned int ta = i1*n+k1; unsigned int ta1 = ta+n; unsigned int ta2 = ta+2*n;
                                unsigned int tb = k1*n+j1;
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
            
                    for (i1 = i; i1 < i+B; ++i1)
                        for (j1 = j+p; j1 < j+B; ++j1)
                            for (k1 = k; k1 < k+B; ++k1)
                                c[i1*n+j1] += a[i1*n+k1] * b[k1*n+j1];
                    for (i1 = i+p; i1 < i+B; ++i1)
                        for (j1 = j; j1 < j+p; ++j1)
                            for (k1 = k; k1 < k+B; ++k1)
                                c[i1*n+j1] += a[i1*n+k1] * b[k1*n+j1];
                }
    if (m != n) {
        for (i = 0; i < m; i+=B)
            for (k = m; k < n; ++k) 
                for (j = 0; j < m; j+=B)  
                    /* B x B mini matrix multiplications */
                    for (i1 = i; i1 < i+B; ++i1) {
                        register double r=a[i1 * n + k];
                        for (j1 = j; j1 < j+B; ++j1) 
                            c[i1 * n + j1] += r * b[k * n + j1];
                    }
        for (i = 0; i < m; ++i) 
            for (k = 0; k < n; ++k)
                for (j = m; j< n; ++j)
                    c[i * n + j] += a[i * n + k] * b[k * n + j]; 
        for (i = m; i < n; ++i)
            for (k = 0; k < n; ++k)
                for (j = 0; j< n; ++j)
                    c[i * n + j] += a[i * n + k] * b[k * n + j]; 
    }
}


typedef void (*matrixMutiplyWithBlock)(double *a, double *b, double *c, unsigned int n, unsigned int B);

double* runTestWithBlock(matrixMutiplyWithBlock func, double *a, double *b, unsigned int n, unsigned int B, double* p_out, double* t_out) {
    double *c, timed, n3, p;
    struct timespec ts1,ts2,diff;
    c = createMatrix(n);
    clock_gettime(CLOCK_REALTIME, &ts1);
    func(a,b,c,n,B);
    clock_gettime(CLOCK_REALTIME, &ts2);
    timespec_diff(&ts1,&ts2,&diff);
    timed = (double)(diff.tv_sec) + 1e-9 * (double)(diff.tv_nsec);
    n3 = (double)n;
    p = 2*n3*n3*n3/timed*1e-9;
    *p_out = p;
    *t_out = timed;
    // printf("performace: %lf Gflops\n", p);
    // printf("timespec is %lu s %lu ns\n", diff.tv_sec, diff.tv_nsec);
    return c;
}


#define RunAndCheckAns(func, c) \
    printf("%s, when n = %d\n", #func, n); \
    c = runTest(func, a, b, n); \
    if (checkEqual(c0, c, n) == 0) { \
        printf("%s output error when n = %d\n", #func, n); \
        exit(1); \
    } else { \
        printf("%s output checked when n = %d\n", #func, n); \
    } \
    free(c); \
    printf("\n------------------\n")
    


int main(int argc, char *argv[]) {
    unsigned int n, B; int flag = 0;
    double *a, *b, *c0, *c1, p_out, t_out;
    
    srand(12306);
    if (argc <= 1) {
        printf("please give a number n in args\n");
        exit(0);
    }
    n = atoi(argv[1]);
    if (argc == 3 && argv[2][1] == 'N') {
        flag = 1;
    }
    a = createMatrixWithRandomData(n);
    b = createMatrixWithRandomData(n);
    printf("\n==================\nRandom data generated\n------------------\n");

    printf("dgemm_ijk, when n = %d\n", n);
    c0 = runTest(dgemm_ijk, a, b, n);
    printf("\n------------------\n");

    RunAndCheckAns(dgemm_jik, c1);
    RunAndCheckAns(dgemm_kij, c1);
    RunAndCheckAns(dgemm_ikj, c1);
    RunAndCheckAns(dgemm_jki, c1);
    RunAndCheckAns(dgemm_kji, c1);
    
    printf("Block Size,Performance(Gflops),Time(s)\n");
    if (flag) {
        B = 254;  //  got the best B by local test
        c1 = runTestWithBlock(dgemm_blocked_ikj, a, b, n, B, &p_out, &t_out);
        printf("%d, %lf, %lf\n", B, p_out, t_out);
        
        if (checkEqual(c0, c1, n) == 0) {
            // printMatrix(c1, n);
            printf("%s output error when n = %d\n", "dgemm_blocked_ikj", n);
            exit(1);
        } 
        free(c1);
    } else {
        for (B = 8; B <= 256; B+=2) {
            c1 = runTestWithBlock(dgemm_blocked_ikj, a, b, n, B, &p_out, &t_out);
            printf("%d, %lf, %lf\n", B, p_out, t_out);
            
            if (checkEqual(c0, c1, n) == 0) {
                // printMatrix(c1, n);
                printf("%s output error when n = %d\n", "dgemm_blocked_ikj", n);
                exit(1);
            } 
            free(c1);
        }
    }

    printf("\n------------------\n\n");

    // testing the dgemm_mixed
    printf("Block Size,Performance(Gflops),Time(s)\n");
    if (flag) {
        B = 30; // got the best B by local test
        c1 = runTestWithBlock(dgemm_mixed, a, b, n, B, &p_out, &t_out);
        printf("%d, %lf, %lf\n", B, p_out, t_out);
        
        if (checkEqual(c0, c1, n) == 0) {
            // printMatrix(c1, n);
            printf("%s output error when n = %d\n", "dgemm_mixed", n);
            exit(1);
        } 
        free(c1);
    } else {
        for (B = 8; B <= 256; B+=2) {
            c1 = runTestWithBlock(dgemm_mixed, a, b, n, B, &p_out, &t_out);
            printf("%d, %lf, %lf\n", B, p_out, t_out);
            
            if (checkEqual(c0, c1, n) == 0) {
                // printMatrix(c1, n);
                printf("%s output error when n = %d\n", "dgemm_mixed", n);
                exit(1);
            } 
            free(c1);
        }
    }

    free(a); free(b);
    free(c0); 
    return 0;
}
