#include <stdio.h>
#include "Array.h"


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

	while (fscanf_s(input_file, "%i", &arr->data[arr->size]) == 1 && !isNewLineOrEOF(input_file)) {

		++arr->size;

		if (arr->size >= arr->capacity) {
			arr->capacity += 10;
			arr->data = (int*)realloc(arr->data, arr->capacity * sizeof(int));
		}
	}

	if (!isNewLineOrEOF(input_file) || arr->size == 0) {
		arr->size = 0;
		arr->capacity = 0;

		free(arr->data);
		arr->data = NULL;
	}

	arr->data = (int*)realloc(arr->data, arr->size * sizeof(int));
	arr->capacity = arr->size;
}


void printArray(FILE* output_array, const Array* arr) {
	for (size_t i = 0; i < arr->size; ++i) {
		fprintf(output_array, "%i ", arr->data[i]);
	}

	fprintf(output_array, "\n");
}

void printArraya(const Array* arr) {
	for (size_t i = 0; i < arr->size; ++i) {
		printf("%i ", arr->data[i]);
	}

	printf("\n");
}