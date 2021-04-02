//UVA11809 浮点数 Floating-Point Numbers
#include<cstdio>
#include<cstring>
#include<cmath>
using namespace std;

const double EPS = 1e-6;
const double lg2 = log10(2);
char s[256];
double a, v;
int b;

int main() {
	while(scanf("%s", s) == 1 && strcmp(s, "0e0") != 0) {
		*strchr(s, 'e') = ' ';
		sscanf(s, "%lf%d", &a, &b);
		v = log10(a) + b;
		for(register int i = 1; i <= 10; ++i) {
			int mhe = round(log10((v + i*lg2 - log10(pow(2, i) - 1))/lg2 + 1) / lg2);
			if(fabs(((1 << mhe) - 1) * lg2 + log10(pow(2, i) - 1) - i*lg2 - v) <= EPS) {
				printf("%d %d\n", i-1, mhe);
				break;
			}
		}
	}
	return 0;
}