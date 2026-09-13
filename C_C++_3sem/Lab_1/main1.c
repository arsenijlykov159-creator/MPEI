#include <stdio.h>
#include <locale.h>
#define LENGTH_1 5
#define LENGTH_2 5
#define LENGTH_3 8


void getArray(FILE* f, int a[], int length) {
	for (int i = 0; i < length; ++i) {
		fscanf_s(f, "%i ", &a[i]);
	}
}


void printArray(int a[], int length) {
	if (length == 0) return;

	for (int i = 0; i < length; ++i) {
		printf("%i ", a[i]);
	}

	printf("\n");
}


int getInt(FILE* f) {
	int value = 0;
	fscanf_s(f, "%i", &value);

	return value;
}


int countMoreThan(int a[], int length, int value) {
	if (length == 0) return 0;

	int count = 0;
	for (int i = 0; i < length; ++i) {
		if (a[i] > value) ++count;
	}

	return count;
}


int maxInt(int x, int y) {
	return (x > y ? x : y);
}



int main(int argc, const char* argv[]) {
	
	setlocale(LC_ALL, "");

	if (argc < 2) {
		printf("Недостаточное количество параметров!\n");
		return 1;
	}

	FILE* file = fopen(argv[1], "r");

	if (!file) {
		printf("Невозможно открыть файл для чтения!\n");
		return 2;
	}

	int arr_1[LENGTH_1];
	getArray(file, arr_1, LENGTH_1);
	printArray(arr_1, LENGTH_1);

	int arr_2[LENGTH_2];
	getArray(file, arr_2, LENGTH_2);
	printArray(arr_2, LENGTH_2);

	int arr_3[LENGTH_3];
	getArray(file, arr_3, LENGTH_3);
	printArray(arr_3, LENGTH_3);

	int value = getInt(file);

	printf("%i ", value);

	int result_1 = countMoreThan(arr_1, LENGTH_1, value);
	int result_2 = countMoreThan(arr_2, LENGTH_2, value);
	int result_3 = countMoreThan(arr_3, LENGTH_3, value);

	int max_result = maxInt(result_1, maxInt(result_2, result_3));

	if (result_1 == result_2 && result_1 == result_3) printf("Во всех массивах одинаковое количество элементов, больших заданного числа %i: %i\n", value, result_1);
	else if (result_1 > result_3 && result_1 == result_2) printf("Максимальное число элементов, больших заданного числа %i, имеет массивы 1 и 2: %i", value, result_1);
	else if (result_1 > result_2 && result_1 == result_3) printf("Максимальное число элементов, больших заданного числа %i, имеет массивы 1 и 3: %i", value, result_1);
	else if (result_2 > result_1 && result_2 == result_3) printf("Максимальное число элементов, больших заданного числа %i, имеет массивы 2 и 3: %i", value, result_2);
	else if (result_1 == max_result) printf("Максимальное число элементов, больших заданного числа %i, имеет массив 1: %i", value, result_1);
	else if (result_2 == max_result) printf("Максимальное число элементов, больших заданного числа %i, имеет массив 2: %i", value, result_2);
	else if (result_3 == max_result) printf("Максимальное число элементов, больших заданного числа %i, имеет массив 3: %i", value, result_3);

	fclose(file);

	return 0;
}