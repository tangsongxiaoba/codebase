// #pragma GCC optimize("Ofast,no-stack-protector,unroll-loops,fast-math")
// #pragma GCC target("sse,sse2,sse3,ssse3,sse4.1,sse4.2,avx,avx2,popcnt,tune=native")
// #pragma GCC optimize(3)
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnewline-eof"
#include <ctype.h>
#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define maxCount 200
#define max2(a, b) ((a) > (b) ? (a) : (b))
#define min2(a, b) ((a) < (b) ? (a) : (b))
#define abs2(x) (((x) >= 0) ? (x) : -(x))
#define gc() (p1 == p2 && (p2 = (p1 = buf) + fread(buf, 1, 1 << 20, fp), p1 == p2) ? EOF : *p1++)
#define pc(c) (obuf[p3++] = c)
#define flush() (fwrite(obuf, 1, p3, stdout), p3 = 0)
#define MaxDP 3300
#define HASH 31

char buf[1 << 20], *p1, *p2;
char obuf[1 << 16];
int p3;

char prog[maxCount][MaxDP];
short length[maxCount];
int id[maxCount], cnt;

#define WCNT 165
unsigned long long hashvalues[WCNT] = {203ULL, 349ULL, 3028ULL, 5353ULL, 6131ULL, 7551ULL, 8235ULL, 11089ULL, 13990ULL, 13990ULL, 17850ULL, 20538ULL, 21251ULL, 94726ULL, 109911ULL, 110624ULL, 110624ULL, 111050ULL, 111053ULL, 111056ULL, 112175ULL, 152496ULL, 156037ULL, 158678ULL, 165953ULL, 222649ULL, 224641ULL, 233886ULL, 241356ULL, 245590ULL, 253276ULL, 257772ULL, 275533ULL, 275549ULL, 285155ULL, 420102ULL, 423205ULL, 433916ULL, 463396ULL, 559028ULL, 559044ULL, 599205ULL, 636688ULL, 644512ULL, 658791ULL, 666445ULL, 731668ULL, 2906706ULL, 4296737ULL, 5051184ULL, 5140101ULL, 5284050ULL, 7663701ULL, 7663717ULL, 7821694ULL, 7822126ULL, 7912146ULL, 7947196ULL, 7947212ULL, 7990814ULL, 7991539ULL, 8020736ULL, 8050745ULL, 13115591ULL, 18189489ULL, 18571022ULL, 19546283ULL, 19708830ULL, 19993146ULL, 21728753ULL, 22257389ULL, 22261106ULL, 23396947ULL, 105914374ULL, 106438801ULL, 146347378ULL, 188164241ULL, 225078368ULL, 234084882ULL, 236113442ULL, 236861214ULL, 248579491ULL, 252728313ULL, 264789655ULL, 272181619ULL, 432638888ULL, 436353912ULL, 436354065ULL, 436354167ULL, 436369197ULL, 442109483ULL, 522404952ULL, 534138905ULL, 579511620ULL, 579527678ULL, 579725808ULL, 579803515ULL, 608336785ULL, 608344235ULL, 611654504ULL, 611654620ULL, 612212312ULL, 620758454ULL, 621640494ULL, 622128910ULL, 622130373ULL, 622130588ULL, 622130741ULL, 622130843ULL, 622139140ULL, 622146336ULL, 622147128ULL, 622147135ULL, 622147136ULL, 622147733ULL, 624649204ULL, 626794223ULL, 644245859ULL, 673522342ULL, 3269007264ULL, 4157800300ULL, 5532926243ULL, 7364829702ULL, 7634168353ULL, 7679601093ULL, 7708379514ULL, 8208413326ULL, 10366956403ULL, 10366957910ULL, 10368868699ULL, 10369630501ULL, 10372663622ULL, 10377212665ULL, 10380982949ULL, 10381076786ULL, 10383685886ULL, 10385547418ULL, 12926803571ULL, 13527276040ULL, 16654012871ULL, 17953679300ULL, 18859018369ULL, 19171716206ULL, 19286041455ULL, 19286370619ULL, 19286370987ULL, 19286371089ULL, 19286429758ULL, 19286489998ULL, 19286561509ULL, 19971390965ULL, 20025236552ULL, 20033571305ULL, 20314905965ULL, 21406028665ULL, 150191899896ULL, 153129360807ULL, 175075312978ULL, 322026568287ULL, 556733276067ULL, 597869640567ULL, 597870614946ULL, 647601838069ULL, 675794546332ULL, 12412725965658ULL};

