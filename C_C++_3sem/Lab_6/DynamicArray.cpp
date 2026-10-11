#include "DynamicArray.h"


bool DynamicArray::getFromFile(std::ifstream& ifile) {
	if (!ifile.is_open()) return false;

	clear();

	m_capacity = 5;
	m_data = new (std::nothrow) double[m_capacity];

	double element{};

	while (true) {

		while (!isNewLine(ifile) && !ifile.eof()) {
			if (ifile >> element) {
				if (!(m_size < m_capacity)) {
					m_capacity *= 2;

					double* temp{ m_data };
					m_data = new (std::nothrow) double[m_capacity];
					copy(temp);
				}

				m_data[m_size] = element;
				++m_size;
			}
			else return false;
		}
		if (m_size == 0) return false;

		//std::cout << m_size << ' ' << m_columns << '\n';
		
		if (m_columns == 0) m_columns = m_size;
		else if (m_size % m_columns != 0) return false;
		
		++m_rows;

		char ch{};
		ifile.get(ch);
		if (isNewLine(ifile) || ifile.eof()) {

			ifile.get(ch);
			return true;
		}
	}
}


std::ostream& operator<<(std::ostream& out, const DynamicArray& da) {
	if (da.m_size == 0) out << "_____Матрица пуста_____";

	for (DynamicArray::Size i{ 0 }; i < da.m_rows; ++i) {
		for (DynamicArray::Size j{ 0 }; j < da.m_columns; ++j) {
			out << da.get(i, j).value() << ' ';
		}

		out << '\n';
	}

	return out;
}