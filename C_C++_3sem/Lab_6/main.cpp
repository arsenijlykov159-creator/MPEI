#include <iostream>
#include <fstream>
#include <clocale>
#include "DynamicArray.h"




int zeroCount(const DynamicArray& da) {
	if (!da.m_data) return 0;

	int z_count{};
	for (DynamicArray::Size i{ 0 }; i < da.m_size; ++i) {
		z_count += (da.m_data[i] == 0);
	}

	return z_count;
}


int zeroCount_row(const DynamicArray::Data_ptr da_row, DynamicArray::Size row_size) {
	if (row_size == 0 || !da_row) return 0;

	int z_count{};
	for (DynamicArray::Size i{ 0 }; i < row_size; ++i) {
		z_count += (da_row[i] == 0);
	}

	return z_count;
}





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

	DynamicArray dynArr_1{};
	if (!dynArr_1.getFromFile(input_file)) {
		std::cerr << "Неверный формат матрицы!\n";
		dynArr_1.clear();
		return 3;
	}

	std::cout << zeroCount(dynArr_1) << '\n';
	

	dynArr_1.print();

	

	DynamicArray dynArr_2{};
	if (!dynArr_2.getFromFile(input_file)) {
		std::cerr << "Неверный формат матрицы!\n";
		dynArr_2.clear();
		return 3;
	}

	int zero_count_2{};
	for (DynamicArray::Size i{ 0 }; i < dynArr_2.rows(); ++i) {
		zero_count_2 += zeroCount_row(dynArr_2.getRow(i), dynArr_2.columns());
	}

	std::cout << zero_count_2 << '\n';

	dynArr_2.print();

	


	input_file.close();

	dynArr_1.clear();
	dynArr_2.clear();

	return 0;
}