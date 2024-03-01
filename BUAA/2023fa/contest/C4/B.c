#include<stdio.h>

int main() {
    char c;
    int flag = 1;
    while((c = getchar()) != EOF) {
        if(c == '\n' || c == '\r') continue;
        if(c == '0') putchar('0');
        else if(c == '1') {
            if(flag) {
                putchar('+');
                flag = 0;
            }
            else {
                putchar('-');
                flag = 1;
            }
            putchar('1');
        }
        putchar(' ');
    }
    return 0;
}
