#include "DynamicArray.h"


bool DynamicArray::getFromFile(std::ifstream& ifile) {
	if (!ifile.is_open()) return false;

	m_capacity = 5;
	m_data = new (std::nothrow) double[m_capacity];

	double element{};

	while (true) {
		st i{ 0 };

		while (!isNewLine(ifile) && !ifile.eof()) {
			if (ifile >> element) {
				std::cout << element << ' ';
				m_data[i] = element;
				std::cout << m_data[i] << '\n';
				++i;

				++m_size;
				if (m_size >= m_capacity) {
					m_capacity *= 2;
					m_data = new (std::nothrow) double[m_capacity];
				}
			}
			else break;
		}
		
		if (m_columns == 0) m_columns = i;
		else if (m_columns != i) {
			std::cerr << "Неверный формат матрицы!\n";
			return false;
		}
		if (m_columns != 0) ++m_rows;

		char ch{};
		ifile.get(ch);
		if (isNewLine(ifile) || ifile.eof()) return true;
	}
}



void printMatrix(const DynamicArray& da) {
	for (DynamicArray::st i{ 0 }; i < da.m_rows; ++i) {
		for (DynamicArray::st j{ 0 }; j < da.m_columns; ++j) {
			std::cout << da.get(i, j) << ' ';
		}

		std::cout << '\n';
	}
}