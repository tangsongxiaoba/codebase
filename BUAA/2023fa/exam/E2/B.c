#include<stdio.h>

int main() {
    char c;
    while((c = getchar()) != EOF) {
        if(c == '\n' || c == '\r') continue;
        if(c > 'A' && c <= 'Z') {
            putchar(c-1);
        }
        else putchar(c);
    }
    return 0;
}