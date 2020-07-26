#include "header.h"

//functions from problem
//fi_j means: i is number of function, j is number of derivative
//     (0 is same function, 1 is derivative of this function)

//test functions
//there is function which returns 0
//nul_func will be second function in root() during testing
//so, root() in test variant will find roots of first t function
//or find intersections of f1, f2, f3 functions
double null_func(double x)
{
    return 0.0;
}
double t1_0(double x)
{
    return 0.5 * x * x * x * x + x * x * x; // 1/2 * x^4 + x^3
}
double t1_1(double x)
{
    return 2 * x * x * x + 3 * x * x;	// 2 * x^3 + 3 * x^2
}
double t2_0(double x)
{
    return 2 * sin(x) - 1;
}
double t2_1(double x)
{
    return 2 * cos(x);
}
double t3_0(double x)
{
    return -exp(x) + 1;
}
double t3_1(double x)
{
    return -exp(x);
}
