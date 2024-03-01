#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

int read() {
	register int x = 0, f = 0;
	register char c = getchar();
	while (c < '0' || c > '9') f |= c == '-', c = getchar();
	while (c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
	return f ? -x : x;
}

void write(int x) {
	if (x < 0) {
		putchar('-');
		x = -x;
	}
	static int sta[35];
	int top = 0;
	do {
		sta[top++] = x % 10, x /= 10;
	} while (x);
	while (top) putchar(sta[--top] + '0');
}

int main() {
	int i = 0, k = 0, sum = 0, n = 0;
	char s[210];
	gets(s);
	if (s[0] == '\0') return putchar('0'), 0;
	while (isalpha(s[i])) {
		switch (s[i]) {
			case 'C':
				k = 12;
				break;
			case 'H':
				k = 1;
				break;
			case 'O':
				k = 16;
				break;
			case 'N':
				k = 14;
				break;
		}
		while (isdigit(s[++i])) {
			n = n * 10 + s[i] - '0';
		}
		sum += (n == 0 ? k : n * k);
		n = 0;
	}
	write(sum);
	return 0;
}

/*
  another solution:
  
int add[26];

int main() {
    char c;
    int n = 1, res = 0, flag = 0;
    add['C'-'A'] = 12, add['H'-'A'] = 1, add['O'-'A'] = 16, add['N'-'A'] = 14;
    while((c = getchar()) != EOF) {
        flag = scanf("%d", &n);
        res += n*add[c-'A'];
        if(flag == -1) break;
        n = 1;
    }
    write(res);
    return 0;
}
*/
