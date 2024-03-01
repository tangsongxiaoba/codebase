#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double
#define UL unsigned long long
#define UU unsigned int
#define SWAP(a, b) (((a) ^ (b)) && ((b) ^= (a) ^= (b), (a) ^= (b)))

#define IO_TYPE int
IO_TYPE read() {
    register IO_TYPE x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= (c == '-'), c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f ? -x : x;
}
void write(IO_TYPE x) {
    static short sta[23];
    short top = 0;
    if(x < 0) putchar('-'), x = -x;
    do {
        sta[top++] = x % 10, x /= 10;
    } while(x);
    while(top) putchar(sta[--top] + '0');
}
#undef IO_TYPE

typedef struct node {
    int x, y;
} axis;

axis horse[10010];

int ma[110][110];

const int dx[] = {+1, +2, +2, +1, -1, -2, -2, -1};
const int dy[] = {-2, -1, +1, +2, +2, +1, -1, -2};

int main() {
    int m = read(), n = read(), T = read();
    int i;
    for(i = 0; i < T; ++i) {
        horse[i].x = read(), horse[i].y = read();
        ma[horse[i].x][horse[i].y] = -1;
    }
    for(i = 0; i < T; ++i) {
        int j, xx = horse[i].x, yy = horse[i].y;
        for(j = 0; j < 8; ++j) {
            if(xx+dx[j] < 1 || yy+dy[j] < 1) continue;
            else if(ma[xx+dx[j]][yy+dy[j]] == -1) continue;
            ma[xx+dx[j]][yy+dy[j]] = 1;
        }
    }
    int j;
    for(i = 1; i <= m; ++i) {
        for(j = 1; j <= n; ++j) {
            if(ma[i][j] == -1 || ma[i][j] == 1) {
                putchar('0');
            }
            else putchar('1');
        }
        puts("");
    }
    return 0;
}
