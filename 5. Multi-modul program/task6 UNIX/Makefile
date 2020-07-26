all: main

clean:
	rm -rf main *.o

main: main.o functions.o root.o integral.o solve.o testroot.o testintegral.o asmfunctions.o
	gcc -m32 -o main main.o functions.o root.o integral.o solve.o testroot.o testintegral.o asmfunctions.o -lm

main.o: main.c
	gcc -m32 -c -o main.o main.c

functions.o: functions.c
	gcc -m32 -c -o functions.o functions.c

asmfunctions.o: asmfunctions.asm
	nasm -f elf32 -o asmfunctions.o asmfunctions.asm

root.o: root.c
	gcc -m32 -c -o root.o root.c

integral.o: integral.c
	gcc -m32 -c -o integral.o integral.c

solve.o: solve.c
	gcc -m32 -c -o solve.o solve.c

testroot.o: testroot.c
	gcc -m32 -c -o testroot.o testroot.c

testintegral.o: testintegral.c
	gcc -m32 -c -o testintegral.o testintegral.c

main.o functions.o root.o integral.o solve.o testroot.o testintegral.o: header.h
