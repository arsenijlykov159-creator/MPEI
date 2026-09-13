#include <stdio.h>
#include <locale.h>

#define ROWS 10
#define COLUMNS 10



int isNewLine(FILE* f) {
	if (!f || feof(f)) return 0;

	int next_char = fgetc(f);
	
	ungetc(next_char, f);

	if (next_char == '\n') return 1;

	return 0;
}

//int getInt(FILE* f) {
//	int value = 0;
//
//	fscanf_s(f, "%i ", &value);
//
//	return value;
//}

void getMatrixFromFile(FILE* f, int a[][COLUMNS], int* rows, int* columns) {
	if (!f) return;

	int element = 0;
	*rows = 0;

	while (1) {
		*columns = 0;

		while (!isNewLine(f) && !feof(f)) {
			if (fscanf_s(f, "%i", &element)) {
				a[*rows][*columns] = element;
				++(*columns);
			}
			else break;
		}

		fgetc(f);
		if (*columns != 0) ++(*rows);
		if (isNewLine(f) || feof(f)) return;
	}
}

void printMatrix(int a[ROWS][COLUMNS], int rows, int columns) {
	for (int i = 0; i < rows; ++i) {
		for (int j = 0; j < columns; ++j) {
			printf("%i ", a[i][j]);
		}

		printf("\n");
	}
}

void printArray(int a[], int length) {
	for (int i = 0; i < length; ++i) {
		printf("%i ", a[i]);
	}
}



int zeroCount_matrix(int a[][COLUMNS], int rows, int columns) {
	
	int count = 0;

	for (int i = 0; i < rows; ++i) {
		for (int j = 0; j < columns; ++j) {
			if (a[i][j] == 0) ++count;
		}
	}

	return count;
}

int zeroCount_array(int a[], int length) {
	int count = 0;

	for (int i = 0; i < length; ++i) {
		if (a[i] == 0) ++count;
	}

	return count;
}



void multOfNonZerpElem(int a[][COLUMNS], int rows, int columns, int new_arr[]) {
	if (rows == 0 || columns == 0) return;

	for (int i = 0; i < rows; ++i) {
		int mult = 1;

		for (int j = 0; j < columns; ++j) {
			if (a[i][j] != 0) mult *= a[i][j];
		}

		new_arr[i] = mult;
	}
}



int main(int argc, char* argv[]) {

	setlocale(LC_ALL, "russian");

	if (argc < 2) {
		printf("Неверное количество параметров!\n");
		return 1;
	}

	FILE* file = fopen(argv[1], "r");

	if (!file) {
		printf("Невозможно открыть файл для чтения\n");
		return 2;
	}


	int f_rows = 0;
	int f_columns = 0;

	int first[ROWS][COLUMNS];
	getMatrixFromFile(file, first, &f_rows, &f_columns);

	printf("______Матрица 1_____\n");
	printMatrix(first, f_rows, f_columns);

	int s_rows = 0;
	int s_columns = 0;

	int second[ROWS][COLUMNS];
	getMatrixFromFile(file, second, &s_rows, &s_columns);

	printf("_____Матрица 2_____\n");
	printMatrix(second, s_rows, s_columns);



	int first_zeroCount = zeroCount_matrix(first, f_rows, f_columns);
	printf("%i\n", first_zeroCount);

	int second_zeroCount = 0;
	for (int i = 0; i < s_rows; ++i) second_zeroCount += zeroCount_array(second[i], s_columns);
	printf("%i\n", second_zeroCount);

	int minelem = (first_zeroCount < second_zeroCount) + 1;
	
	int arr[ROWS];
	if (minelem == 1) {
		printf("Первая матрица имеет меньшее количество отрицательных элементов: %i, произведение ненулевых элементов в каждой строке: ", first_zeroCount);
		multOfNonZerpElem(first, f_rows, f_columns, arr);
		printArray(arr, f_rows);
	}
	else {
		printf("Вторая матрица имеет меньшее количество отрицательных элементов: %i, произведение ненулевых элементов в каждой строке: ", second_zeroCount);
		multOfNonZerpElem(second, s_rows, s_columns, arr);
		printArray(arr, s_rows);
	}

	fclose(file);

	return 0;
}