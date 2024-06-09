#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

char src[100], key[100];
int cnt[200];


int main() {
    gets(src);
    int len = strlen(src), j = -1;
    for(int i = 0; i < len; ++i) {
        if(!cnt[src[i]]) {
            ++cnt[src[i]];
            key[++j] = src[i];
        }
    }
    for(int i = 'z'; i >= 'a'; --i) {
        if(!cnt[i]) key[++j] = i;
    }
    for(int i = 0; i < 26; ++i) putchar(key[i]);
    freopen("encrypt.txt", "r", stdin);
    freopen("output.txt", "w", stdout);
    char ch;
    while((ch = getchar()) != EOF) {
        if(isalpha(ch)) putchar(key[ch-'a']);
        else putchar(ch);
    }
    return 0;
}
