#include <stdio.h>
#include <string.h>

int a[100010];
int q1[100010], q2[100010];
int front, rear;

int read(void) {
    register int x = 0;
    register int f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f ? -x : x;
}

int main(void) {
    freopen("in", "r", stdin);
    int t = read();
    while(t--) {
        int n = read(), d = read(), k = read();
        for(int i = 0; i < n; ++i) {
            a[i] = 0;
            q1[i] = q2[i] = 0;
        }
        for(int i = 0; i < k; ++i) {
            int l = read(), r = read();
            a[l] += 1, a[r + 1] -= 1;
        }
        int delta = 0;
        for(int i = 1; i <= n; ++i) {
            delta += a[i];
            a[i] = delta;
        }
        for(int i = 1; i <= n; ++i) {
            a[i] += a[i - 1];
            // printf("%d ", a[i]);
        }
        puts("");
        front = 1, rear = 1;
        int mm = -1, ans;
        for(int i = 1; i <= n; ++i) {
            while(front <= rear && q1[front] + d < i) ++front;
            while(front <= rear && a[q1[rear]] >= a[i]) --rear;
            q1[++rear] = i;
            if(mm < a[i] - a[q1[front]]) {
                mm = a[i] - a[q1[front]];
                ans = q1[front];
            }
        }
        printf("%d ", ans);
        front = 1, rear = 1, mm = 10000000;
        for(int i = 1; i <= n; ++i) {
            while(front <= rear && i - q2[front] < d) ++front;
            if(mm > a[i] - a[q2[front]]) {
                mm = a[i] - a[q2[front]];
                ans = q2[front];
            }
            while(front <= rear && a[i] >= a[q2[rear]]) --rear;
            q2[++rear] = i;
        }
        printf("%d\n", ans);
    }
    return 0;
}
