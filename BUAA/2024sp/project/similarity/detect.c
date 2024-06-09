#pragma GCC optimize("Ofast,no-stack-protector,unroll-loops,fast-math")
// #pragma GCC target("sse,sse2,sse3,ssse3,sse4.1,sse4.2,avx,avx2,popcnt,tune=native")  
#pragma GCC optimize(3)
#include <math.h> 
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define maxCount 200
#define max2(a,b) ((a)>(b)?(a):(b))
#define min2(a,b) ((a)<(b)?(a):(b))
#define abs2(x) (((x)>=0)?(x):-(x))
#define gc() (p1 == p2 && (p2 = (p1 = buf) + fread(buf, 1, 1 << 20, fp), p1 == p2) ? EOF : *p1++)
#define pc(c) (obuf[p3++] = c)
#define flush() (fwrite(obuf, 1, p3, stdout), p3 = 0)
#define MaxDP 4600
#define HASH 31

char buf[1 << 20], *p1, *p2;
char obuf[1 << 16]; int p3;

char prog[maxCount][MaxDP];
short length[maxCount];
int id[maxCount], cnt;

#define WCNT 165
unsigned long long hashvalues[WCNT] = {203ull,349ull,3028ull,5353ull,6131ull,7551ull,8235ull,11089ull,13990ull,13990ull,17850ull,20538ull,21251ull,94726ull,109911ull,110624ull,110624ull,111050ull,111053ull,111056ull,112175ull,152496ull,156037ull,158678ull,165953ull,222649ull,224641ull,233886ull,241356ull,245590ull,253276ull,257772ull,275533ull,275549ull,285155ull,420102ull,423205ull,433916ull,463396ull,559028ull,559044ull,599205ull,636688ull,644512ull,658791ull,666445ull,731668ull,2906706ull,4296737ull,5051184ull,5140101ull,5284050ull,7663701ull,7663717ull,7821694ull,7822126ull,7912146ull,7947196ull,7947212ull,7990814ull,7991539ull,8020736ull,8050745ull,13115591ull,18189489ull,18571022ull,19546283ull,19708830ull,19993146ull,21728753ull,22257389ull,22261106ull,23396947ull,105914374ull,106438801ull,146347378ull,188164241ull,225078368ull,234084882ull,236113442ull,236861214ull,248579491ull,252728313ull,264789655ull,272181619ull,432638888ull,436353912ull,436354065ull,436354167ull,436369197ull,442109483ull,522404952ull,534138905ull,579511620ull,579527678ull,579725808ull,579803515ull,608336785ull,608344235ull,611654504ull,611654620ull,612212312ull,620758454ull,621640494ull,622128910ull,622130373ull,622130588ull,622130741ull,622130843ull,622139140ull,622146336ull,622147128ull,622147135ull,622147136ull,622147733ull,624649204ull,626794223ull,644245859ull,673522342ull,3269007264ull,4157800300ull,5532926243ull,7364829702ull,7634168353ull,7679601093ull,7708379514ull,8208413326ull,10366956403ull,10366957910ull,10368868699ull,10369630501ull,10372663622ull,10377212665ull,10380982949ull,10381076786ull,10383685886ull,10385547418ull,12926803571ull,13527276040ull,16654012871ull,17953679300ull,18859018369ull,19171716206ull,19286041455ull,19286370619ull,19286370987ull,19286371089ull,19286429758ull,19286489998ull,19286561509ull,19971390965ull,20025236552ull,20033571305ull,20314905965ull,21406028665ull,150191899896ull,153129360807ull,175075312978ull,322026568287ull,556733276067ull,597869640567ull,597870614946ull,647601838069ull,675794546332ull,12412725965658ull};

void write(int x) {
    static int sta[35];
    int top = 0;
    do {
        sta[top++] = x % 10, x /= 10;
    }while(x);
    while(top) pc(sta[--top] + '0');
}

unsigned long long hash(char *s, int len) {
    unsigned long long h = 0;
    for(int i = 0; i < len; ++i) {
        h = h * HASH + s[i] - '_' + 1;
    }
    return h;
}

void readcodes() {
    FILE *fp = fopen("codes.txt", "r");
    char ch, pre = -1, cur = -1;
    int k = 0, idx = 0;
    char *p;
    while((ch = gc()) != EOF) {
        p = prog[cnt];
        while(!isdigit(ch) && ch != EOF) ch = gc();
        while(isdigit(ch) && ch != EOF) idx = (idx << 3) + (idx << 1) + (ch ^ 48), ch = gc();
        for(; ch != '\f' && ch != EOF; cur = ch, ch = gc()) {
            if(!(isprint(cur) || ((isalnum(pre) || pre == '_') && (isalpha(ch) || ch == '_')))) continue;
            p[k++] = (!isprint(cur) ? ' ' : cur);
            pre = cur;
        }
        id[cnt] = idx;
        p[k] = '\0';
        ++cnt;
        idx = 0;
        k = 0;
        pre = -1;
        cur = -1;
    }
    fclose(fp);
}

