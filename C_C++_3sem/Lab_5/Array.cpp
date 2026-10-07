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

void printArrayInfo(const Array* arr) {
	if (!arr->data) printf("Массив пустой");
	else printf("Массив не пуст");

	printf(" size: %zu ; capacity : %zu", arr->size, arr->capacity);
}

void getArray(FILE* input_file, Array* arr) {
	if (!input_file) {
		arr->data = NULL;
		return;
	}

	arr->data = (double*)malloc(10 * sizeof(double));
	arr->capacity = 10;
	arr->size = 0;

	while (fscanf_s(input_file, "%lf", &arr->data[arr->size]) == 1) {

		++arr->size;

		if (arr->size >= arr->capacity) {
			arr->capacity *= 2;
			arr->data = (double*)realloc(arr->data, arr->capacity * sizeof(double));
		}

		if (isNewLineOrEOF(input_file)) break;
	}

	if (!isNewLineOrEOF(input_file) || arr->size == 0) clearArray(arr);

	arr->data = (double*)realloc(arr->data, arr->size * sizeof(double));
	arr->capacity = arr->size;
}

void printArrayToFile(FILE* output_array, const Array* arr, double(*someFcn)(double)) {
	for (size_t i = 0; i < arr->size; ++i) {
		fprintf(output_array, "%lf ", someFcn(arr->data[i]));
	}

	fprintf(output_array, "\n");
}

void printArray(const Array* arr) {
	for (size_t i = 0; i < arr->size; ++i) {
		printf("%lf ", arr->data[i]);
	}

	printf("\n");
}

double comprFcn(double value) { return std::sqrt(value); }



int countElemMoreThan(const Array* arr, double compr_value, cFcn Fcn) {
	if (arr->size == 0) return 0;

	int count = 0;
	for (size_t i = 0; i < arr->size; ++i) {
		if (Fcn(arr->data[i]) > compr_value) ++count;
	}

	return count;
}


double outputFcn(double value) { return 1 * value; }

int max(int x, int y) { return (x > y ? x : y); }