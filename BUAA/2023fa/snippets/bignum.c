#include <stdio.h>
#include <math.h>

#define	MAXDIGITS	100000		/* maximum length bignum */

#define PLUS		1		/* positive sign bit */
#define MINUS		-1		/* negative sign bit */

typedef struct {
	char digits[MAXDIGITS];         /* represent the number */
	int signbit;			/* 1 if positive, -1 if negative */
	int lastdigit;			/* index of high-order digit */
} bignum;

/*	c = a () b;	*/

int max(int a, int b);
void print_bignum(bignum *n);
void initialize_bignum(bignum *n);
void int_to_bignum(int s, bignum *n);
void str_to_bignum(char *s, bignum *n);
void zero_justify(bignum *n);
void digit_shift(bignum *n, int d);
int compare_bignum(bignum *a, bignum *b);
void add_bignum(bignum *a, bignum *b, bignum *c);
void subtract_bignum(bignum *a, bignum *b, bignum *c);
void multiply_bignum(bignum *a, bignum *b, bignum *c);
void divide_bignum(bignum *a, bignum *b, bignum *c);

int main() {
    /*e.g. 输入的整数或者字符数组转化为bignum类型进行乘法运算，最后输出三个数
     整数不能超过int范围，字符数组可以存储100位整数*/
    /*除法运算是整除，不能保留小数*/
    bignum a, b, c;
    int x;
    char s[100];
    scanf("%d", &x);
    scanf("%s", s);
    int_to_bignum(x, &a);
    str_to_bignum(s, &b);
    multiply_bignum(&a, &b, &c);
    print_bignum(&a); putchar('\n');
    print_bignum(&b); putchar('\n');
    print_bignum(&c);
    return 0;
}

int max(int a, int b) {
    if (a > b) return (a);
    else return (b);
}

void print_bignum(bignum *n) {
	int i;
	if (n->signbit == MINUS) printf("-");
	for (i = n->lastdigit; i >= 0; i--)
		printf("%c", '0' + n->digits[i]);
}

void initialize_bignum(bignum *n) {
    int_to_bignum(0, n);
}

void int_to_bignum(int s, bignum *n) {
	int i;				/* counter */
	int t;				/* int to work with */

	if (s >= 0) n->signbit = PLUS;
	else n->signbit = MINUS;

	for (i = 0; i < MAXDIGITS; i++) n->digits[i] = (char) 0;

	n->lastdigit = -1;

	t = abs(s);

	while (t > 0) {
		n->lastdigit ++;
		n->digits[ n->lastdigit ] = (t % 10);
		t = t / 10;
	}

	if (s == 0) n->lastdigit = 0;
}

void str_to_bignum(char *s, bignum *n) {
    initialize_bignum(n);
    while((*s <= '0' || *s > '9') && *s != '\0') {
        if(*s == '-') n->signbit = MINUS;
        ++s;
    }
    if(*s == '\0') return;
    char *ptr = s;
    while(*ptr != '\0') ++ptr;
    n->lastdigit = -1;
    while(ptr > s) {
        --ptr;
        if(*ptr < '0' && *ptr > '9') continue;
        n->lastdigit ++;
        n->digits[ n->lastdigit ] = (*ptr) - '0';
    }
}

void zero_justify(bignum *n) {
    while ((n->lastdigit > 0) && (n->digits[ n->lastdigit ] == 0))
        n->lastdigit --;
    
    if ((n->lastdigit == 0) && (n->digits[0] == 0))
        n->signbit = PLUS;	/* hack to avoid -0 */
}

/* multiply n by 10^d */
void digit_shift(bignum *n, int d) {
    int i;				/* counter */
    
    if ((n->lastdigit == 0) && (n->digits[0] == 0)) return;
    
    for (i = n->lastdigit; i >= 0; i--)
        n->digits[i + d] = n->digits[i];
    
    for (i = 0; i < d; i++) n->digits[i] = 0;
    
    n->lastdigit = n->lastdigit + d;
}

