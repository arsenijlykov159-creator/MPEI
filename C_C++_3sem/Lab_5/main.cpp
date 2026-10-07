#include <stdio.h>
#include <locale.h>
#include "Array.h"
#include <utility>
#include <cmath>



int getDouble(FILE* input_file, double* value) {
	if (!input_file) return 0;

	return (fscanf_s(input_file, "%lf", value) == 1);
}



int main(int argc, char* argv[]) {

	setlocale(LC_ALL, "russian");

	if (argc < 3) {
		printf("Недостаточно параметров!\n");
		return 1;
	}

	FILE* ifile;
	fopen_s(&ifile, argv[1], "r");

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

	if (array_1.size == 0 || array_2.size == 0 || array_3.size == 0) {
		printf("Один из массивов содержит недопустимые символы!\n");
		clearArray(&array_1);
		clearArray(&array_2);
		clearArray(&array_3);
		return 3;
	}

	double input_value = 0;
	if (!getDouble(ifile, &input_value)) {
		printf("Не удалось прочитать число для сравнения!\n");
		clearArray(&array_1);
		clearArray(&array_2);
		clearArray(&array_3);
		return 4;
	}


	fclose(ifile);





	FILE* ofile;
	fopen_s(&ofile, argv[2], "w");

	if (!ofile) {
		printf("Невозможно открыть выходной файл!\n");
		clearArray(&array_1);
		clearArray(&array_2);
		clearArray(&array_3);
		return 5;
	}

	fprintf(ofile, "1) ");
	printArrayToFile(ofile, &array_1);
	//printArrayInfo(&array_1);

	fprintf(ofile, "2) ");
	printArrayToFile(ofile, &array_2);
	//printArrayInfo(&array_2);

	fprintf(ofile, "3) ");
	printArrayToFile(ofile, &array_3);
	//printArrayInfo(&array_3);


	int result_1 = countElemMoreThan(&array_1, input_value, static_cast<cFcn>(std::sqrt));
	int result_2 = countElemMoreThan(&array_2, input_value, &comprFcn);
	auto compare = [](double a) {return std::sqrt(a); };
	int result_3 = countElemMoreThan(&array_3, input_value, compare);


	fprintf(ofile, "Количество элементов массивов, больших заданного числа %lf:  %d  -  ", input_value, result_1);
	fprintf(ofile, "%d  -  ", result_2);
	fprintf(ofile, "%d;", result_3);
	fprintf(ofile, "\n");

	int max_result = max(result_1, max(result_2, result_3));

	if (result_1 == result_2 && result_1 == result_3) fprintf(ofile, "Во всех массивах одинаковое количество элементов, больших заданного числа %lf: %i\n", input_value, result_1);
	else if (result_1 > result_3 && result_1 == result_2) fprintf(ofile, "Максимальное число элементов, больших заданного числа %lf, имеют массивы 1 и 2: %i", input_value, result_1);
	else if (result_1 > result_2 && result_1 == result_3) fprintf(ofile, "Максимальное число элементов, больших заданного числа %lf, имеют массивы 1 и 3: %i", input_value, result_1);
	else if (result_2 > result_1 && result_2 == result_3) fprintf(ofile, "Максимальное число элементов, больших заданного числа %lf, имеют массивы 2 и 3: %i", input_value, result_2);
	else if (result_1 == max_result) fprintf(ofile, "Максимальное число элементов, больших заданного числа %lf, имеет массив 1: %i", input_value, result_1);
	else if (result_2 == max_result) fprintf(ofile, "Максимальное число элементов, больших заданного числа %lf, имеет массив 2: %i", input_value, result_2);
	else if (result_3 == max_result) fprintf(ofile, "Максимальное число элементов, больших заданного числа %lf, имеет массив 3: %i", input_value, result_3);

	fclose(ofile);

	clearArray(&array_1);
	clearArray(&array_2);
	clearArray(&array_3);

	return 0;
}