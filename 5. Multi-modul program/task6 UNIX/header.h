#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

#define F0(x) (f(x)-g(x))
#define F1(x) (f1(x)-g1(x))

int it;      		//number of iterations
                    //root() and integral() make it=0
                    //in the beginning of function.
                    //When function ends, it equals number
                    //of iterations in function's algorithm.


double f1_0(double x);

double f1_1(double x);

double f2_0(double x);

double f2_1(double x);

double f3_0(double x);

double f3_1(double x);

double null_func(double x);

double t1_0(double x);

double t1_1(double x);

double t2_0(double x);

double t2_1(double x);

double t3_0(double x);

double t3_1(double x);

double root(double(*f)(double x), double(*f1)(double x),
            double(*g)(double x), double(*g1)(double x),
            double a, double b, double eps1);

double integral(double(*F)(double x), double a, double b, double eps2);

void solve(int *params);

int testroot(int *num, int show);

int test_root_function(double(*t)(double x), double(*t1)(double x),
						double(*tg)(double x), double(*tg1)(double x),
						double bord_left, double bord_right, double true_root,
                        int show);

int testintegral(int *num, int show);

int test_integral_function(double(*t)(double x),
							double bord_left, double bord_right,
							double true_integral, int show);




