#include "header.h"

int main(int argc, char *argv[])
{
	int *underst = malloc(argc * sizeof(int));
	for (int i = 0; i < argc; ++i) underst[i] = 0;
	underst[0] = 1;
	for (int key = 0; key < 4; ++key) {
		//0 is -help, 1 is -testroot, 2 is -testintegral, 3 is -result
		for (int ind = 1; ind < argc; ++ind) {
			if (key == 0 && !strcmp(argv[ind], "-help")) {	//key help
				printf("Usage: main [-help] [-testroot [-num arg ...] [-sh]]\n[-testintegral [-num arg ...] [-sh]] [-result [-intersections] [-iterations]]\n\n");
				printf("Arguments:\n");
				printf("  -help\t\t\t\t\tshow this help message and exit\n");
				printf("  -testroot [-num arg ...] [-sh]\ttest function root\n");
				printf("  -testintegral [-num arg ...] [-sh]\ttest function integral\n");
				printf("    -num arg ...\t\t\toptional argument for -testroot and -testintegral\n");
				printf("\t\t\t\t\tchange set of functions for testing\n\t\t\t\t\t(by default all functions are in test set)\n");
				printf("\t\t\t\t\ttake set of function's numbers for testing \n\t\t\t\t\t(all arguments are natural numbers from 1 to 6)\n");
				printf("    -sh\t\t\t\t\toptional argument for -testroot and -testintegral\n\t\t\t\t\tshow extra test information\n");
				printf("  -result\t\t\t\tshow solve of problem\n");
				printf("    -intersections\t\t\toptional argument for -result\n\t\t\t\t\tshow abscissas of curve intersections\n");
				printf("    -iterations\t\t\t\toptional argument for -result\n\t\t\t\t\tshow number of iterations in solve\n");
				return 0;	//exit program
			} else if (key == 3 && !strcmp(argv[ind], "-result")) {
				//keys -result, -intersections, -iterations
				int params[2];
				params[0] = 0; params[1] = 0;
				underst[ind] = 1;
				while (ind + 1 < argc && (!strcmp(argv[ind + 1], "-iterations") || !strcmp(argv[ind + 1], "-intersections"))) {
					underst[ind] = 1;
					if (!strcmp(argv[ind + 1], "-iterations")) params[0] = 1;
					if (!strcmp(argv[ind + 1], "-intersections")) params[1] = 1;
					ind++;
				}
				solve(params);
				for (; ind < argc; ++ind) {
					if (!strcmp(argv[ind], "-result") || !strcmp(argv[ind], "-intersections") || !strcmp(argv[ind], "-iterations")) underst[ind] = 1;
				}
				break;
			} else if ((key == 2 || key == 3) && (!strcmp(argv[ind], "-testroot") || !strcmp(argv[ind], "-testintegral"))) {
				//keys -testroot, -testintegral
				underst[ind] = 1;
				int curr_k;	//memorize key
				if (!strcmp(argv[ind], "-testroot")) curr_k = 2;
				else curr_k = 3;
				if (curr_k != key) continue;
				int show = 0;	//parameter for show extra information (1 - show, 0 - hide (default))
				int num[7];		//functions which will be tested (0 - not test, 1 - test)
				for (int i = 0; i < 6; ++i) num[i] = 0;
				num[6] = 1;		//num[6] = 1 means all functions will tested (default)
				if (ind + 1 < argc && !strcmp(argv[ind + 1], "-sh")) {
					//check -sh
					ind++;	//to next argument
					underst[ind] = 1;
					show = 1;
				}
				if (ind + 1 < argc && !strcmp(argv[ind + 1], "-num")) {		//check -num
					ind++;	//to next argument
					underst[ind] = 1;
					num[6] = 0;	//set of test functions will be custom
					while (ind + 1 < argc && argv[ind + 1][0] != '-') {
						ind++;	//number found
						underst[ind] = 1;
						int curr_number = atoi(argv[ind]);	//curr found number
						if (curr_number < 1 || curr_number > 6) {
							//incorrect input
							for (int i = 0; i < 7; ++i) {
								num[i] = 0;
							}
							break;
						} else {
							num[curr_number - 1] = 1;	//function curr_number will be tested
						}
						
					}
				}
				if (ind + 1 < argc && !strcmp(argv[ind + 1], "-sh")) {
					//check -sh
					ind++;
					underst[ind] = 1;
					show = 1;
				}
				//check num has 1
				for (int i = 0; i < 7; ++i) {
					if (num[i]) {
						if (curr_k == 2) testroot(num, show);	//root
						else testintegral(num, show);		//integral
						break;
					}
					if (i == 6) {
						printf("Empty argument field or incorrect arguments input. Please, check \"-help\"\n");
					}
				}
				for (; ind < argc; ++ind) {
					if (!strcmp(argv[ind], "-num") || !strcmp(argv[ind], "-sh")) {
						underst[ind] = 1;
					} else if (curr_k == 2 && !strcmp(argv[ind], "-testroot")) {
						underst[ind] = 1;
					} else if (curr_k == 3 && !strcmp(argv[ind], "-testintegral")) {
						underst[ind] = 1;
					}
				}
				break;
			}	
		}
	
	}
	for (int i = 0; i < argc; ++i) {
		if (!underst[i]) {
			printf("\nSome arguments weren't recognized correctly. Please, check -help\n");
			break;
		}
	}
	free(underst);
	if (argc == 1) {
		//there's not any argument
		printf("There's no any argument\nUse \"-help\" to check available arguments\n");
	}
    return 0;
}