void write(int x) {
    static int sta[35];
    int top = 0;
    do {
        sta[top++] = x % 10, x /= 10;
    } while(x);
    while(top)
        pc(sta[--top] + '0');
}

unsigned long long hash(const char *s, int len) {
    unsigned long long h = 0;
    for(int i = 0; i < len; ++i) {
        h = h * HASH + s[i] - '_' + 1;
    }
    return h;
}

void readcodes(void) {
    FILE *fp = fopen("codes.txt", "r");
    char ch, cur = -1, pre = -1;
    int k = 0, idx = 0;
    char *p;
    while((ch = gc()) != EOF) {
        p = prog[cnt];
        while(!isdigit(ch) && ch != EOF) ch = gc();
        while(isdigit(ch) && ch != EOF)
            idx = (idx << 3) + (idx << 1) + (ch ^ 48), ch = gc();
        for(; ch != '\f' && ch != EOF; cur = ch, ch = gc()) {
            if((cur == ' ' || !isprint(cur)) && !((pre == '_' || isalnum(pre)) && (ch == '_' || isalnum(ch)))) goto M;
            p[k++] = (!isprint(cur) ? ' ' : cur);
        M:
            pre = (!isprint(cur) || cur == ' ' ? pre : cur);
        }
        id[cnt] = idx;
        p[k] = '\0';
        ++cnt;
        idx = 0;
        k = 0;
        cur = -1;
        pre = -1;
    }
    fclose(fp);
}

bool find(char *s, int l) {
    if(l > 10) return false;
    unsigned long long h = hash(s, l);
    int left = 0, right = WCNT - 1, mid = 0;
    while(left <= right) {
        mid = (left + right) >> 1;
        if(h > hashvalues[mid])
            left = mid + 1;
        else if(h < hashvalues[mid])
            right = mid - 1;
        else
            return true;
    }
    return false;
}

char callstk[100][100];
short funcstk[100];

int processfu(char *s, int *st, int *ed, int op) {
    int fcnt = 0;
    int cpos = 0;
    int pos = 0, i = 0, ss, tt, k;
    while(s[i] != '{') ++i;
    ++pos;
    *st = i++;
    while(pos > 0) {
        if(s[i] == '}') {
            --pos, *ed = i, ++i;
            continue;
        }
        if(s[i] == '{') {
            ++pos, ++i;
            continue;
        }
        while(s[i] != '{' && s[i] != '}' && !(isalpha(s[i]) || s[i] == '_')) ++i;
        if(s[i] == '{' || s[i] == '}') continue;
        ss = i;
        while(isalnum(s[i]) || s[i] == '_') ++i;
        tt = i;
        if(find(s + ss, tt - ss)) continue;
        if(s[i] != '(') goto HERE;
        if(op != 0) goto HERE2;
        for(k = 0; k < cpos; ++k)
            if(memcmp(callstk[k], s + ss, tt - ss) == 0)
                goto HERE2;
        memcpy(callstk[cpos], s + ss, tt - ss);
        callstk[cpos][tt - ss] = '(';
        callstk[cpos][tt - ss + 1] = '\0';
        ++cpos;
    HERE2:
        funcstk[fcnt++] = ss;
    HERE:
        memset(s + ss, ' ', tt - ss);
    }
    return cpos;
}

