#include "header.h"

double integral(double(*F)(double x), double a, double b, double eps2)
{
    it = 0;
    double p = 1.0 / 3, h;		//p - coefficient for Rugne's rule, h - is curr step
    int n0 = 10, k = 1;			//n = n0 * k - number of steps
    double In = 0, I2n = 0;		//I_n, I_2n for Rugne's rule
    h = (b - a) / (n0 * k);		//calculate h
    it++;
    for (int i = 0; i <= n0 * k; ++i) {     //calculate first sum
        I2n += F(a + i * h);
    }
    I2n -= (F(a) + F(b)) / 2;
    I2n *= h;		//I2n calculated
    do {
		//calculate I2n
        it++;
        In = I2n;
        I2n = 0;
        k *= 2;
        h = (b - a) / (n0 * k);
        //In = 2*h * (1/2 * F_0 + F_2 + F_4 + ... + 1/2 * F_(n0*k))
        //I2n = h * (1/2 * F_0 + F_1 + F_2 + ... + 1/2 * F_(n0*k))
        //then, calculate only odd values of F and add In / (2*h) then get I2n / h:
        for (int i = 1; i < n0 * k; i += 2) {       //calculate odd values
            I2n += F(a + i * h);
        }
        I2n += In / (2 * h);            //add even values
        I2n *= h;                       //get I2n
    } while (p * fabs(I2n - In) >= eps2);  //Runge's rule
    return I2n;
}