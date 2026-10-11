#include <iostream>
#include <fstream>
#include <clocale>
#include <vector>
#include "DynamicArray.h"




int zeroCount(const DynamicArray& da) {
	if (!da.dataPtr() || da.size() == 0) return 0;

	int z_count{};
	auto size{ da.size() };
	for (DynamicArray::Size i{ 0 }; i < size; ++i) {
		z_count += (da.dataPtr()[i] == 0);
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


void multNonZero(const DynamicArray& da, std::vector<double>& res_arr) {
	if (!da.dataPtr() || da.size() == 0) return;

	double mult{ 1 };

	auto rows{ da.rows() };
	auto columns{ da.columns() };
	for (DynamicArray::Size i{ 0 }; i < rows; ++i) {
		for (DynamicArray::Size j{ 0 }; j < columns; ++j) {
			mult *= da.get(i, j).value();
		}

		res_arr.push_back(mult);
	}
}


std::ostream& operator<<(std::ostream& out, const std::vector<int>& v) {
	for (const auto& element : v) out << element;

	return out;
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

	//Первая матрица
	DynamicArray dynArr_1{};
	if (!dynArr_1.getFromFile(input_file)) {
		std::cerr << "Неверный формат матрицы 1!\n";
		dynArr_1.clear();
		return 3;
	}

	//Вторая матрица
	DynamicArray dynArr_2{};
	if (!dynArr_2.getFromFile(input_file)) {
		std::cerr << "Неверный формат матрицы 2!\n";
		dynArr_1.clear();
		dynArr_2.clear();
		return 3;
	}

	input_file.close();



	std::cout << dynArr_1 << '\n';
	std::cout << dynArr_2 << '\n';



	int zero_count_1{ zeroCount(dynArr_1) };

	int zero_count_2{};
	for (DynamicArray::Size i{ 0 }; i < dynArr_2.rows(); ++i) {
		zero_count_2 += zeroCount_row(dynArr_2.getRow(i), dynArr_2.columns());
	}

	
	std::vector<double> result{};
	if (zero_count_1 < zero_count_2) multNonZero(dynArr_1, result);
	else multNonZero(dynArr_2, result);

	if (result.empty()) {
		std::cerr << "Что-то пошло не так!\n";
		dynArr_1.clear();
		dynArr_2.clear();
		return 4;
	}


	dynArr_1.clear();
	dynArr_2.clear();

	return 0;
}