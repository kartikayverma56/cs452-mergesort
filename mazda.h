#ifndef __MAZDA_H
#define __MAZDA_H

#ifdef __cplusplus
extern "C" {
#endif

#define TRUE 1
#define FALSE 0

// function prototypes
void serial_mergesort(int A[], int p, int r);
void merge(int A[], int p, int q, int r);
void insertion_sort(int A[], int p, int r);

const int INSERTION_SORT_THRESHOLD = 100; //based on trial and error

#ifdef __cplusplus
}
#endif
#endif //__MAZDA_H
