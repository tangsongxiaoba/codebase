#include <stdio.h>
#include <stdlib.h>

int read(void) {
    register int x = 0;
    register int f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f ? -x : x;
}

int mm[100010];

int cmp(const void *p, const void *q) {
    int *a = (int *)p;
    int *b = (int *)q;
    return (*a) - (*b);
}

int lower_bound(int key, int l, int r) {
    while(l < r) {
        int mid = l + (r - l) / 2;
        if(mm[mid] >= key)
            r = mid;
        else
            l = mid + 1;
    }
    return mm[l] >= key ? l : -1;
}

int main(void) {
    // freopen("b2.in", "r", stdin);
    int t = read();


    while(t--) {
        int n = read(), m = read(), q = read();

        for(int i = 0; i < m; ++i) {
            mm[i] = read();
        }

        qsort(mm, m, sizeof(mm[0]), cmp);

        for(int i = 0; i < q; ++i) {
            int qq = read();
            int res = lower_bound(qq, 0, m - 1);
            if(res != -1) {
                if(mm[res] == qq) {
                    printf("0\n");
                } else {
                    if(res == 0) {
                        printf("%d\n", mm[res]-1);
                    } else {
                        printf("%d\n", (mm[res] - mm[res-1]) / 2);
                    }
                }
            } else {
                printf("%d\n", n-mm[m-1]);
            }
        }
        
    }
    return 0;
}
