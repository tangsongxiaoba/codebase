#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

void write(int x) {
    static int sta[35];
    int top = 0;
    if(x < 0) putchar('-'), x = -x;
    do {
        sta[top++] = x % 10, x /= 10;
    }while(x);
    while(top) putchar(sta[--top] + '0');
}

int a[100];

int max_heapify(int arr[], int st, int ed) {
    int dad = st;
    int son = dad * 2 + 1;
    int cnt = 0;
    while(son <= ed) {
        if(son + 1 <= ed && arr[son] < arr[son+1]) ++son;
        ++cnt;
        if(arr[dad] > arr[son]) break;
        else {
            int t = arr[son];
            arr[son] = arr[dad];
            arr[dad] = t;
            dad = son;
            son = dad * 2 + 1;
        }
    }
    return cnt;
}

int tmp[100];

int merge(int arr[], int l, int le, int re) {
    int i = l, j = le+1, q = l;
    int cnt = 0;
    while(i <= le && j <= re) {
        ++cnt;
        if(arr[i] <= arr[j]) tmp[q++] = arr[i++];
        else tmp[q++] = arr[j++];
    }
    while(i <= le) {
        tmp[q++] = arr[i++];
    }
    while(j <= re) {
        tmp[q++] = arr[j++];
    }
    for(i = l; i <= re; ++i) arr[i] = tmp[i];
    return cnt;
}

int mergeSort(int arr[], int left, int right) {
    int cnt = 0;
    if(left < right) {
        int mid = (left + right) / 2;
        cnt += mergeSort(arr, left, mid);
        cnt += mergeSort(arr, mid+1, right);
        cnt += merge(arr, left, mid, right);
    }
    return cnt;
}


int quickSort(int k[ ],int left,int right) {     
    int i, last, cnt = 0;
    if(left<right){
        last=left; 
        for(i=left+1;i<=right;i++) {
            ++cnt;
            if(k[i]<k[left]) {
                int t = k[++last];
                k[last] = k[i];
                k[i] = t;
            }
        }
        int t = k[last];
        k[last] = k[left];
        k[left] = t;
        cnt += quickSort(k,left,last-1); 
        cnt += quickSort(k,last+1,right);   
    }
    return cnt;
}

int main() {
    // freopen("in", "r", stdin);
    int n = read(), op = read(), cnt = 0;
    for(int i = 0; i < n; ++i) a[i] = read();
    switch (op) {
        case 1:
            quickSort(a, 0, n-1);
            cnt = n*(n-1)/2;
            break;
        case 2:
            cnt = 0;
            for(int i = 0; i < n; ++i) {
                int flag = 0;
                for(int j = 1; j < n-i; ++j) {
                    if(a[j-1] > a[j]) {
                        int t = a[j];
                        a[j] = a[j-1];
                        a[j-1] = t;
                        flag = 1;
                    }
                    ++cnt;
                }
                if(!flag) break;
            }
            break;
        case 3:
            cnt = 0;
            for(int i = n/2-1; i >= 0; --i) {
                cnt += max_heapify(a, i, n-1);
            }
            for(int i = n-1; i > 0; --i) {
                int t = a[0];
                a[0] = a[i];
                a[i] = t;
                cnt += max_heapify(a, 0, i-1);
            }
            break;
        case 4:
            cnt = mergeSort(a, 0, n-1);
            break;
        case 5:
            cnt = quickSort(a, 0, n-1);
            break;
    }
    write(a[0]);
    for(int i = 1; i < n; ++i) {
        printf(" %d", a[i]);
    }
    puts(""); write(cnt);
    return 0;
}
