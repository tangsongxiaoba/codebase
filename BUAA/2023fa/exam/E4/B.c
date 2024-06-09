#include<stdio.h>

const char bcd[][4] = {"0000", "0001", "0010", "0011", "0100", "1011", "1100", "1101", "1110", "1111"};

int main() {
    int i;
    char c;
    while((c=getchar()) != EOF) {
        if(c == '\r' || c == '\n') continue;
        for(i = 0; i < 4; ++i) {
            putchar(bcd[c-'0'][i]);
        }
    }
    return 0;
}
