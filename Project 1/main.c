#include <stdlib.h>

double*
createMatrix(unsigned int n) {
    return (double*) malloc(sizeof(double)*n*n+1);
}

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

/*dgemm1: simple ijk version triple loop algorithm with register reuse*/
void
dgemm2(double *a, double *b, double *c, unsigned int n) {
    unsigned int i,j,k;
    for (i = 0; i < n; i+=2)
        for (j = 0; j < n; j+=2) {
            register int t = i*n+j; register int tt = t+n;
            register double c00 = c2[t]; register double c01 = c2[t+1];  register double c10 = c2[tt]; register double c11 = c2[tt+1];
            for (k = 0; k < n; k+=2) {
                register int ta = i*n+k; register int tta = ta+n; register int tb = k*n+j; register int ttb = tb+n;
                register double a00 = a[ta]; register double a10 = a[tta]; register double b00 = b[tb]; register double b01 = b[tb+1];
                c00 += a00*b00 ; c01 += a00*b01 ; c10 += a10*b00 ; c11 += a10*b01 ;
                a00 = a[ta+1]; a10 = a[tta+1]; b00 = b[ttb]; b01 = b[ttb+1];
                c00 += a00*b00 ; c01 += a00*b01 ; c10 += a10*b00 ; c11 += a10*b01 ;
            }
            c2[t] = c00;
            c2[t+1] = c01;
            c2[tt] = c10;
            c2[tt+1] = c11;
        }
}

typedef void (*matrixMutiply)(double *a, double *b, double *c, unsigned int n);

void runTest(matrixMutiply func, unsigned int n) {
    double *a, *b, *c;
    a = createMatrix(n);
    b = createMatrix(n);
    c = createMatrix(n);

    func(a,b,c,n);

    free(a); free(b); free(c);
}


int main() {
    runTest(dgemm0, 64);
    return 0;
}