int compare_bignum(bignum *a, bignum *b) {
    int i;				/* counter */
    
    if ((a->signbit == MINUS) && (b->signbit == PLUS)) return (PLUS);
    if ((a->signbit == PLUS) && (b->signbit == MINUS)) return (MINUS);
    
    if (b->lastdigit > a->lastdigit) return (PLUS * a->signbit);
    if (a->lastdigit > b->lastdigit) return (MINUS * a->signbit);
    
    for (i = a->lastdigit; i >= 0; i--) {
        if (a->digits[i] > b->digits[i]) return (MINUS * a->signbit);
        if (b->digits[i] > a->digits[i]) return (PLUS * a->signbit);
    }
    
    return (0);
}

void subtract_bignum(bignum *a, bignum *b, bignum *c) {
    int borrow;			/* has anything been borrowed? */
    int v;				/* placeholder digit */
    int i;				/* counter */
    
    initialize_bignum(c);
    
    if ((a->signbit == MINUS) || (b->signbit == MINUS)) {
        b->signbit = -1 * b->signbit;
        add_bignum(a, b, c);
        b->signbit = -1 * b->signbit;
        return;
    }
    
    if (compare_bignum(a, b) == PLUS) {
        subtract_bignum(b, a, c);
        c->signbit = MINUS;
        return;
    }
    
    c->lastdigit = max(a->lastdigit, b->lastdigit);
    borrow = 0;
    
    for (i = 0; i <= (c->lastdigit); i++) {
        v = (a->digits[i] - borrow - b->digits[i]);
        if (a->digits[i] > 0)
            borrow = 0;
        if (v < 0) {
            v = v + 10;
            borrow = 1;
        }
        
        c->digits[i] = (char) v % 10;
    }
    
    zero_justify(c);
}

void add_bignum(bignum *a, bignum *b, bignum *c) {
	int carry;			/* carry digit */
	int i;				/* counter */

	initialize_bignum(c);

	if (a->signbit == b->signbit) c->signbit = a->signbit;
	else {
		if (a->signbit == MINUS) {
			a->signbit = PLUS;
			subtract_bignum(b, a, c);
			a->signbit = MINUS;
		} else {
			b->signbit = PLUS;
			subtract_bignum(a, b, c);
			b->signbit = MINUS;
		}
		return;
	}

	c->lastdigit = max(a->lastdigit, b->lastdigit) + 1;
	carry = 0;

	for (i = 0; i <= (c->lastdigit); i++) {
		c->digits[i] = (char) (carry + a->digits[i] + b->digits[i]) % 10;
		carry = (carry + a->digits[i] + b->digits[i]) / 10;
	}

	zero_justify(c);
}

void multiply_bignum(bignum *a, bignum *b, bignum *c) {
	bignum row;			/* represent shifted row */
	bignum tmp;			/* placeholder bignum */
	int i, j;			/* counters */

	initialize_bignum(c);

	row = *a;

	for (i = 0; i <= b->lastdigit; i++) {
		for (j = 1; j <= b->digits[i]; j++) {
			add_bignum(c, &row, &tmp);
			*c = tmp;
		}
		digit_shift(&row, 1);
	}

	c->signbit = a->signbit * b->signbit;

	zero_justify(c);
}

void divide_bignum(bignum *a, bignum *b, bignum *c) {
	bignum row; /* represent shifted row */
	bignum tmp; /* placeholder bignum */
	int asign, bsign; /* temporary signs */
	int i; /* counters */

	initialize_bignum(c);

	c->signbit = a->signbit * b->signbit;

	asign = a->signbit;
	bsign = b->signbit;

	a->signbit = PLUS;
	b->signbit = PLUS;

	initialize_bignum(&row);
	initialize_bignum(&tmp);

	c->lastdigit = a->lastdigit;

	for (i = a->lastdigit; i >= 0; i--) {
		digit_shift(&row, 1);
		row.digits[0] = a->digits[i];
		c->digits[i] = 0;
		while (compare_bignum(&row, b) != PLUS) {
			c->digits[i] ++;
			subtract_bignum(&row, b, &tmp);
			row = tmp;
		}
	}

	zero_justify(c);

	a->signbit = asign;
	b->signbit = bsign;
}

