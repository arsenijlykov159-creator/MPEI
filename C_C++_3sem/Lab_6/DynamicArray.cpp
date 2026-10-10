#include "DynamicArray.h"


bool DynamicArray::getFromFile(std::ifstream& ifile) {
	if (!ifile.is_open()) return false;

	clear();

	m_capacity = 7;
	m_data = new (std::nothrow) double[m_capacity];

	double element{};

	while (true) {
		st i{ 0 };

		while (!isNewLine(ifile) && !ifile.eof()) {
			if (ifile >> element) {
				if (!(m_size < m_capacity)) {
					m_capacity *= 2;

					double* temp{ m_data };
					m_data = new (std::nothrow) double[m_capacity];
					copy(temp);
				}

				m_data[m_size] = element;
				++i;
				++m_size;
			}
			else return false;
		}
		if (i == 0) return true;
		
		if (m_columns == 0) m_columns = i;
		else if (m_columns != i) return false;
		
		++m_rows;

		char ch{};
		ifile.get(ch);
		if (isNewLine(ifile) || ifile.eof()) {
			ifile.get(ch);
			return true;
		}
	}
}



void DynamicArray::print() const {
	if (m_rows == 0) std::cout << "_____Матрица пуста_____";

	for (DynamicArray::st i{ 0 }; i < m_rows; ++i) {
		for (DynamicArray::st j{ 0 }; j < m_columns; ++j) {
			std::cout << get(i, j).value() << ' ';
		}

		std::cout << '\n';
	}
}