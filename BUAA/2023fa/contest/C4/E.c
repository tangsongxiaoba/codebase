#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int dat[2][13][4];

int main() {
    int m, i, j, x, y, pts, fga, fta;
    double ts;
    m = read();
    while(scanf("%d%d%d", &i, &x, &y) != EOF) {
        ++dat[0][i][x];
        if(y) {
            ++dat[1][i][x];
        }
    }
    for(i = 1; i <= m; ++i) {
        pts = 0;
        for(j = 1; j <= 3; ++j) {
            pts += dat[1][i][j] * j;
        }
        fga = dat[0][i][2] + dat[0][i][3];
        fta = dat[0][i][1];
        if(fga == 0 && fta == 0) {
            puts("NULL");
            continue;
        }
        ts = 1.0 * pts/(2.0*(fga+0.44*fta));
        printf("%.2f%%\n", ts*100.0);
    }
    return 0;
}