bool find(char *s, int l) {
    if(l > 10) return false;
    unsigned long long h = hash(s, l);
    int left = 0, right = WCNT-1, mid = 0;
    while(left <= right) {
        mid = (left + right) / 2;
        if(h > hashvalues[mid]) left = mid+1;
        else if(h < hashvalues[mid]) right = mid-1;
        else return true;
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
    ++pos; *st = i++;
    while(pos > 0) {
        if(s[i] == '}') {--pos, *ed = i, ++i; continue;}
        if(s[i] == '{') {++pos, ++i; continue;}
        while(s[i] != '{' && s[i] != '}' && !(isalpha(s[i]) || s[i] == '_')) ++i;
        if(s[i] == '{' || s[i] == '}') continue;
        ss = i;
        while(isalnum(s[i]) || s[i] == '_') ++i;
        tt = i;
        if(find(s+ss, tt-ss)) continue;
        if(s[i] != '(') goto HERE;
        if(op != 0) goto HERE2;
        for(k = 0; k < cpos; ++k)
            if(memcmp(callstk[k], s+ss, tt-ss) == 0) goto HERE2;
        memcpy(callstk[cpos], s+ss, tt-ss);
        callstk[cpos][tt-ss] = '\0';
        ++cpos;
        HERE2: funcstk[fcnt++] = ss;
        HERE: memset(s+ss, ' ', tt-ss);
    }
    return cpos;
}

short b[maxCount][128];
char tmp[MaxDP];
void processcd() {
    int i, j, k, kk, tmppos, st, ed, funcCnt;
    char *mainpos, *funcpos;
    for(i = 0; i < cnt; ++i) {
        tmppos = 0;
        mainpos = strstr(prog[i], "main(");
        funcCnt = processfu(mainpos, &st, &ed, 0);
        for(j = st, k = 0; j <= ed; ++j) 
            mainpos[j] != ' ' ? (tmp[tmppos++] = mainpos[j], ++b[i][mainpos[j]]) : (j == funcstk[k] ? (++k, tmp[tmppos++] = 'F', tmp[tmppos++] = 'U', tmp[tmppos++] = 'N', tmp[tmppos++] = 'C', ++b[i]['F'], ++b[i]['U'], ++b[i]['N'], ++b[i]['C']) : 1);
        for(j = 0; j < funcCnt; ++j) {
            funcpos = strstr(prog[i], callstk[j]);
            if(funcpos == NULL) continue;
            memset(funcstk, 0, sizeof(funcstk));
            processfu(funcpos, &st, &ed, 1);
            for(k = st, kk = 0; k <= ed; ++k) 
                funcpos[k] != ' ' ? (tmp[tmppos++] = funcpos[k], ++b[i][funcpos[k]]) : (k == funcstk[kk] ? (++kk, tmp[tmppos++] = 'F', tmp[tmppos++] = 'U', tmp[tmppos++] = 'N', tmp[tmppos++] = 'C', ++b[i]['F'], ++b[i]['U'], ++b[i]['N'], ++b[i]['C']) : 1);
        }
        tmp[tmppos] = '\0';
        length[i] = tmppos;
        memcpy(prog[i], tmp, tmppos+1);
    }
}

short f1[MaxDP], f2[MaxDP];

bool dp(char *a, char *b, int l1, int l2, int ed) {
    if(l1 == 0) return (l2 <= ed);
    if(l2 == 0) return (l1 <= ed);
    char *s1 = b, *s2 = a, c;
    int n = l2, m = l1, min, max;
    if(l2 < l1) {s1 = a, s2 = b; n = l1, m = l2;}
    short *p = f1, *d = f2, *h;
    int boundary = min2(n, ed) + 1;
    memset(p, 0x3f3f, sizeof(short)*(n+1));
    memset(d, 0x3f3f, sizeof(short)*(n+1));
    for(int i = 0; i < boundary; ++i) p[i] = i;
    for(int j = 1, i; j <= m; ++j) {
        c = s2[j-1];
        d[0] = j;
        min = max2(1, j-ed);
        max = (j > 0x3f3f - ed) ? n : min2(n, j+ed);
        if(min > max) {return false;}
        if(min > 1) d[min-1] = 0x3f3f;
        for(i = min; i <= max; ++i)
            d[i] = (s1[i-1] == c) ? p[i-1] : 1+min2(min2(d[i-1], p[i]), p[i-1]);
        h = p;
        p = d;
        d = h;
    }
    return (p[n] <= ed);
}

bool visited[maxCount];
bool sim[maxCount][maxCount];

int bucket(int i, int j) {
    int cnt = 0;
    for(int k = 33; k < 127; ++k) cnt += abs2(b[i][k] - b[j][k]);
    return cnt;
}

int main() {
    readcodes();
    processcd();
    for(int i = 0, j, st, ed1, ed2, ed, th; i < cnt; ++i) {
        for(j = 0; j < i; ++j) {
            st = 0, ed1 = length[i], ed2 = length[j], ed = max2(ed1-st, ed2-st), th = 0.05*ed; 
            if(abs2(ed1 - ed2) > th+1 || bucket(i, j) > th+1) continue;
            while(st < ed1 && st < ed2 && prog[i][st] == prog[j][st]) ++st;
            while(st < ed1 && st < ed2 && prog[i][ed1-1] == prog[j][ed2-1]) --ed1, --ed2;
            if(dp(prog[i]+st, prog[j]+st, ed1-st, ed2-st, th)) sim[i][j] = sim[j][i] = 1;
        }
    }
    for(int i = 0, j, flag; i < cnt; ++i) {
        if(visited[i]) continue;
        flag = false;
        for(j = 0; j < cnt; ++j) {
            if(i == j || !sim[i][j]) continue;
            flag == false ? (flag = true, visited[i] = true, write(id[i])) : 1;
            visited[j] = true;
            pc(' '); write(id[j]);
        }
        flag ? pc('\n') : 1;
    }
    flush();
    return 0;
}