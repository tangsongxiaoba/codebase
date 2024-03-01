#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int main() {
    long long n, score, combo, m, p;
    char c;
    n = read();
    score = combo = m = p = 0;
    while((c = getchar()) != EOF) {
        if(c == '\r' || c == '\n') continue;
        switch(c) {
        case 'p':
            score += 300;
            ++combo;
            ++p;
            if(m < combo) m = combo;
            break;
        case 'g':
            score += 208;
            ++combo;
            if(m < combo) m = combo;
            break;
        case 'b':
            score += 105;
            if(m < combo) m = combo;
            combo = 0;
            break;
        case 'm':
            if(m < combo) m = combo;
            combo = 0;
            break;
        default:
            break;
        }
    }
    printf("%lld\n%lld\n", score, m);
    if(p == n) puts("All Perfect!");
    else if(combo == n) puts("Full Combo!");
    else puts("Moca Complete!");
    return 0;
}
