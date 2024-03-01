#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}


void move(int n, char c1, char c2, char c3) {
    if(n == 1) printf("Eika moved Koishi 01 form the %c to the %c\n", c1, c3);
    else {
        move(n-1, c1, c3, c2);
        printf("Eika moved Koishi %02d form the %c to the %c\n", n, c1, c3);
        move(n-1, c2, c1, c3);
    }
}

int main() {
    int n;
    char c1, c2, c3;
    c1 = getchar();
    getchar();
    c2 = getchar();
    getchar();
    c3 = getchar();
    getchar();
    n = read();
    move(n, c1, c2, c3);
    return 0;
}
