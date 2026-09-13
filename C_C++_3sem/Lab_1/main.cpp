#include <iostream>
#include <fstream>
#include <clocale>
#include <algorithm>


namespace Constants {
	constexpr int length_1{ 5 };
	constexpr int length_2{ 6 };
	constexpr int length_3{ 8 };
}


int getInt(std::ifstream& f);

void getArray(std::ifstream& f, int a[], int length);

void printArray(int a[], int length);

int countMoreThan(int a[], int length, int value);




int main(int argc, char* argv[]) {

	std::setlocale(LC_ALL, "");

	if (argc < 2) {
		std::cerr << "Неверное количество параметров!\n";
		return 1;
	}

	std::ifstream file{ argv[1]};

	if (!file.is_open()) {
		std::cerr << "Файл не может быть открыт для чтения!\n";
		return 2;
	}



	int arr_1[Constants::length_1];
	getArray(file, arr_1, Constants::length_1);
	std::cout << "1) ";
	printArray(arr_1, Constants::length_1);

	std::cout << '\n';

	int arr_2[Constants::length_2];
	getArray(file, arr_2, Constants::length_2);
	std::cout << "2) ";
	printArray(arr_2, Constants::length_2);

	std::cout << '\n';

	int arr_3[Constants::length_3];
	getArray(file, arr_3, Constants::length_3);
	std::cout << "3) ";
	printArray(arr_3, Constants::length_3);

	std::cout << "\n\n";



	int value{ getInt(file) };

	std::cout << "Заданное число: " << value << "\n\n";



	int result_1{ countMoreThan(arr_1, Constants::length_1, value) };
	int result_2{ countMoreThan(arr_2, Constants::length_2, value) };
	int result_3{ countMoreThan(arr_3, Constants::length_3, value) };

	int max_result{ std::max( {result_1, result_2, result_3} )};

	if (result_1 == result_2 && result_1 == result_3) printf("Во всех массивах одинаковое количество элементов, больших заданного числа %i: %i", value, result_1);
	else if (result_1 > result_3 && result_1 == result_2) printf("Максимальное число элементов, больших заданного числа %i, имеет массивы 1 и 2: %i", value, result_1);
	else if (result_1 > result_2 && result_1 == result_3) printf("Максимальное число элементов, больших заданного числа %i, имеет массивы 1 и 3: %i", value, result_1);
	else if (result_2 > result_1 && result_2 == result_3) printf("Максимальное число элементов, больших заданного числа %i, имеет массивы 2 и 3: %i", value, result_1);
	else if (result_1 == max_result) printf("Максимальное число элементов, больших заданного числа %i, имеет массив 1: %i", value, result_1);
	else if (result_2 == max_result) printf("Максимальное число элементов, больших заданного числа %i, имеет массив 2: %i", value, result_2);
	else if (result_3 == max_result) printf("Максимальное число элементов, больших заданного числа %i, имеет массив 3: %i", value, result_3);
	std::cout << "\n\n";


	file.close();

	return 0;
}


int countMoreThan(int a[], int length, int value) {
	if (length == 0) return 0;

	int count{};
	for (int i{ 0 }; i < length; ++i) {
		if (a[i] > value) ++count;
	}

	return count;
}


void printArray(int a[], int length) {
	if (length == 0) return;

	for (int i{ 0 }; i < length; ++i) {
		std::cout << a[i] << ' ';
	}
}


void getArray(std::ifstream& f, int a[], int length) {
	for (int i{ 0 }; i < length; ++i) {
		if (!f.eof())
			f >> a[i];
		else return;
	}
}


int getInt(std::ifstream& f) {
	int value{};
	if (!f.eof()) f >> value;

	return value;
}