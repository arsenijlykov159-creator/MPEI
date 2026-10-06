#if !defined(ARRAY_H)
#define ARRAY_H

#include <stdlib.h>

typedef struct {
	int* data;
	size_t size;
	size_t capacity;
} Array;


typedef bool(*cFcn)(int, int);


void clearArray(Array* arr);

void getArray(FILE* input_file, Array* arr);

void printArrayInfo(const Array* arr);

void printArrayToFile(FILE* output_array, const Array* arr, int(*someFcn)(int));

void printArray(const Array* arr);

bool comprFcn(int value, int compr_value);

int outputFcn(int value);

int countElemMoreThan(const Array* arr, int compr_value, cFcn Fcn);

int max(int x, int y);

#endif