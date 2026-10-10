#include <iostream>
#include <fstream>
#include <clocale>
#include "DynamicArray.h"



int main(int argc, char* argv[]) {

	setlocale(LC_ALL, "russian");

	if (argc < 3) {
		std::cerr << "Недостатчоно параметров!\n";
		return 1;
	}

	std::ifstream input_file{ argv[1], std::ios::in };

	if (!input_file.is_open()) {
		std::cerr << "Входной файл не может быть открыт на запись!\n";
		return 2;
	}

	DynamicArray dynArr{};

	if (!dynArr.getFromFile(input_file)) {
		std::cerr << "Неверный формат матрицы!\n";
		dynArr.clear();
		return 3;
	}

	dynArr.print();


	DynamicArray dynArr_2{};

	if (!dynArr_2.getFromFile(input_file)) {
		std::cerr << "Неверный формат матрицы!\n";
		dynArr_2.clear();
		return 3;
	}

	dynArr_2.print();


	input_file.close();

	return 0;
}