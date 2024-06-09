#include<stdio.h>

struct Node {
    int a, b, c, d;
}x[8][8][8][8];

int main() {
    int a, b, c, d, e, f, g, h, i, j, k, l;
    for(a = 0; a < 5; ++a) {
        for(b = 0; b < 5; ++b) {
            for(c = 0; c < 5; ++c) {
                for(d = 0; d < 5; ++d) {
                    e = (a + 1 * c) % 5;
                    f = (b + 1 * d) % 5;
                    g = (a + 4 * c) % 5;
                    h = (b + 4 * d) % 5;
                    i = (e + 1 * f) % 5;
                    j = (e + 4 * f) % 5;
                    k = (g + 2 * h) % 5;
                    l = (g + 3 * h) % 5;
                    x[i][j][k][l].a = a;
                    x[i][j][k][l].b = b;
                    x[i][j][k][l].c = c;
                    x[i][j][k][l].d = d;
                }
            }
        }
    }
    scanf("%d%d%d%d", &i, &j, &k, &l);
    printf("%d %d %d %d", x[i][j][k][l].a, x[i][j][k][l].b, x[i][j][k][l].c, x[i][j][k][l].d);
    return 0;
}