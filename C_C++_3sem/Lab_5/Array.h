#if !defined(ARRAY_H)
#define ARRAY_H

#include <stdlib.h>
#include <cmath>

typedef struct {
	double* data;
	size_t size;
	size_t capacity;
} Array;


typedef double(*cFcn)(double);


void clearArray(Array* arr);

void getArray(FILE* input_file, Array* arr);

void printArrayInfo(const Array* arr);

double outputFcn(double value);

void printArrayToFile(FILE* output_array, const Array* arr, double(*someFcn)(double) = outputFcn);

void printArray(const Array* arr);

double comprFcn(double value);



int countElemMoreThan(const Array* arr, double compr_value, cFcn Fcn);

int max(int x, int y);

#endif