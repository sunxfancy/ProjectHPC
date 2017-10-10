#include <stdlib.h>
#include <stdio.h>
#include <time.h>

double*
createMatrix(unsigned int n) {
    return (double*) calloc(sizeof(double), n*n+1);
}

double*
createMatrixWithRandomData(unsigned int n) {
    double* data; int i;
    data = createMatrix(n);
    for (i = 0; i < n*n; ++i) {
        data[i] = (double)(rand() % 9987) / 100.0;
    }
    return data;
}

int
checkEqual(double *a, double *b, unsigned int n) {
    int i;
    for (i = 0; i< n; ++i) {
        if (a[i] != b[i]) return 0;
    }
    return 1;
}

void timespec_diff(struct timespec *start, struct timespec *stop,
                   struct timespec *result)
{
    if ((stop->tv_nsec - start->tv_nsec) < 0) {
        result->tv_sec = stop->tv_sec - start->tv_sec - 1;
        result->tv_nsec = stop->tv_nsec - start->tv_nsec + 1000000000;
    } else {
        result->tv_sec = stop->tv_sec - start->tv_sec;
        result->tv_nsec = stop->tv_nsec - start->tv_nsec;
    }
    return;
}

void printMatrix(double* m, unsigned int n) {
    unsigned int i,j;
    for (i = 0; i < n; ++i) {
        for (j = 0; j < n; ++j)
            printf("%.2f ", m[i*n+j]);
        printf("\n");
    }
}
