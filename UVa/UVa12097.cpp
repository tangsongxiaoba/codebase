//UVA12097/LA3635 Pie
#include<cstdio>
#include<cmath>
#include<algorithm>
using namespace std;

const double PI = acos(-1.0);
const int MAXN = 1e4+5;

int n, f;
double a[MAXN];

inline bool ok(const double &area) {
	int sum = 0;
	for(int i = 0; i < n; ++i)
		sum += floor(a[i] / area);
	return sum >= f+1;
}

inline void gmax(double &x, const double &y) {
	if(x < y) x = y;
}

int main() {
	int T;
	scanf("%d", &T);
	while(T--) {
		scanf("%d%d", &n, &f);
		double maxa = -1;
		for(int i = 0; i < n; ++i) {
			int r;
			scanf("%d", &r);
			a[i] = PI*r*r;
			gmax(maxa, a[i]);
		}
		double L = 0, R = maxa;
		while(R-L > 1e-5) {
			double M = (L+R) / 2;
			if(ok(M)) L = M;
			else R = M;
		}
		printf("%.4lf\n", L);
	}
	return 0;
}