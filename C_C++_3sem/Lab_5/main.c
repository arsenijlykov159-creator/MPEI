#include <stdio.h>
#include <locale.h>
#include "Array.h"





int main(int argc, char* argv[]) {

	setlocale(LC_ALL, "russian");

	if (argc < 3) {
		printf("Недостаточно параметров!\n");
		return 1;
	}

	FILE* ifile = fopen(argv[1], "r");

	if (!ifile) {
		printf("Невозможно открыть входной файл!\n");
		return 2;
	}

	Array array_1 = { 0 };
	getArray(ifile, &array_1);

	Array array_2 = { 0 };
	getArray(ifile, &array_2);

	Array array_3 = { 0 };
	getArray(ifile, &array_3);

	



	fclose(ifile);


	FILE* ofile = fopen(argv[2], "w");

	if (!ofile) {
		printf("Невозможно открыть выходной файл!\n");
		return 3;
	}

	printArray(ofile, &array_1);
	free(array_1.data);

	printArray(ofile, &array_2);
	free(array_2.data);

	printArray(ofile, &array_3);
	free(array_3.data);

	fclose(ofile);

	return 0;
}