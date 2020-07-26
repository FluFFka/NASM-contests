#include "header.h"

int test_root_function(double(*t)(double x), double(*t1)(double x),
						double(*tg)(double x), double(*tg1)(double x),
                        double bord_left, double bord_right, double true_root,
                        int show)
{
    double eps;
    double res;
    for (eps = 0.1; eps >= 1e-9; eps /= 10) {	//check for different eps
        res = root(t, t1, tg, tg1, bord_left, bord_right, eps);
        if (show || fabs(res - true_root) > eps) {	//extra information (-sh or error has found)
            printf("eps = %.10e, result of root(): %lf\n", eps, res);
            printf("true eps = %.10e\n", fabs(res - true_root));
            printf("number of iterations: %d\n", it);
        }
        if (fabs(res - true_root) > eps) {
            return 1;
        }
    }
    printf("root which was returned by function is %.10e\n", res);		//most accurate answer
    printf("(eps = %.10e)\n\n", eps);
    return 0;
}

int testroot(int *num, int show)
{
	printf("TESTING ROOT FUNCTION:\n");
	double bord_left, bord_right, true_root;	//bord_left, bord_right - borders of searchpath
													//true_root - real value of root
	int resp;	//responce of test_root_function
	
	if (num[6] || num[0]) {
		//t1
		bord_left = -2.5;
		bord_right = -1.75;
		true_root = -2;
		printf("function t1: 1/2 * x^4 + x^3\ntrue root in [%lf; %lf] is %lf\n", bord_left, bord_right, true_root);
		resp = test_root_function(t1_0, t1_1, null_func, null_func, bord_left, bord_right, true_root, show);
		if (resp == 1) {
			printf("ERROR");
			return 1;
		}
	} if (num[6] || num[1]) {
		//t2
		bord_left = 0.2;
		bord_right = 0.8;
		true_root = M_PI / 6;
		printf("function t2: 2 * sin(x) - 1\ntrue root in [%lf; %lf] is %lf\n", bord_left, bord_right, true_root);
		resp = test_root_function(t2_0, t2_1, null_func, null_func, bord_left, bord_right, true_root, show);
		if (resp == 1) {
			printf("ERROR");
			return 1;
		}
	} if (num[6] || num[2]) {
		//t3
		bord_left = -0.5;
		bord_right = 0.5;
		true_root = 0;
		printf("function t3: -exp(x) + 1\ntrue root in [%lf; %lf] is %lf\n", bord_left, bord_right, true_root);
		resp = test_root_function(t3_0, t3_1, null_func, null_func, bord_left, bord_right, true_root, show);
		if (resp == 1) {
			printf("ERROR");
			return 1;
		}
	} if (num[6] || num[3]) {
		//f1 - f3
		bord_left = -3;
		bord_right = -2;
		true_root = -2.52222342435525;
		printf("function f1-f3: 2^x + x/3 + 2/3\ntrue root in [%lf; %lf] is %lf\n", bord_left, bord_right, true_root);
		resp = test_root_function(f1_0, f1_1, f3_0, f3_1, bord_left, bord_right, true_root, show);
		if (resp == 1) {
			printf("ERROR");
			return 1;
		}
	} if (num[6] || num[4]) {
		//f2 - f3
		bord_left = 0.4;
		bord_right = 0.8;
		true_root = 0.65051952096845916;
		printf("function f2-f3: x^5 - x/3 + 1/3\ntrue root in [%lf; %lf] is %lf\n", bord_left, bord_right, true_root);
		resp = test_root_function(f2_0, f2_1, f3_0, f3_1, bord_left, bord_right, true_root, show);
		if (resp == 1) {
			printf("ERROR");
			return 1;
		}
	} if (num[6] || num[5]) {
		//f1 - f2
		bord_left = 1.1;
		bord_right = 1.3;
		true_root = 1.279353191077210572;
		printf("function f1-f2: 2^x - x^5 + 1\ntrue root in [%lf; %lf] is %lf\n", bord_left, bord_right, true_root);
		resp = test_root_function(f1_0, f1_1, f2_0, f2_1, bord_left, bord_right, true_root, show);
		if (resp == 1) {
			printf("ERROR");
			return 1;
		}
	}
	return 0;
}