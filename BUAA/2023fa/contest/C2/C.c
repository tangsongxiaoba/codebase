#include<stdio.h>

int main() {
    char c;
    while(scanf("%c", &c) != EOF) {
        if('0' <= c && c <= '9') {
            putchar('0'+'9'-c);
        }
        else if('a' <= c && c <= 'z') {
            putchar('a'+'z'-c);
        }
        else if(c == ' ') {
            putchar(' ');
        }
    }
    return 0;
}