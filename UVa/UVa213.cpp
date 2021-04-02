// UVa213 Message Decoding
#include<cstdio>
#include<cstring>

int code[8][1<<8];

inline int readchar() {
    for(;;) {
      register int ch = getchar();
      if(ch != '\n' && ch != '\r') return ch;
    }
}

inline int readint(int c) {
    register int v = 0;
    while(c--) v = v * 2 + readchar() - '0';
    return v;
}

inline int readcodes() {
    memset(code, 0, sizeof(code));
    code[1][0] = readchar();
    for(register int len = 2; len <= 7; ++len) {
        for(register int i = 0; i < (1<<len)-1; ++i) {
            register int ch = getchar();
            if(ch == EOF) return 0;
            if(ch == '\n' || ch == '\r') return 1;
            code[len][i] = ch;
        }
    }
    return 1;
}

int main() {
    while(readcodes()) {
        for(;;) {
            register int len = readint(3);
            if(len == 0) break;
            for(;;) {
                register int v = readint(len);
                if(v == (1 << len)-1) break;
                putchar(code[len][v]);
            }
        }
        putchar('\n');
    }
    return 0;
}