short b[maxCount][128];
char tmp[MaxDP];
void processcd(void) {
    int i, j, k, kk, tmppos, st, ed, funcCnt;
    char *mainpos, *funcpos;
    for(i = 0; i < cnt; ++i) {
        tmppos = 0;
        mainpos = strstr(prog[i], "main(");
        if(mainpos == NULL) continue;
        funcCnt = processfu(mainpos, &st, &ed, 0);
        for(j = st, k = 0; j <= ed; ++j)
            mainpos[j] != ' ' ? (tmp[tmppos++] = mainpos[j], ++b[i][(int)mainpos[j]]) : (j == funcstk[k] ? (++k, tmp[tmppos++] = 'F', tmp[tmppos++] = 'U', tmp[tmppos++] = 'N', tmp[tmppos++] = 'C', ++b[i]['F'], ++b[i]['U'], ++b[i]['N'], ++b[i]['C']) : 1);
        for(j = 0; j < funcCnt; ++j) {
            funcpos = strstr(prog[i], callstk[j]);
            if(funcpos == NULL) continue;
            memset(funcstk, 0, sizeof(funcstk));
            processfu(funcpos, &st, &ed, 1);
            for(k = st, kk = 0; k <= ed; ++k)
                funcpos[k] != ' ' ? (tmp[tmppos++] = funcpos[k], ++b[i][(int)funcpos[k]]) : (k == funcstk[kk] ? (++kk, tmp[tmppos++] = 'F', tmp[tmppos++] = 'U', tmp[tmppos++] = 'N', tmp[tmppos++] = 'C', ++b[i]['F'], ++b[i]['U'], ++b[i]['N'], ++b[i]['C']) : 1);
        }
        tmp[tmppos] = '\0';
        length[i] = tmppos;
        memcpy(prog[i], tmp, tmppos + 1);
        b[i][0] = 1;

    }
}

short f1[MaxDP], f2[MaxDP];

bool dp(char *a, char *bb, int l1, int l2, int ed) {
    if(l1 == 0) return (l2 <= ed);
    if(l2 == 0) return (l1 <= ed);
    char *s1 = bb, *s2 = a, c;
    int n = l2, m = l1, min, max;
    if(l2 < l1) {
        s1 = a, s2 = bb;
        n = l1, m = l2;
    }
    short *p = f1, *d = f2, *h;
    int boundary = min2(n, ed) + 1, bbb = max2(n, ed) + 1;
    memset(p, 0x3f, sizeof(short) * bbb);
    memset(d, 0x3f, sizeof(short) * bbb);
    for(int i = 0; i < boundary; ++i) p[i] = i;
    for(int j = 1, i; j <= m; ++j) {
        c = s2[j - 1];
        d[0] = j;
        min = max2(1, j - ed);
        max = (j > 0x3f3f - ed) ? n : min2(n, j + ed);
        if(min > max) return false;
        if(min > 1) d[min - 1] = 0x3f3f;
        for(i = min; i <= max; ++i)
            d[i] = (s1[i - 1] == c) ? p[i - 1] : 1 + min2(min2(d[i - 1], p[i]), p[i - 1]);
        // if(d[max] > ed && d[max] < 0x3f3f) return false;
        h = p;
        p = d;
        d = h;
    }
    return (p[n] <= ed);
}

bool visited[maxCount];
bool sim[maxCount][maxCount];

int bucket(int i, int j) {
    int cnt_b = 0;
    for(int k = 33; k < 127; ++k) cnt_b += abs2(b[i][k] - b[j][k]);
    return cnt_b;
}

int main(void) {
    readcodes();
    processcd();
    for(int i = 0, j, st, ed1, ed2, ed, th; i < cnt; ++i) {
        if(!b[i][0]) continue;
        for(j = 0; j < i; ++j) {
            if(!b[j][0]) continue;
            st = 0, ed1 = length[i], ed2 = length[j], ed = max2(ed1 - st, ed2 - st), th = 0.05 * ed;
            if(abs2(ed1 - ed2) > th || bucket(i, j) > th) continue;
            while(st < ed1 && st < ed2 && prog[i][st] == prog[j][st]) ++st;
            while(st < ed1 && st < ed2 && prog[i][ed1 - 1] == prog[j][ed2 - 1]) --ed1, --ed2;
            if(dp(prog[i] + st, prog[j] + st, ed1 - st, ed2 - st, th)) sim[i][j] = sim[j][i] = 1;
        }
    }
    for(int i = 0, j, flag; i < cnt; ++i) {
        if(visited[i]) continue;
        flag = false;
        for(j = 0; j < cnt; ++j) {
            if(i == j || !sim[i][j]) continue;
            if(flag == false) {
                flag = true;
                visited[i] = true;
                write(id[i]);
            }
            visited[j] = true;
            pc(' ');
            write(id[j]);
        }
        if(flag) pc('\n');
    }
    flush();
    return 0;
}