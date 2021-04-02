// UVa489 Hangman Judge
#include<cstdio>
#include<cstring>

const int MAXN = 100;
int left, chance, rnd;
char s[MAXN], s2[MAXN];
int win, lose;

inline void guess(const char& ch) {
    register int bad = 1;
    for(register int i = 0; i < strlen(s); ++i)
        if(s[i] == ch) {
            --left;
            s[i] = ' ';
            bad = 0;
        }
    if(bad) --chance;
    if(!chance) lose = 1;
    if(!left) win = 1;
}

int main() {
    while(scanf("%d%s%s", &rnd, s, s2) == 3 && rnd != -1) {
        printf("Round %d\n", rnd);
        win = lose = 0;
        left = strlen(s);
        chance = 7;
        for(register int i = 0; i < strlen(s2); ++i) {
            guess(s2[i]);
            if(win || lose) break;
        }
        if(win) printf("You win.\n");
        else if(lose) printf("You lose.\n");
        else printf("You chickened out.\n");
    }
    return 0;
}
