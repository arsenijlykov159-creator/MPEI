#include "Matrix.h"


Matrix::Matrix(Size rows, Size columns) : m_rows{ rows }, m_columns{ columns }, m_capacity{ m_rows * m_columns } {
	if (m_capacity > 0) m_data = new (std::nothrow) int[m_capacity];

	std::cout << "Вызван конструктор умолчания/создания матрицы по размерам!\n";
}

Matrix::Matrix(const Matrix& matrix, int value) : m_rows{ matrix.m_rows }, m_columns{ matrix.m_columns }, m_capacity{ m_rows * m_columns } {
	m_data = new (std::nothrow) int[m_capacity];
	if (!m_data) return;

	for (Size i{ 0 }; i < m_rows; ++i) {
		for (Size j{ 0 }; j < m_columns; ++j) {
			m_data[i * m_columns + j] = matrix[i][j] + value;
		}
	}

	std::cout << "Вызван конструктор копирования!\n";
}

Matrix::Matrix(Matrix&& other_data) noexcept : m_rows{ other_data.m_rows }, m_columns{ other_data.m_columns }, m_capacity{ m_capacity > other_data.m_capacity ? m_capacity : other_data.m_capacity } {
	m_data = other_data.m_data;
	other_data.m_data = nullptr;

	std::cout << "Вызван конструктор перемещения!\n";
}

Matrix::Matrix(int value) : m_rows{ 1 }, m_columns{ 1 }, m_capacity{ 1 } {
	m_data = new (std::nothrow) int[1];
	if (!m_data) return;
	*m_data = value;

	std::cout << "Вызван конструктор с одним параметром int!\n";
}

Matrix::~Matrix() {
	clear();

	std::cout << "Вызван деструктор!\n";
}



std::istream& operator>>(std::istream& in, Matrix& matrix) {
	if (matrix.m_rows <= 0 || matrix.m_columns <= 0) {
		in.setstate(std::ios_base::failbit);
		return in;
	}

	for (Matrix::Size i{ 0 }; i < matrix.m_rows; ++i) {
		for (Matrix::Size j{ 0 }; j < matrix.m_columns; ++j) {
			in >> matrix[i][j];
		}
	}

	if (!in) matrix.clear();

	return in;
}

std::ostream& operator<<(std::ostream& out, const Matrix& matrix) {
	std::cout << matrix.m_rows << ' ' << matrix.m_columns << ' ' << matrix.m_capacity << '\n';
	if (!matrix.m_data) return out;

	for (Matrix::Size i{ 0 }; i < matrix.m_rows; ++i) {
		for (Matrix::Size j{ 0 }; j < matrix.m_columns; ++j) {
			out << matrix.m_data[i * matrix.m_columns + j] << ' ';
		}
		out << '\n';
	}
	return out;
}



Matrix operator+(const Matrix& m1, const Matrix& m2) {
	assert(m1.m_rows == m2.m_rows && m1.m_columns == m2.m_columns && "Невозможно сложить матрицы разных размеров");

	Matrix temp{m1.m_rows, m2.m_columns};

	for (Matrix::Size i{ 0 }; i < m1.m_rows; ++i) {
		for (Matrix::Size j{ 0 }; j < m1.m_columns; ++j) {
			temp[i][j] = m1[i][j] + m2[i][j];
		}
	}

	return temp;
}