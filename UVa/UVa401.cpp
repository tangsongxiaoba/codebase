//UVA401 回文词 Palindromes
#include<cstdio>
#include<cstring>
#include<cctype>

const char* rev = "A   3  HIL JM O   2TUVWXY51SE Z  8 ";
const char* msg[] = {"not a palindrome", "a regular palindrome", "a mirrored string", "a mirrored palindrome"};
char s[30];

inline char r(const char &ch) {
    if(isalpha(ch)) return rev[ch - 'A'];
    return rev[ch - '0' + 25];
}

int main() {
    while(scanf("%s", s) == 1) {
        register int len = strlen(s), p = 1, m = 1;
        for(register int i = 0; i < (len+1 >> 1); ++i) {
            if(s[i] != s[len-1-i]) p = 0;
            if(r(s[i]) != s[len-1-i]) m = 0;
        }
        printf("%s -- is %s.\n\n", s, msg[m*2+p]);
    }
    return 0;
}