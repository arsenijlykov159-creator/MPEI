#if !defined(ARRAY_H)
#define ARRAY_H

#include <stdlib.h>

typedef struct {
	int* data;
	size_t size;
	size_t capacity;
} Array;

void getArray(FILE* input_file, Array* arr);

void printArray(FILE* output_array, const Array* arr);

void printArraya(const Array* arr);

#endif