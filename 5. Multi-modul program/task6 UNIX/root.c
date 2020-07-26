#include "header.h"

double root(double(*f)(double x), double(*f1)(double x),
            double(*g)(double x), double(*g1)(double x),
            double a, double b, double eps1)
{
    it = 0;

    double c1, c2;      //c1 and c2 are new borders (a and b)
    while (b - a >= eps1) {
        if ((F0((a + b) / 2) < (F0(a) + F0(b)) / 2 && F1(a) > 0) ||
            (F0((a + b) / 2) > (F0(a) + F0(b)) / 2 && F1(a) < 0)) {        //F'(x) * F''(x) > 0
            c1 = (a * F0(b) - b * F0(a)) / (F0(b) - F0(a)); //chord method
            c2 = b - F0(b) / F1(b);                      //tangent method
            a = c1;		//change borders
            b = c2;
        } else {
            c2 = (a * F0(b) - b * F0(a)) / (F0(b) - F0(a)); //chord method
            c1 = a - F0(a) / F1(a);                      //tangent method
            a = c1;		//change borders
            b = c2;
        }
        it++;
    }
    return (a + b) / 2;     //return root
}