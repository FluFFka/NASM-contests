#include "header.h"

void solve(int *params)
{
	//param 0 is -result, 1 is -intersections, 2 is -iterations
	printf("SOLVE (explanation in the picture):\n");
	double answer = 0, eps = 1e-9;
	double x1, x2, x3, S1, S2;	//x1, x2, x3 - abscissas of curve intersections
								//S1, S2 - integrals
	int its = 0;	//general number of iterations
	//calculate intersections
	x1 = root(f1_0, f1_1, f3_0, f3_1, -3.0, -2.0, eps);
	its += it;
	x2 = root(f3_0, f3_1, f2_0, f2_1, 0.4, 0.8, eps);
	its += it;
	x3 = root(f1_0, f1_1, f2_0, f2_1, 1.1, 1.3, eps);
	its += it;
	if (params[1]) {
		printf("abscissas of triangle's vertexes:\n");
		printf("x1 = %lf\nx2 = %lf\nx3 = %lf\n", x1, x2, x3);
	}
	S1 = integral(f1_0, x1, x2, eps);
	S2 = integral(f3_0, x1, x2, eps);
	answer += S1 - S2;
	printf("integral of f1 - f3 in [x1; x2] is %lf (S1)\n", S1 - S2);
	S1 = integral(f1_0, x2, x3, eps);
	S2 = integral(f2_0, x2, x3, eps);
	answer += S1 - S2;
	printf("integral of f1 - f2 in [x2; x3] is %lf (S2)\n", S1 - S2);
	printf("So, the result is %lf (S1 + S2)\n", answer);
	printf("(all calculations were rounded to eps = %.1e)\n", eps);
	
	if (params[0]) printf("number of iterations: %d\n", its);
}

