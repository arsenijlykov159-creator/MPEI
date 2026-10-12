#include "DynamicArray.h"
#include <vector>
#include <new>

//bool DynamicArray::getFromFile(std::ifstream& ifile) {
//	if (!ifile.is_open()) return false;
//
//	clear();
//
//	m_capacity = 5;
//	m_data = new (std::nothrow) double[m_capacity];
//
//	double element{};
//
//	while (true) {
//
//		while (!isNewLine(ifile) && !ifile.eof()) {
//			if (ifile >> element) {
//				if (!(m_size < m_capacity)) {
//					m_capacity *= 2;
//
//					double* temp{ m_data };
//					m_data = new (std::nothrow) double[m_capacity];
//					copy(temp);
//				}
//
//				m_data[m_size] = element;
//				++m_size;
//			}
//			else return false;
//		}
//		if (m_size == 0) return false;
//		
//		if (m_columns == 0) m_columns = m_size;
//		else if (m_size % m_columns != 0) return false;
//		
//		++m_rows;
//
//		char ch{};
//		ifile.get(ch);
//		if (isNewLine(ifile) || ifile.eof()) {
//
//			ifile.get(ch);
//			return true;
//		}
//	}
//}

std::istream& operator>>(std::istream& in, DynamicArray& da) {
	if (!in) return in;

	da.clear();

	da.m_capacity = 5;
	da.m_data = new (std::nothrow) double[da.m_capacity];

	double element{};

	while (true) {

		while (!da.isNewLine(in) && !in.eof()) {
			if (in >> element) {
				if (!(da.m_size < da.m_capacity)) {
					da.m_capacity *= 2;

					double* temp{ da.m_data };
					da.m_data = new (std::nothrow) double[da.m_capacity];
					da.copy(temp);
					delete[] temp;
				}

				da.m_data[da.m_size] = element;
				++da.m_size;

				if (in.peek() == EOF) {
					in.clear();
					break;
				}
			}
			else return in;
		}

		if (da.m_size == 0) {
			in.setstate(std::ios::failbit);
			return in;
		}

		if (da.m_columns == 0) da.m_columns = da.m_size;
		else if (da.m_size % da.m_columns != 0) {
			in.setstate(std::ios::failbit);
			return in;
		}

		++da.m_rows;

		if (in.peek() == EOF) {
			in.clear();
			return in;
		}

		char ch{};
		in.get(ch);
		if (da.isNewLine(in)) {
			in.clear();
			in.get(ch);
			return in;
		}
		else if (in.peek() == EOF) {
			in.clear();
			return in;
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