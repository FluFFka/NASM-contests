#include "header.h"

int test_integral_function(double(*t)(double x),
							double bord_left, double bord_right,
							double true_integral, int show)
{
    double eps;
    double res;
    for (eps = 0.1; eps >= 1e-9; eps /= 10) {	//check for different eps
        res = integral(t, bord_left, bord_right, eps);
        if (show || fabs(res - true_integral) > eps) {	//extra information (-sh or error has found)
            printf("eps = %.10e, result of integral(): %lf\n", eps, res);
            printf("true eps = %.10e\n", fabs(res - true_integral));
            printf("number of iterations: %d\n", it);
        }
        if (fabs(res - true_integral) > eps) {
            return 1;		//error
        }
    }
    printf("root which was returned by function is %.10e\n", res);		//most accurate answer
    printf("(eps = %.10e)\n\n", eps);
    return 0;
}

int testintegral(int *num, int show)
{
	printf("TESTING INTEGRAL FUNCTION:\n");
	double bord_left, bord_right, true_integral;	//bord_left, bord_right - borders of searchpath
													//true_integral - real value of integral
	int resp;	//responce of test_integral_function

	if (num[6] || num[0]) {
		//t1
		bord_left = 0.0;
		bord_right = 1.0;
		true_integral = 7.0/20;
		printf("function t1: 1/2 * x^4 + x^3\ntrue value of integral in [%lf; %lf] is %lf\n", bord_left, bord_right, true_integral);
		resp = test_integral_function(t1_0, bord_left, bord_right, true_integral, show);
		if (resp == 1) {
			printf("ERROR");
			return 1;
		}
	} if (num[6] || num[1]) {
		//t2
		bord_left = 1.0;
		bord_right = 2.0;
		true_integral = 2 * (cos(1) - cos(2)) - 1;
		printf("function t2: 2 * sin(x) - 1\ntrue value of integral in [%lf; %lf] is %lf\n", bord_left, bord_right, true_integral);
		resp = test_integral_function(t2_0, bord_left, bord_right, true_integral, show);
		if (resp == 1) {
			printf("ERROR");
			return 1;
		}
	} if (num[6] || num[2]) {
		//t3
		bord_left = 1.0;
		bord_right = 2.0;
		true_integral = -exp(2) + exp(1) + 1;
		printf("function t3: -exp(x) + 1\ntrue value of integral in [%lf; %lf] is %lf\n", bord_left, bord_right, true_integral);
		resp = test_integral_function(t3_0, bord_left, bord_right, true_integral, show);
		if (resp == 1) {
			printf("ERROR");
			return 1;
		}
	} if (num[6] || num[3]) {
		//f1
		bord_left = -2.0;
		bord_right = 1.0;
		true_integral = (2 - 0.25) / M_LN2 + 3;
		printf("function f1: 2^x + 1\ntrue value of integral in [%lf; %lf] is %lf\n", bord_left, bord_right, true_integral);
		resp = test_integral_function(f1_0, bord_left, bord_right, true_integral, show);
		if (resp == 1) {
			printf("ERROR");
			return 1;
		}
	} if (num[6] || num[4]) {
		//f2
		bord_left = 0.5;
		bord_right = 1.0;
		true_integral = 63.0/384;
		printf("function f2: x^5\ntrue value of integral in [%lf; %lf] is %lf\n", bord_left, bord_right, true_integral);
		resp = test_integral_function(f2_0, bord_left, bord_right, true_integral, show);
		if (resp == 1) {
			printf("ERROR");
			return 1;
		}
	} if (num[6] || num[5]) {
		//f3
		bord_left = -2.0;
		bord_right = 1.0;
		true_integral = 1.5;
		printf("function f3: (1 - x)/3\ntrue value of integral in [%lf; %lf] is %lf\n", bord_left, bord_right, true_integral);
		resp = test_integral_function(f3_0, bord_left, bord_right, true_integral, show);
		if (resp == 1) {
			printf("ERROR");
			return 1;
		}
	}
	return 0;
}