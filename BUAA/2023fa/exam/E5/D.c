#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int a[11];

void f(int a, int b, int c) {
    int max, m2, m3;
    if(a > b) {
        if(a > c) {
            max = a;
            if(b > c) m2 = b, m3 = c;
            else m3 = b, m2 = c;
        }
        else {
            max = c, m2 = a; m3 = b;
        }
    }
    else {
        if(b > c) {
            max = b;
            if(a > c) m2 = a, m3 = c;
            else m3 = a, m2 = c;
        }
        else {
            max = c, m2 = b, m3 = a;
        }
    }
    if(m2 + m3 <= max) puts("no triangle");
    else {
        if(m2*m2 + m3*m3 < max*max) puts("obtuse triangle");
        else if(m2*m2 + m3*m3 > max*max) puts("acute triangle");
        else puts("right triangle");
        if(max == m3) puts("equilateral triangle");
        else if(m2 == m3 || max == m2) puts("isosceles triangle");
    }
}

int main() {
    scanf("%d%d%d%d%d%d%d%d%d%d", &a[1],&a[2],&a[3],&a[4],&a[5],&a[6],&a[7],&a[8],&a[9],&a[10]);
    puts("Question 1:");
    f(a[1], a[5], a[9]);
    puts("Question 2:");
    f(a[2], a[7], a[10]);
    puts("Question 3:");
    f(a[2], a[3], a[6]);
    puts("Question 4:");
    f(a[8], a[9], a[10]);
    puts("Question 5:");
    f(a[6], a[7], a[10]);
    puts("Question 6:");
    f(a[3], a[4], a[8]);
    puts("Question 7:");
    f(a[1], a[2], a[6]);
    return 0;
}
