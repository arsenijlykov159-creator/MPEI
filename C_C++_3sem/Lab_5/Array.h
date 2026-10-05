#if !defined(ARRAY_H)
#define ARRAY_H

#include <stdlib.h>

typedef struct {
	int* data;
	size_t size;
	size_t capacity;
} Array;

void clearArray(Array* arr);

void getArray(FILE* input_file, Array* arr);

void printArray(FILE* output_array, const Array* arr);

void printArraya(const Array* arr);

int comprFcn(int value, int compr_value);

int countElemMoreThan(const Array* arr, int compr_value, int(*Fcn)(int, int));

#endif