#include <iostream>[
#include <array>

using namespace std;

void myMerge(int L[], int nL, int R[], int nR, int A[]) {
    int i = 0;
    int j = 0;
    int k = 0;
    while (i < nL && j < nR) {
        if (L[i] <= R[j]) {
            A[k] = L[i];
            i++;
        }
        else {
            A[k] = R[j];
            j++;
        }
        k++;
    }

    while (i < nL) {
        A[k] = L[i];
        i++;
        k++;
    }
    while (j < nR) {
        A[k] = R[j];
        j++;
        k++;
    }
}

void mergeSort(int A[], int n) {
    if (n < 2) {
        return;
    }

    int mid = n/2;
    int left[mid];
    int right[n - mid];

    for (int i = 0; i < mid; i++) {
        left[i] = A[i];
    }
    for (int i = mid; i < n; i++) {
        right[i - mid] = A[i];
    }

    mergeSort(left, mid);
    mergeSort(right, n - mid);
    myMerge(left, mid, right, n - mid, A);
}

int main() {
    int n = 8;
    int A[n] = {2, 4, 1, 6, 8, 5, 3, 7};
    mergeSort(A, n);
}
