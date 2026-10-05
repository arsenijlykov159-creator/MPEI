#include <stdio.h>
#include "Array.h"


void clearArray(Array* arr) {
	if (arr == NULL) return;

	arr->size = 0;
	arr->capacity = 0;

	free(arr->data);
	arr->data = NULL;
}

int isNewLineOrEOF(FILE* in) {
	int next_elem = fgetc(in);

	int result = (next_elem == '\n' || next_elem == '\r' || next_elem == EOF);

	ungetc(next_elem, in);

	return result;
}

void getArray(FILE* input_file, Array* arr) {
	if (!input_file) {
		arr->data = NULL;
		return;
	}

	arr->data = (int*)malloc(10 * sizeof(int));
	arr->capacity = 10;
	arr->size = 0;

	while (fscanf_s(input_file, "%i", &arr->data[arr->size]) == 1) {

		++arr->size;

		if (arr->size >= arr->capacity) {
			arr->capacity += 10;
			arr->data = (int*)realloc(arr->data, arr->capacity * sizeof(int));
		}

		if (isNewLineOrEOF(input_file)) break;
	}

	if (!isNewLineOrEOF(input_file) || arr->size == 0) clearArray(arr);

	arr->data = (int*)realloc(arr->data, arr->size * sizeof(int));
	arr->capacity = arr->size;
}

void printArrayToFile(FILE* output_array, const Array* arr) {
	for (size_t i = 0; i < arr->size; ++i) {
		fprintf(output_array, "%i ", arr->data[i]);
	}

	fprintf(output_array, "\n");
}

void printArray(const Array* arr) {
	for (size_t i = 0; i < arr->size; ++i) {
		printf("%i ", arr->data[i]);
	}

	printf("\n");
}

bool comprFcn(int value, int compr_value) { return value > compr_value; }



int countElemMoreThan(const Array* arr, int compr_value, cFcn Fcn) {
	if (arr->size == 0) return 0;

	int count = 0;
	for (size_t i = 0; i < arr->size; ++i) {
		if (Fcn(arr->data[i], compr_value)) ++count;
	}

	return count;
}